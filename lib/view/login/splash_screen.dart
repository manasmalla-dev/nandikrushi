import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushifarmer/controller/login_controller.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';
import 'package:nandikrushifarmer/view/login/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  LoginPageController? loginPageController;
  _SplashScreenState() : super(LoginPageController()) {
    loginPageController = controller as LoginPageController;
  }
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () async {
      log(FirebaseAuth.instance.currentUser!.uid.toString());
      loginPageController!.checkUser(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: thisController.scaffoldkey,
        backgroundColor: const Color(0xffDDF6DD),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: height(context) * 0.23,
                  child: Image.asset('assets/png/logo.png')),
            ],
          ),
        ));
  }
}
