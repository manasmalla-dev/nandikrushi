import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';
import 'package:nandikrushi_farmer/utils/server.dart';

class LoginProvider extends ChangeNotifier {
  bool shouldShowLoader = false;
  bool isEmail = false;
  bool get isEmailLogin =>
      Platform.isAndroid || Platform.isIOS ? isEmail : true;
  Map<String, Color> availableUserTypes = {};
  MapEntry<String, Color> userAppTheme = const MapEntry("", Color(0xFF006838));
  Map<String, String> languages = {
    "english": "english".toUpperCase(),
    "telugu": "తెలుగు",
    "hindi": "हिन्दी",
    "kannada": "ಕನ್ನಡ",
  };
  MapEntry<String, String> usersLanguage = const MapEntry("", "");
  updateUserAppType(MapEntry<String, Color> _) {
    userAppTheme = _;
    setAppTheme(_);
    notifyListeners();
  }

  updateLanguages(MapEntry<String, String> _) {
    usersLanguage = _;
    setUserLanguage(_);
    notifyListeners();
  }

  fetchUserTypes(Map<String, Color> _) {
    availableUserTypes = _;
    notifyListeners();
  }

  showLoader() {
    shouldShowLoader = true;
    notifyListeners();
  }

  hideLoader() {
    shouldShowLoader = false;
    notifyListeners();
  }

  void changeLoginMethod() {
    isEmail = !isEmail;
    notifyListeners();
  }

  Future<void> onLoginUser(
      bool isEmailProvider, LoginController loginController,
      {required Function(String, bool) onSuccessfulLogin}) async {
    if (isEmailProvider) {
      var isFormReady =
          loginController.emailFormKey.currentState?.validate() ?? false;
      if (isFormReady) {
        var response = await Server().postFormData(
          body: {
            'email': loginController.emailTextEditController.text.toString(),
            'password':
                loginController.passwordTextEditController.text.toString()
          },
          url:
              "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/emaillogin",
        );
        if (response?.statusCode == 200) {
          var decodedResponse =
              jsonDecode(response?.body ?? '{"message": {},"status": true}');
          if (decodedResponse["status"]) {
            log("Successful login");
            print(
                "User ID: ${decodedResponse["message"]["user_id"]}, Seller ID: ${decodedResponse["message"]["customer_id"]}");
            onSuccessfulLogin(
                capitalize(decodedResponse["message"]["firstname"]), true);
            hideLoader();
          } else {
            //TODO: handle the failure
            print("Failure: ${response?.body}");
            hideLoader();
          }
        } else {
          //TODO: Handle Server failure
        }
      } else {
        hideLoader();
      }
    } else {
      var isFormReady =
          loginController.mobileFormKey.currentState?.validate() ?? false;
      if (isFormReady) {
        //TODO: Use FirebaseAuth and authenticate with mobile number
        /* var response = await Server().postFormData(
          body: {
            'telephone': loginController.phoneTextEditController.text.toString()
          },
          url:
              "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/sellerlogin/verify_mobile",
        );
        print(response?.body);
        hideLoader(); */
      }
    }
  }
}
