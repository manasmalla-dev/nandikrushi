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
                    align: TextAlign.center,
                    size: height(context) * 0.02,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.012,
                ),
                Container(
                  width: width(context) * 0.85,
                  height: height(context) * 0.06,
                  color: Colors.white,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        width: numberController.text.isNotEmpty
                            ? width(context) * 0.09
                            : 0,
                        duration: const Duration(milliseconds: 250),
                        child: numberController.text.isNotEmpty
                            ? TextWidget(
                                text: '+91',
                                size: height(context) * 0.025,
                                weight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : const SizedBox(),
                      ),
                      Expanded(
                        child: FilledTextFieldWidget(
                          controller: numberController,
                          keyBoardType: TextInputType.number,
                          maxLength: 10,
                          borderRadius: 0,
                          label: "",
                          style: fonts(height(context) * 0.025, FontWeight.bold,
                              Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.005,
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
                      const SizedBox(
                        height: 4,
                      ),
                      const NandiKrushiTitle(
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
