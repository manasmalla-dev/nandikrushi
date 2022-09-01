import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_host.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/onboarding/onboarding.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';
import 'package:nandikrushi_farmer/utils/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ControllerMVC {
  GlobalKey<FormState> mobileFormKey = GlobalKey();
  GlobalKey<FormState> emailFormKey = GlobalKey();
  GlobalKey<FormState> otpFormKey = GlobalKey();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();
  GlobalKey<FormState> registrationFormKey = GlobalKey();
  GlobalKey<FormState> registrationFormSecondPageKey = GlobalKey();

  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController phoneTextEditController = TextEditingController();
  TextEditingController otpTextEditController = TextEditingController();
  TextEditingController forgotPasswordTextEditController =
      TextEditingController();
  var registrationPageFormControllers = {
    'first_name': TextEditingController(),
    'last_name': TextEditingController(),
    'house_number': TextEditingController(),
    'city': TextEditingController(),
    'mandal': TextEditingController(),
    'district': TextEditingController(),
    'state': TextEditingController(),
    'pincode': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'c_password': TextEditingController(),
    'telePhone': TextEditingController(),
    'storeName': TextEditingController(),
    'reg_number': TextEditingController(),
  };
  double landInAcres = 0;
  String userCertification = "";

  XFile? profileImage;
  XFile? storeLogo;

  PageController pageController = PageController();

  Position? location;
  List<Placemark>? locationGeoCoded;

  List<List<XFile>> userCertificates = [];

  Future<void> checkLocationPermissionAndGetLocation() async {
    var permissionGranted = await Geolocator.checkPermission();
    log("IsPermissionGranted: $permissionGranted");
    if (permissionGranted == LocationPermission.always ||
        permissionGranted == LocationPermission.whileInUse) {
      location = await Geolocator.getLastKnownPosition();
      log(location.toString());
      var isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      log(isLocationServiceEnabled.toString());
      if (isLocationServiceEnabled) {
        location = await Geolocator.getCurrentPosition();
        log(location.toString());
        geocodeLocation();
      } else {
        log("open settings");
        await Geolocator.openLocationSettings();
        checkLocationPermissionAndGetLocation();
      }
    } else {
      log("Entered location requester");
      Geolocator.requestPermission();
      checkLocationPermissionAndGetLocation();
    }
  }

  Future<void> geocodeLocation() async {
    locationGeoCoded =
        await placemarkFromCoordinates(location!.latitude, location!.longitude);
    log(locationGeoCoded.toString());
    registrationPageFormControllers["pincode"]?.text =
        locationGeoCoded?.first.postalCode ?? "";
    registrationPageFormControllers["state"]?.text =
        locationGeoCoded?.first.administrativeArea ?? "";
    registrationPageFormControllers["district"]?.text =
        locationGeoCoded?.first.subAdministrativeArea ?? "";
    registrationPageFormControllers["city"]?.text =
        locationGeoCoded?.first.locality ?? "";
    registrationPageFormControllers["house_number"]?.text =
        locationGeoCoded?.first.street ?? "";
    registrationPageFormControllers["mandal"]?.text =
        locationGeoCoded?.first.subLocality ?? "";
  }

  fetchUserData(context) {
    //TODO: Manage fetching data
    /* var provider = Provider.of<RegistrationProvider>(context, listen: false);
    log(provider.user.toString());
    formControllers = {
      'first_name': TextEditingController(text: provider.user?.firstName ?? ""),
      'house_number':
          TextEditingController(text: provider.user?.houseNumber ?? ""),
      'city': TextEditingController(text: provider.user?.city ?? ""),
      'mandal': TextEditingController(text: provider.user?.mandal ?? ""),
      'district': TextEditingController(text: provider.user?.district ?? ""),
      'state': TextEditingController(text: provider.user?.state ?? ""),
      'pincode': TextEditingController(text: provider.user?.pincode ?? ""),
      'email': TextEditingController(text: provider.user?.email ?? ""),
      'password': TextEditingController(text: provider.user?.pass ?? ""),
      'c_password': TextEditingController(text: provider.user?.cpass ?? ""),
      'telePhone': TextEditingController(text: provider.user?.telePhone ?? ""),
      'storeName': TextEditingController(
          text: provider.user?.certificationRegisterationNumber ?? ""),
    };*/
  }

  checkUser(BuildContext context,
      {required NavigatorState navigator,
      required Function(Function) onNewUser,
      required LoginProvider loginProvider}) async {
    var isReturningUser = await context.isReturningUser;

    if (FirebaseAuth.instance.currentUser != null || isReturningUser) {
      var appTheme = await getAppTheme();
      loginProvider.updateUserAppType(appTheme);
      Timer(const Duration(milliseconds: 2000), () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        var uID = sharedPreferences.getString('userID')!;
        var cID = sharedPreferences.getString('customerID')!;
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => NandikrushiNavHost(
                      userId: uID,
                      customerId: cID,
                    )),
            (route) => false);
      });
    } else {
      onNewUser(() {
        Timer(const Duration(milliseconds: 1000), () async {
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              (route) => false);
        });
      });
    }
  }

  Future<Map<String, Color>> getUserRegistrationData(context) async {
    var isTimedOut = false;
    var response = await Server()
        .getMethodParams(
      'http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/customergroups',
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      var userTypeData = {
        "Farmer": Theme.of(context).primaryColor,
        "Organic Stores": const Color(0xFF00bba8),
        "Organic Restaurants": const Color(0xFFffd500),
      };
      isTimedOut = true;
      return userTypeData;
    });

    if (!isTimedOut) {
      if (response.statusCode == 200) {
        log("sucess");
        log(response.body);
        List<dynamic> values = jsonDecode(response.body)["message"];
        var iterables = values.map(
          (e) => MapEntry(
            e["name"].toString(),
            //TODO: Use dynamic color instead of this logic
            e["name"].toString().contains("Farmer")
                ? Theme.of(context).primaryColor
                : e["name"].toString().contains("Store")
                    ? const Color(0xFF00bba8)
                    : const Color(0xFFffd500),
          ),
        );
        var userTypeData = {for (var e in iterables) e.key: e.value};

        return userTypeData;
      } else if (response.statusCode == 400) {
        snackbar(context, "Undefined Parameter when calling API");
        log("Undefined Parameter");
        var userTypeData = {
          "Farmer": Theme.of(context).primaryColor,
          "Organic Stores": const Color(0xFF00bba8),
          "Organic Restaurants": const Color(0xFFffd500),
        };
        return userTypeData;
      } else if (response.statusCode == 404) {
        snackbar(context, "API Not found");
        log("Not found");
        var userTypeData = {
          "Farmer": Theme.of(context).primaryColor,
          "Organic Stores": const Color(0xFF00bba8),
          "Organic Restaurants": const Color(0xFFffd500),
        };
        return userTypeData;
      } else {
        snackbar(context, "Failed to get data!");
        log("failure");
        var userTypeData = {
          "Farmer": Theme.of(context).primaryColor,
          "Organic Stores": const Color(0xFF00bba8),
          "Organic Restaurants": const Color(0xFFffd500),
        };
        return userTypeData;
      }
    } else {
      snackbar(context, "Failed to get data!");
      log("failure");
      var userTypeData = {
        "Farmer": Theme.of(context).primaryColor,
        "Organic Stores": const Color(0xFF00bba8),
        "Organic Restaurants": const Color(0xFFffd500),
      };
      return userTypeData;
    }
  }
}
