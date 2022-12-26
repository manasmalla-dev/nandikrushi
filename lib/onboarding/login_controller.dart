import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi/nav_host.dart';
import 'package:nandikrushi/nav_items/profile_provider.dart';
import 'package:nandikrushi/onboarding/login_provider.dart';
import 'package:nandikrushi/onboarding/onboarding.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/utils/custom_color_util.dart';

import 'package:nandikrushi/utils/server.dart';
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
  double landInAcres = 1;
  String userCertification = "";

  XFile? profileImage;
  XFile? storeLogo;

  PageController pageController = PageController();

  LatLng? location;
  List<Placemark>? locationGeoCoded;

  List<List<XFile>> userCertificates = [];

  Future<void> checkLocationPermissionAndGetLocation(
      BuildContext context) async {
    var permissionGranted = await Geolocator.checkPermission();
    log("IsPermissionGranted: $permissionGranted");
    if (permissionGranted == LocationPermission.always ||
        permissionGranted == LocationPermission.whileInUse) {
      var lastKnownLocation = await Geolocator.getLastKnownPosition();
      if (lastKnownLocation != null) {
        location =
            LatLng(lastKnownLocation.latitude, lastKnownLocation.longitude);
      }
      log(location.toString());
      var isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      log(isLocationServiceEnabled.toString());
      if (isLocationServiceEnabled) {
        var currentPosition = await Geolocator.getCurrentPosition();

        location = LatLng(currentPosition.latitude, currentPosition.longitude);

        log(location.toString());
        await geocodeLocation(context, location!.latitude, location!.longitude);
      } else {
        log("open settings");
        if (await Geolocator.openLocationSettings()) {
          await checkLocationPermissionAndGetLocation(context);
        }
      }
    } else {
      log("Entered location requester");
      await Geolocator.requestPermission();
      await checkLocationPermissionAndGetLocation(context);
    }
  }

  Future<void> geocodeLocation(
      BuildContext context, latitude, longitude) async {
    locationGeoCoded = await placemarkFromCoordinates(latitude, longitude);
    if (location?.latitude == 0 || location?.longitude == 0) {
      snackbar(context, "HALT on CRITICAL ERROR, location is empty");
      exit(0);
    }
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

  checkUser(
      {required Future<bool> isReturningUserFuture,
      required NavigatorState navigator,
      required Function(Function) onNewUser,
      required LoginProvider loginProvider}) async {
    var isReturningUser = await isReturningUserFuture;
    log("123->${isReturningUser}");
    if (FirebaseAuth.instance.currentUser != null && isReturningUser) {
      Timer(const Duration(milliseconds: 2000), () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        var uID = sharedPreferences.getString('userID')!;

        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (_) => NandikrushiNavHost(
              userId: uID,
            ),
          ),
        );
      });
    } else {
      if ((Platform.isAndroid || Platform.isIOS) && !isReturningUser) {
        onNewUser(() {
          Timer(const Duration(milliseconds: 1000), () async {
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                (route) => false);
          });
        });
      } else {
        Timer(const Duration(milliseconds: 2000), () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          var uID = sharedPreferences.getString('userID')!;

          navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => NandikrushiNavHost(
                        userId: uID,
                      )),
              (route) => false);
        });
      }
    }
  }

  Future<void> getDataFromProvider(ProfileProvider profileProvider) async {
    registrationPageFormControllers = {
      'first_name': TextEditingController(text: profileProvider.firstName),
      'last_name': TextEditingController(text: profileProvider.lastName),
      'email': TextEditingController(text: profileProvider.email),
      'password': TextEditingController(),
      'c_password': TextEditingController(),
      'telePhone': TextEditingController(
          text: profileProvider.telephone
              .replaceAll(" ", "")
              .replaceFirst("+91", "")),
      'reg_number': TextEditingController(),
    };
    //checkLocationPermissionAndGetLocation();

    notifyListeners();
    //TODO: Add Certificates
  }
}
