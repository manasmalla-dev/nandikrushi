import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_host.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/onboarding/onboarding.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';
import 'package:nandikrushi_farmer/utils/server.dart';

class LoginController extends ControllerMVC {
  GlobalKey<FormState> mobileFormKey = GlobalKey();
  GlobalKey<FormState> emailFormKey = GlobalKey();
  GlobalKey<FormState> otpFormKey = GlobalKey();

  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController phoneTextEditController = TextEditingController();
  TextEditingController otpTextEditController = TextEditingController();

  checkUser(BuildContext context,
      {required NavigatorState navigator,
      required Function(Function) onNewUser,
      required LoginProvider loginProvider}) async {
    var isReturningUser = await context.isReturningUser;

    if (FirebaseAuth.instance.currentUser != null || isReturningUser) {
      var appTheme = await getAppTheme();
      loginProvider.updateUserAppType(appTheme);
      Timer(const Duration(milliseconds: 2000), () async {
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const NandikrushiNavHost()),
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
        "Organic Restaraunt": const Color(0xFFffd500),
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
          "Organic Restaraunt": const Color(0xFFffd500),
        };
        return userTypeData;
      } else if (response.statusCode == 404) {
        snackbar(context, "API Not found");
        log("Not found");
        var userTypeData = {
          "Farmer": Theme.of(context).primaryColor,
          "Organic Stores": const Color(0xFF00bba8),
          "Organic Restaraunt": const Color(0xFFffd500),
        };
        return userTypeData;
      } else {
        snackbar(context, "Failed to get data!");
        log("failure");
        var userTypeData = {
          "Farmer": Theme.of(context).primaryColor,
          "Organic Stores": const Color(0xFF00bba8),
          "Organic Restaraunt": const Color(0xFFffd500),
        };
        return userTypeData;
      }
    } else {
      snackbar(context, "Failed to get data!");
      log("failure");
      var userTypeData = {
        "Farmer": Theme.of(context).primaryColor,
        "Organic Stores": const Color(0xFF00bba8),
        "Organic Restaraunt": const Color(0xFFffd500),
      };
      return userTypeData;
    }
  }
}
