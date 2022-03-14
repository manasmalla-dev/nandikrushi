import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/login_bg.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushifarmer/view/login/otp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFDD8),
        resizeToAvoidBottomInset: false,
        body: LoginBG(
          bottomWidget: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: width(context) * 0.04, bottom: width(context) * 0.06),
              height: height(context) * 0.5,
              width: width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width(context) * 0.85,
                    child: TextWidget(
                      text: "Enter your Mobile number to login",
                      color: Colors.grey[900],
                      weight: FontWeight.w800,
                      align: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.02,
                  ),
                  Container(
                    width: width(context) * 0.85,
                    height: height(context) * 0.06,
                    color: Colors.white,
                    child: const FilledTextFieldWidget(
                      keyBoardType: TextInputType.number,
                      maxLength: 10,
                      borderRadius: 0,
                      label: "",
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.03,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const OTPPage()),
                      );
                    },
                    minWidth: width(context) * 0.85,
                    height: height(context) * 0.06,
                    bgColor: Colors.green[900],
                    borderSideColor: Colors.green[900],
                    textColor: Colors.white,
                    buttonName: "GET OTP",
                    textSize: width(context) * 0.04,
                    trailingIcon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: width(context) * 0.045,
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.02,
                  ),
                  SizedBox(
                    width: width(context) * 0.85,
                    child: const TextWidget(
                      text:
                          "I agree to the terms and conditions of NandiKrushi",
                      color: Colors.white,
                      weight: FontWeight.w600,
                      align: TextAlign.justify,
                      flow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
