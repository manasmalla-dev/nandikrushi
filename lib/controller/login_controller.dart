import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushifarmer/model/login_model.dart';
import 'package:nandikrushifarmer/provider/login_provider.dart';
import 'package:nandikrushifarmer/provider/registration_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';
import 'package:nandikrushifarmer/view/login/onboard_screen.dart';
import 'package:nandikrushifarmer/view/login/otp.dart';
import 'package:nandikrushifarmer/view/login/registration.dart';
import 'package:provider/provider.dart';

import '../repo/api_methods.dart';

class LoginPageController extends ControllerMVC {
  String _verificationCode = "";
  var loginFormKey = GlobalKey<FormState>();
  var emailFormKey = GlobalKey<FormState>();
  var emailScaffoldKey = GlobalKey<ScaffoldState>();
  var loginscaffoldKey = GlobalKey<ScaffoldState>();
  // TextEditingController numberController = TextEditingController();

  TextEditingController loginnum = TextEditingController();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  late LoginModel loginModel;

  getUserRegistrationData(context, provider) async {
    var response = await Server().getMethodParams(
      'http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/customergroups',
    );
    if (response.statusCode == 200) {
      log("sucess");
      log(response.body);
      List<dynamic> values = json.decode(response.body)["message"];

      var userTypeData = values.map((e) => e["name"].toString()).toList();
      provider.getUserTypes(userTypeData);
    } else if (response.statusCode == 400) {
      snackbar(context, "Undefined Parameter when calling API");
      log("Undefined Parameter");
    } else if (response.statusCode == 404) {
      snackbar(context, "API Not found");
      log("Not found");
    } else {
      snackbar(context, "Failed to get data!");
      log("failure");
    }
    //getting api data dynamically
    //var server = Server();

    /*server.getMethodParams(
        'http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/customergroups',
        (response) {
      List<dynamic> values = json.decode(response.body)["message"];
      var provider = Provider.of<RegistrationProvider>(context, listen: false);
      var userTypeData = values.map((e) => e["name"].toString()).toList();
      provider.getUserTypes(userTypeData);
    });
    */
  }

  LoginPageController() {
    loginModel = LoginModel();
  }
  dataToOTP(BuildContext context, LoginProvider loginProvider) async {
    if (loginFormKey.currentState != null) {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        await loginProvider.setPhNumber(loginnum.text);
        // log(loginnum.toString());
        verifyPhone(context, loginProvider);
      } else {
        log('Invalid');
      }
    }
  }

  dataToEmail(BuildContext context) async {
    if (emailFormKey.currentState != null) {
      if (emailFormKey.currentState!.validate()) {
        emailFormKey.currentState!.save();
        //login
        log("email: ${emailController.text}");
        log("password: ${passwordController.text}");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => const RegistrationScreen(isPhoneOrEmail: 2)),
          ),
        );
      } else {
        log('Invalid');
      }
    } else {
      log("empty");
    }
  }

  verifyPhone(BuildContext context, LoginProvider loginProvider,
      {navigate = true}) async {
    loginProvider.resetTimer();
    loginProvider.setLoader(true, loadingValue: "Sending OTP .....");
    log("phnum ${loginProvider.phNumber}");
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${loginProvider.phNumber}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                // log("user already login");
                // checkUserRegistered(value.user.uid);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const RegistrationScreen(isPhoneOrEmail: 1)),
                    (route) => false);
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            log(e.message.toString());
            snackbar(context, e.message.toString());
            loginProvider.setLoader(false);
          },
          codeSent: (String verficationID, int? resendToken) {
            loginProvider.setLoader(false);
            loginProvider.setPhNumber(loginnum.text.toString());
            snackbar(context, "Otp send successfully ");

            _verificationCode = verficationID;
            loginProvider.setVerificationCode(verficationID);
            log("verfication code $_verificationCode");

            if (navigate) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OTPPage(
                      num: loginnum.text, vericationId: verficationID)));
            }
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            _verificationCode = verificationID;
            loginProvider.setVerificationCode(verificationID);
            log("verfication code $_verificationCode");
          },
          timeout: const Duration(seconds: 85));
    } catch (e) {
      log(e.toString());
      snackbar(context, e.toString());
      loginProvider.setLoader(false);
    }
  }

  loginUserWithOtp(
      otpValue, BuildContext context, LoginProvider loginProvider) async {
    log("verfication code ${loginProvider.verificationCode}");
    log(otpValue.toString());
    loginProvider.setLoader(true);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: loginProvider.verificationCode,
              smsCode: otpValue))
          .then((value) async {
        log(value.user.toString());
        if (value.user != null) {
          // log("${value.user}");
          // log("$value");
          loginProvider.setPhoneNumber(loginProvider.phNumber.toString());
          log("user already login");
          // String resp = await checkUserRegistered(value.user?.uid);
          // log("respp 122 $resp");
          loginProvider.setLoader(false);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => const RegistrationScreen(
                      isPhoneOrEmail: 1,
                    )),
          );
          // if (resp == "false") {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => StepperPersonalInfo()),
          //       (route) => false);
          // } else if (resp == "true") {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => GoogleNavBar()),
          //       (route) => false);
          // } else {
          //   snackbar(context, "Something went wrong");
          // }
        } else {
          loginProvider.setLoader(false);
          snackbar(context, "Something went wrong");
        }
      });
      // log("sekhar $sekhar");
    } catch (e) {
      FocusScope.of(context).unfocus();
      // log(e.toString());
      loginProvider.setLoader(false);
      snackbar(context, "something went wrong");
    }
  }

  checkUser(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const NavBar()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MyHomePage()),
          (route) => false);
    }
  }
}
