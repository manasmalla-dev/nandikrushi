import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/login_bg.dart';
import 'package:nandikrushifarmer/reusable_widgets/nandi_krushi_title.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/otp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    numberController.addListener(
      (() {
        setState(
          () {},
        );
      }),
    );
    return Scaffold(
        backgroundColor: const Color(0xFFFFFDD8),
        resizeToAvoidBottomInset: true,
        body: LoginBG(
          bottomWidget: Container(
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
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        width: numberController.text.length != 0
                            ? width(context) * 0.09
                            : 0,
                        duration: Duration(milliseconds: 250),
                        child: numberController.text.length != 0
                            ? TextWidget(
                                text: '+91',
                                size: height(context) * 0.03,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : SizedBox(),
                      ),
                      Expanded(
                        child: FilledTextFieldWidget(
                          controller: numberController,
                          keyBoardType: TextInputType.number,
                          maxLength: 10,
                          borderRadius: 0,
                          label: "",
                          style: fonts(height(context) * 0.03, FontWeight.bold,
                              Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.85,
                  child: TextWidget(
                    text: "${numberController.text.length}/10",
                    align: TextAlign.end,
                    size: height(context) * 0.02,
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
                  child: Column(
                    children: [
                      TextWidget(
                        text: "I agree to the terms and conditions of",
                        color: Colors.white,
                        weight: FontWeight.w600,
                        align: TextAlign.center,
                        flow: TextOverflow.visible,
                        size: width(context) * 0.045,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      NandiKrushiTitle(
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
