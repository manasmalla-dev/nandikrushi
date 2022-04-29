import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/login.dart';

Future signOut(
  BuildContext context,
) {
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: height(context) * 0.45,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                height: height(context) * 0.22,
                // child: SvgPicture.asset('assets/exit.svg')
              ),
              SizedBox(
                height: height(context) * 0.06,
                child: Center(
                  child: Text(
                    'Are Sure, You Want to Leave the App?',
                    style: fonts(width(context) * 0.04, FontWeight.w600,
                        Colors.grey[900]),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: ElevatedButtonWidget(
                    bgColor: SpotmiesTheme.primaryColor,
                    minWidth: width(context),
                    height: height(context) * 0.06,
                    textColor: Colors.white,
                    buttonName: 'Yes ,I Want to Leave',
                    textSize: width(context) * 0.05,
                    textStyle: FontWeight.w600,
                    borderRadius: 5.0,
                    borderSideColor: Colors.indigo[900],
                    // trailingIcon: Icon(Icons.share),
                    onClick: () async {
                      await FirebaseAuth.instance.signOut().then((action) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const Login()),
                            (route) => false);
                      }).catchError((e) {
                        log(e);
                      });
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: ElevatedButtonWidget(
                  bgColor: Colors.green[50],
                  minWidth: width(context),
                  height: height(context) * 0.06,
                  textColor: Colors.grey[900],
                  buttonName: 'Close',
                  textSize: width(context) * 0.05,
                  textStyle: FontWeight.w600,
                  borderRadius: 5.0,
                  borderSideColor: Colors.indigo[50],
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      });
}
