import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';
import 'package:nandikrushifarmer/view/login/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var a = [];
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () async {
      // ignore: unnecessary_null_comparison
      if (a != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const NavBar()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MyHomePage()),
            (route) => false);
      }
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
