import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nandikrushi/onboarding/login_controller.dart';
import 'package:nandikrushi/utils/custom_color_util.dart';
import 'package:nandikrushi/utils/login_utils.dart';
import 'package:nandikrushi/utils/server.dart';

class LoginProvider extends ChangeNotifier {
  bool shouldShowLoader = false;
  bool isEmail = false;
  bool get isEmailLogin =>
      Platform.isAndroid || Platform.isIOS ? isEmail : true;

  Map<String, String> languages = {
    "english": "english".toUpperCase(),
    "telugu": "తెలుగు",
    "hindi": "हिन्दी",
    "kannada": "ಕನ್ನಡ",
  };
  MapEntry<String, String> usersLanguage = const MapEntry("", "");

  String firebaseVerificationID = "";
  int? _resendToken;
  String phoneNumber = "";

  updateLanguages(MapEntry<String, String> _) {
    usersLanguage = _;
    setUserLanguage(_);
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
    required Function(String, bool, String, String) onSuccessfulLogin,
    required Function(String) onError,
    required Function(String) showMessage,
    required Function(Function(String)) navigateToOTPScreen,
    required Function onRegisterUser,
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
              "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/emaillogin",
        );

        onLoginWithServer(response, null, onSuccessfulLogin, onError, () {
          onError(
              "Oops! Can't register on this device. Please try on a mobile.");
        });
      } else {
        hideLoader();
      }
    } else {
      var isFormReady =
          loginController.mobileFormKey.currentState?.validate() ?? false;
      if (isFormReady) {
        phoneNumber = loginController.phoneTextEditController.text;
        log("Trying to login user");
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: "+91${loginController.phoneTextEditController.text}",
            verificationCompleted:
                (PhoneAuthCredential phoneAuthCredential) async {
              onLoginWithCredential(phoneAuthCredential, loginController,
                  onSuccessfulLogin, onError, onRegisterUser);
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
                    onSuccessfulLogin, onError, onRegisterUser);
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              firebaseVerificationID = verificationId;
              showMessage("OTP sent successfully");
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
      } else {
        hideLoader();
      }
    }
  }

  onLoginWithCredential(
      PhoneAuthCredential phoneAuthCredential,
      LoginController loginController,
      Function(String, bool, String, String) onSuccessfulLogin,
      Function(String) onError,
      Function onRegisterUser) async {
    log("Verification Completed");
    var firebaseUser =
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    if (firebaseUser.user != null) {
      //User is signed in with Firebase, checking with API
      var response = await Server().postFormData(
        body: {
          'telephone': loginController.phoneTextEditController.text.toString(),
          "device_token": Platform.isAndroid || Platform.isIOS
              ? await FirebaseMessaging.instance.getToken() ?? ""
              : ""
        },
        url:
            "https://nkweb.sweken.com//index.php?route=extension/account/purpletree_multivendor/api/customerlogin/verify_mobile",
      );
      onLoginWithServer(response, FirebaseAuth.instance.currentUser?.uid,
          onSuccessfulLogin, onError, onRegisterUser);
    }
  }

  onLoginWithServer(
      Response? response,
      String? uid,
      Function(String, bool, String, String) onSuccessfulLogin,
      Function(String) onError,
      Function onRegisterUser) {
    if (response?.statusCode == 200) {
      var decodedResponse =
          jsonDecode(response?.body ?? '{"message": {},"success": false}');

      print(response?.body ?? "");

      var statusCodeBody = false;

      if (decodedResponse["success"] != null) {
        statusCodeBody = decodedResponse["success"].toString().contains("true");
      } else {
        statusCodeBody = decodedResponse["status"].toString().contains("true");
      }

      if (statusCodeBody) {
        if (decodedResponse["message"].toString().contains("No Data Found") ||
            decodedResponse["message"]["status"].toString() != "1") {
          onRegisterUser();
          hideLoader();
        } else {
          log("Successful login");
          print(
              "User ID: ${decodedResponse["message"].toString().contains("user_id") ? decodedResponse["message"]["user_id"] : decodedResponse["customer_details"]["user_id"]}, Seller ID: ${decodedResponse["message"].toString().contains("customer_id") ? (decodedResponse["message"]?["customer_id"] ?? decodedResponse["customer_id"]) : decodedResponse["customer_details"]["customer_id"]}");

          onSuccessfulLogin(
              capitalize(
                  decodedResponse["message"].toString().contains("firstname")
                      ? decodedResponse["message"]["firstname"]
                      : decodedResponse["customer_details"]["firstname"]),
              true,
              decodedResponse["message"].toString().contains("user_id")
                  ? decodedResponse["message"]["user_id"]
                  : decodedResponse["customer_details"]["user_id"],
              decodedResponse["message"].toString().contains("customer_id")
                  ? (decodedResponse["message"]?["customer_id"] ??
                      decodedResponse["customer_id"])
                  : decodedResponse["customer_details"]["customer_id"]);
        }
      } else {
        if (decodedResponse["message"]
            .toString()
            .contains("Customer Not Found with this Mobile Number")) {
          onRegisterUser();
          hideLoader();
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

  Future<void> registerUser({
    required LoginController loginPageController,
    required Function(String, bool, String, String) onSuccess,
    required Function(String) onError,
  }) async {
    showLoader();

    //Farmer
    Map<String, String> body = {
      "user_id": FirebaseAuth.instance.currentUser?.uid ?? "",
      "firstname": loginPageController
              .registrationPageFormControllers["first_name"]?.text
              .toString() ??
          "",
      "lastname": loginPageController
              .registrationPageFormControllers["last_name"]?.text
              .toString() ??
          "",
      "email": loginPageController
              .registrationPageFormControllers["email"]?.text
              .toString() ??
          "",
      "telephone": phoneNumber,
      "password": loginPageController
              .registrationPageFormControllers["password"]?.text
              .toString() ??
          "",
      "confirm": loginPageController
              .registrationPageFormControllers["c_password"]?.text
              .toString() ??
          "",
      "device_token": Platform.isAndroid || Platform.isIOS
          ? await FirebaseMessaging.instance.getToken() ?? ""
          : ""
    };

    var registrationURL =
        "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/customerregister";

    var response = await Server()
        .postFormData(body: body, url: registrationURL)
        .catchError((e) {
      log("64$e");
    });

    if (response?.statusCode == 200) {
      var decodedResponse =
          jsonDecode(response?.body ?? '{"message": {},"success": false}');

      print(response?.body ?? "");

      var statusCodeBody =
          decodedResponse["success"].toString().contains("true");

      if (statusCodeBody) {
        log("Successful login");
        print(
            "User ID: ${decodedResponse["customer_details"]["user_id"]}, Seller ID: ${decodedResponse["customer_details"]["customer_id"]}");

        onSuccess(
            capitalize(decodedResponse["customer_details"]["firstname"]),
            true,
            FirebaseAuth.instance.currentUser?.uid ?? "",
            decodedResponse["customer_details"]["customer_id"]);
      } else {
        onError("Failed to login, error: ${decodedResponse["message"]}");
        hideLoader();
      }
    } else {
      onError("Oops! Couldn't log you in: ${response?.statusCode}");
      hideLoader();
    }
  }
}
