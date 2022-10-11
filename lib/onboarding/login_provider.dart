import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/firebase_storage_utils.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';
import 'package:nandikrushi_farmer/utils/server.dart';

class LoginProvider extends ChangeNotifier {
  bool shouldShowLoader = false;
  bool isEmail = false;
  bool get isEmailLogin =>
      Platform.isAndroid || Platform.isIOS ? isEmail : true;
  Map<String, Color> availableUserTypes = {};
  MapEntry<String, Color> userAppTheme = const MapEntry("", Color(0xFF006838));
  bool get isFarmer => userAppTheme.key.contains("Farmer");

  Map<String, String> languages = {
    "english": "english".toUpperCase(),
    "telugu": "తెలుగు",
    "hindi": "हिन्दी",
    "kannada": "ಕನ್ನಡ",
  };
  MapEntry<String, String> usersLanguage = const MapEntry("", "");

  List<String> get certificationList => isFarmer
      ? [
          'Self Declared Natural Farmer',
          'PGS India Green',
          'PGS India Organic',
          'Organic FPO',
          'Organic FPC',
          'Other Certification +'
        ]
      : userAppTheme.key.contains("Store")
          ? [
              'FSSAI',
              'Fire Safety License',
              'Certificate of Environmental Clearance',
              'Other Certification +'
            ]
          : [
              'FSSAI',
              'Eating House License',
              'Fire Safety License',
              'Certificate of Environmental Clearance',
              'Other Certification +'
            ];

  String firebaseVerificationID = "";
  int? _resendToken;
  String phoneNumber = "";

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
              "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/emaillogin",
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
          'telephone': loginController.phoneTextEditController.text.toString()
        },
        url:
            "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/sellerlogin/verify_mobile",
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
      log(response?.body ?? "");
      var statusCodeBody = false;
      if (decodedResponse["success"] != null) {
        statusCodeBody = decodedResponse["success"].toString().contains("true");
      } else {
        statusCodeBody = decodedResponse["status"].toString().contains("true");
      }
      if (statusCodeBody) {
        if (decodedResponse["message"].toString().contains("No Data Found")) {
          onRegisterUser();
          hideLoader();
        } else {
          log("Successful login");
          print(
              "User ID: ${uid ?? decodedResponse["message"]["user_id"]}, Seller ID: ${decodedResponse["message"]?["customer_id"] ?? decodedResponse["customer_id"]}");
          onSuccessfulLogin(
              capitalize(decodedResponse["message"]["firstname"]),
              true,
              decodedResponse["message"]["user_id"],
              decodedResponse["message"]?["customer_id"] ??
                  decodedResponse["customer_id"]);
          hideLoader();
        }
      } else {
        if (decodedResponse["message"].toString().contains("No Data Found")) {
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

    Map<String, String> userAddress = {
      "coordinates-x": (loginPageController.location?.latitude ?? 0).toString(),
      "coordinates-y":
          (loginPageController.location?.longitude ?? 0).toString(),
      "houseNumber": loginPageController
              .registrationPageFormControllers["house_number"]?.text
              .toString() ??
          "",
      "city": loginPageController.registrationPageFormControllers["city"]?.text
              .toString() ??
          "",
      "mandal": loginPageController
              .registrationPageFormControllers["mandal"]?.text
              .toString() ??
          "",
      "district": loginPageController
              .registrationPageFormControllers["district"]?.text
              .toString() ??
          "",
      "state": loginPageController
              .registrationPageFormControllers["state"]?.text
              .toString() ??
          "",
      "pincode": loginPageController
              .registrationPageFormControllers["pincode"]?.text
              .toString() ??
          ""
    };

    var sellerImageURL = await uploadFilesToCloud(
        loginPageController.profileImage,
        cloudLocation: "profile_pics");
    var storeLogoURL = "";
    if (!isFarmer) {
      storeLogoURL = await uploadFilesToCloud(loginPageController.storeLogo,
          cloudLocation: "logo");
    }
    List<String> certificatesURLs = [];
    if (loginPageController.userCertificates
        .where((element) => element.isEmpty)
        .isNotEmpty) {
      await Future.forEach<XFile>(
          loginPageController.userCertificates
              .firstWhere((element) => element.isNotEmpty), (element) async {
        String urlData = await uploadFilesToCloud(element,
            cloudLocation: "legal_docs", fileType: ".jpg");
        certificatesURLs.add(urlData);
      });
    }
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
      "agree": 1.toString(),
      "become_seller": 1.toString(),
      "seller_type": userAppTheme.key.toString(),
      "land": loginPageController.landInAcres.toString(),
      "seller_image": sellerImageURL.toString(),
      "additional_comments": "Farmer is the backbone of India",
      "additional_documents": loginPageController.userCertification,
      "upload_document": certificatesURLs
          .toString(), //TODO: Check with backend on how to parse data
      "store_address": userAddress.toString(),
      "store_status": 1.toString(),
      "language":
          (languages.entries.toList().indexOf(usersLanguage) + 1).toString(),
      // "agree": "1"
    };
    if (!isFarmer) {
      body.addEntries([
        MapEntry(
            "seller_storename",
            loginPageController
                    .registrationPageFormControllers["storeName"]?.text
                    .toString() ??
                ""),
        MapEntry(
          "store_logo",
          storeLogoURL.toString(),
        )
      ]);
    } else {
      body.addEntries([
        MapEntry("seller_storename",
            "${loginPageController.registrationPageFormControllers["first_name"]?.text.toString() ?? "XYZ"} ${loginPageController.registrationPageFormControllers["last_name"]?.text.toString() ?? "XYZ"}"),
        MapEntry(
          "store_logo",
          sellerImageURL,
        )
      ]);
    }

    var response = await Server()
        .postFormData(
            body: body,
            url:
                "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/register")
        .catchError((e) {
      log("64$e");
    });
    onLoginWithServer(response, FirebaseAuth.instance.currentUser?.uid,
        onSuccess, onError, () {});
  }
}
