import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushifarmer/controller/login_controller.dart';
import 'package:nandikrushifarmer/provider/login_provider.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/login_bg.dart';
import 'package:nandikrushifarmer/reusable_widgets/nandi_krushi_title.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<Login> {
  LoginProvider? loginProvider;
  LoginPageController? loginPageController;
  _LoginState() : super(LoginPageController()) {
    loginPageController = controller as LoginPageController;
  }

  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginPageController?.loginnum.addListener(
      (() {
        setState(
          () {},
        );
      }),
    );
    return Consumer<LoginProvider>(builder: (context, data, child) {
      return Scaffold(
          key: loginPageController!.loginscaffoldKey,
          backgroundColor: const Color(0xFFFFFDD8),
          resizeToAvoidBottomInset: true,
          body: Form(
            key: loginPageController!.loginFormKey,
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
                            width: loginPageController!.loginnum.text.isNotEmpty
                                ? width(context) * 0.09
                                : 0,
                            duration: const Duration(milliseconds: 250),
                            child: loginPageController!.loginnum.text.isNotEmpty
                                ? TextWidget(
                                    text: '+91',
                                    size: height(context) * 0.025,
                                    weight: FontWeight.bold,
                                    color: Colors.grey,
                                  )
                                : const SizedBox(),
                          ),
                          // Expanded(
                          //   child: FilledTextFieldWidget(
                          //     controller: loginPageController!.numberController,
                          //     keyBoardType: TextInputType.number,
                          //     maxLength: 10,
                          //     functionValidate: (value) {
                          //       if (value!.length != 10 && value!.empty) {
                          //         return 'Please Enter Valid Mobile Number';
                          //       }
                          //       return null;
                          //     },
                          //     borderRadius: 0,
                          //     label: "",
                          //     style: fonts(height(context) * 0.025,
                          //         FontWeight.bold, Colors.black),
                          //   ),
                          // ),
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {},
                              style: fonts(height(context) * 0.025,
                                  FontWeight.bold, Colors.black),
                              decoration: InputDecoration(
                                hintStyle: fonts(width(context) * 0.045,
                                    FontWeight.w600, Colors.grey[400]),
                                hintText: 'Phone number',
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(0)),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                              ),
                              validator: (value) {
                                if (value?.length != 10) {
                                  snackbar(context,
                                      "Please Enter Valid Mobile Number");
                                }
                                return null;
                              },
                              maxLength: 10,
                              keyboardAppearance: Brightness.dark,
                              buildCounter: (BuildContext context,
                                  {int? currentLength,
                                  int? maxLength,
                                  bool? isFocused}) {
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              controller: loginPageController!.loginnum,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.005,
                    ),
                    SizedBox(
                      width: width(context) * 0.85,
                      child: TextWidget(
                        text: "${loginPageController!.loginnum.text.length}/10",
                        align: TextAlign.end,
                        size: height(context) * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    ElevatedButtonWidget(
                      onClick: () async {
                        if (data.loader) return;
                        // log(loginPageController!.numberController.text);
                        await loginPageController!
                            .dataToOTP(context, loginProvider!);
                      },
                      minWidth: width(context) * 0.85,
                      height: height(context) * 0.06,
                      bgColor: SpotmiesTheme.primaryColor,
                      borderSideColor: SpotmiesTheme.primaryColor,
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
            ),
          ));
    });
  }
}
