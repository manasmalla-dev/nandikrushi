import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushi/controller/login_controller.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/login_bg.dart';
import 'package:nandikrushi/reusable_widgets/nandi_krushi_title.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({Key? key}) : super(key: key);

  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends StateMVC<LoginWithEmail> {
  LoginPageController? loginPageController;
  _LoginWithEmailState() : super(LoginPageController()) {
    loginPageController = controller as LoginPageController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD8),
      key: loginPageController?.emailScaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: loginPageController?.emailFormKey,
        child: LoginBG(
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
                    text: "Enter the credentials to login",
                    color: SpotmiesTheme.primaryColor,
                    weight: FontWeight.w800,
                    align: TextAlign.start,
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
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {},
                          style: fonts(height(context) * 0.02, FontWeight.bold,
                              Colors.black),
                          decoration: InputDecoration(
                            hintStyle: fonts(width(context) * 0.045,
                                FontWeight.w600, Colors.grey[400]),
                            hintText: 'Email Address',
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(0)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                          ),
                          validator: (value) {
                            if (value != null &&
                                !value.characters.contains("@") &&
                                !value.contains(".com")) {
                              snackbar(
                                  context, "Please Enter Valid Email Address");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: loginPageController?.emailController,
                        ),
                      )
                    ],
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
                      Expanded(
                        child: TextFormField(
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {},
                          style: fonts(height(context) * 0.025, FontWeight.bold,
                              Colors.black),
                          decoration: InputDecoration(
                            hintStyle: fonts(width(context) * 0.045,
                                FontWeight.w600, Colors.grey[400]),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(0)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                          ),
                          keyboardAppearance: Brightness.dark,
                          controller: loginPageController?.passwordController,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: SpotmiesTheme.primaryColor),
                      onPressed: () {
                        //Navigator.of(context).pop();
                      },
                      child: TextWidget(
                        text: "Forgot Password",
                        color: SpotmiesTheme.primaryColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: width(context) * 0.07,
                    )
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                ElevatedButtonWidget(
                  onClick: () async {
                    // log(loginPageController!.numberController.text);
                    loginPageController?.dataToEmail(context);
                  },
                  minWidth: width(context) * 0.85,
                  height: height(context) * 0.06,
                  bgColor: SpotmiesTheme.primaryColor,
                  borderSideColor: SpotmiesTheme.primaryColor,
                  textColor: Colors.white,
                  buttonName: "Login",
                  textSize: width(context) * 0.04,
                  trailingIcon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: width(context) * 0.045,
                  ),
                ),
                TextButton(
                  style:
                      TextButton.styleFrom(primary: SpotmiesTheme.primaryColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: TextWidget(
                    text: "or, Login With Mobile",
                    color: SpotmiesTheme.primaryColor,
                    weight: FontWeight.bold,
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
        ),
      ),
    );
  }
}

class SpotmiesTheme {
  static var primaryColor = Colors.green.shade900;
}
