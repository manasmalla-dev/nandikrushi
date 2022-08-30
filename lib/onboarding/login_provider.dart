import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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

  String firebaseVerificationID = "";
  int? _resendToken;

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
    bool isEmailProvider,
    LoginController loginController, {
    required Function(String, bool) onSuccessfulLogin,
    required Function(String) onError,
    required Function(String) showMessage,
    required Function(Function(String)) navigateToOTPScreen,
  }) async {
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

        onLoginWithServer(response, onSuccessfulLogin, onError);
      } else {
        hideLoader();
      }
    } else {
      var isFormReady =
          loginController.mobileFormKey.currentState?.validate() ?? false;
      if (isFormReady) {
        log("Trying to login user");
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: "+91${loginController.phoneTextEditController.text}",
            verificationCompleted:
                (PhoneAuthCredential phoneAuthCredential) async {
              onLoginWithCredential(phoneAuthCredential, loginController,
                  onSuccessfulLogin, onError);
            },
            verificationFailed: (FirebaseAuthException exception) {
              onError(
                  "Couldn't verify your phone number, Error: ${exception.message}");
              hideLoader();
            },
            codeSent: (String verificationId, int? resendToken) {
              firebaseVerificationID = verificationId;
              _resendToken = resendToken;
              showMessage("OTP sent successfully");
              //Navigate to OTP page
              navigateToOTPScreen((String otp) async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: otp);
                onLoginWithCredential(phoneAuthCredential, loginController,
                    onSuccessfulLogin, onError);
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              firebaseVerificationID = verificationId;
              showMessage("OTP sent successfully");
              //Navigate to OTP page
              navigateToOTPScreen((String otp) async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: otp);
                onLoginWithCredential(phoneAuthCredential, loginController,
                    onSuccessfulLogin, onError);
              });
            },
            forceResendingToken: _resendToken,
            timeout: const Duration(
              seconds: 60,
            ),
          );
        } catch (exception) {
          log("Verification Completed");
          onError("Couldn't verify your phone number, Error: $exception");
          hideLoader();
        }
      }
    }
  }

  onLoginWithCredential(
      PhoneAuthCredential phoneAuthCredential,
      LoginController loginController,
      Function(String, bool) onSuccessfulLogin,
      Function(String) onError) async {
    log("Verification Completed");
    var firebaseUser =
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    if (firebaseUser.user != null) {
      //User is signed in with Firebase, checking with API
      var response = await Server().postFormData(
        body: {
          'telephone': loginController.phoneTextEditController.text.toString()
        },
        url:
            "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/sellerlogin/verify_mobile",
      );
      onLoginWithServer(response, onSuccessfulLogin, onError);
    }
  }

  onLoginWithServer(
    Response? response,
    Function(String, bool) onSuccessfulLogin,
    Function(String) onError,
  ) {
    if (response?.statusCode == 200) {
      var decodedResponse =
          jsonDecode(response?.body ?? '{"message": {},"status": true}');
      if (decodedResponse["status"]) {
        if (decodedResponse["message"].toString().contains("No Data Found")) {
          //TODO: Send to registration screen
        } else {
          log("Successful login");
          log("User ID: ${decodedResponse["message"]["user_id"]}, Seller ID: ${decodedResponse["message"]["customer_id"]}");
          onSuccessfulLogin(
              capitalize(decodedResponse["message"]["firstname"]), true);
          hideLoader();
        }
      } else {
        if (decodedResponse["message"].toString().contains("No Data Found")) {
          //TODO: Send to registration screen
        } else {
          onError("Failed to login, error: ${decodedResponse["message"]}");
          hideLoader();
        }
      }
    } else {
      onError("Oops! Couldn't log you in: ${response?.statusCode}");
      hideLoader();
    }
  }
}
