// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/onboarding/login_bg.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/onboarding/otp_screen.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginPageController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, data, child) {
      return Scaffold(
          backgroundColor: const Color(0xFFFFFDD8),
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth < 600
                ? Form(
                    key: data.isEmailLogin
                        ? loginPageController.emailFormKey
                        : loginPageController.mobileFormKey,
                    child: LoginBG(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: getProportionateHeight(20, constraints),
                            bottom: getProportionateHeight(20, constraints)),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: LoginWidgetCompactScreens(
                              constraints: constraints,
                              loginPageController: loginPageController,
                              isEmail: data.isEmailLogin,
                              onChangeLoginMethod: () {
                                data.changeLoginMethod();
                              },
                              onLogin: (isEmail) {
                                data.showLoader();
                                data.onLoginUser(
                                  isEmail,
                                  loginPageController,
                                  onSuccessfulLogin: (name, isReturningUser) {
                                    snackbar(context,
                                        "Welcome ${isReturningUser ? "back" : "to the Nandikrushi family"}, $name!",
                                        isError: false);
                                  },
                                  onError: (error) {
                                    snackbar(context, error);
                                  },
                                  showMessage: (message) {
                                    snackbar(context, message, isError: false);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Form(
                    key: data.isEmailLogin
                        ? loginPageController.emailFormKey
                        : loginPageController.mobileFormKey,
                    child: LoginBG(
                        shouldHaveBottomPadding: false,
                        child: LoginWidgetLargeScreens(
                          constraints: constraints,
                          loginPageController: loginPageController,
                          isEmail: data.isEmailLogin,
                          onChangeLoginMethod: () {
                            data.changeLoginMethod();
                          },
                          onLogin: (isEmail) {
                            data.showLoader();
                            data.onLoginUser(
                              isEmail,
                              loginPageController,
                              onSuccessfulLogin: (name, isReturningUser) {
                                snackbar(context,
                                    "Welcome ${isReturningUser ? "back" : "to the Nandikrushi family"}, $name!",
                                    isError: false);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OTPScreen(
                                      phoneNumber: loginPageController
                                          .phoneTextEditController.text
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              onError: (error) {
                                snackbar(context, error);
                              },
                              showMessage: (message) {
                                snackbar(context, message, isError: false);
                              },
                            );
                          },
                        )),
                  );
          }));
    });
  }
}

class LoginWidgetCompactScreens extends StatefulWidget {
  final BoxConstraints constraints;
  final LoginController loginPageController;
  final bool isEmail;
  final Function onChangeLoginMethod;
  final Function(bool) onLogin;
  const LoginWidgetCompactScreens(
      {Key? key,
      required this.constraints,
      required this.loginPageController,
      this.isEmail = false,
      required this.onChangeLoginMethod,
      required this.onLogin})
      : super(key: key);

  @override
  State<LoginWidgetCompactScreens> createState() =>
      _LoginWidgetCompactScreensState();
}

class _LoginWidgetCompactScreensState extends State<LoginWidgetCompactScreens> {
  var shouldObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: widget.isEmail
              ? const EdgeInsets.symmetric(vertical: 6, horizontal: 12)
              : null,
          decoration: widget.isEmail
              ? BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10))
              : null,
          child: TextWidget(
            !widget.isEmail
                ? "Enter your mobile number"
                : "Enter the credentials to login",
            color: calculateContrast(
                        Theme.of(context).primaryColor, Colors.grey.shade900) >
                    3
                ? Colors.grey[900]
                : Colors.white,
            weight: FontWeight.w500,
            size: Theme.of(context).textTheme.bodyMedium?.fontSize,
          ),
        ),
        SizedBox(
          height: getProportionateHeight(12, widget.constraints),
        ),
        !widget.isEmail
            ? TextFormField(
                textInputAction: TextInputAction.done,
                onChanged: (_) {
                  setState(() {});
                },
                onFieldSubmitted: (_) {
                  widget.onLogin(widget.isEmail);
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefix: AnimatedContainer(
                      width: widget.loginPageController.phoneTextEditController
                              .text.isNotEmpty
                          ? 40
                          : 0,
                      duration: const Duration(milliseconds: 250),
                      child: widget.loginPageController.phoneTextEditController
                              .text.isNotEmpty
                          ? TextWidget(
                              '+91',
                              size: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                            )
                          : const SizedBox(),
                    ),
                    counterStyle: fonts(
                        Theme.of(context).textTheme.bodySmall?.fontSize,
                        FontWeight.normal,
                        Colors.white),
                    hintStyle: fonts(
                        Theme.of(context).textTheme.bodyMedium?.fontSize,
                        FontWeight.w500,
                        Colors.grey[400]),
                    prefixIcon: const Icon(Icons.phone_rounded),
                    hintText: 'Phone number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    isDense: true,
                    errorBorder: InputBorder.none),
                validator: (value) {
                  if (value?.length != 10) {
                    snackbar(context, "Please enter a valid mobile number");
                  }
                  return null;
                },
                maxLength: 10,
                keyboardType: TextInputType.phone,
                controller: widget.loginPageController.phoneTextEditController,
              )
            : TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  prefixIcon: const Icon(Icons.email_rounded),
                  hintStyle: fonts(
                      Theme.of(context).textTheme.bodyMedium?.fontSize,
                      FontWeight.w400,
                      Colors.grey[400]),
                  hintText: 'Email Address',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null ||
                      !value.characters.contains("@") ||
                      !value.contains(".com")) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: widget.loginPageController.emailTextEditController,
              ),
        widget.isEmail
            ? SizedBox(
                height: getProportionateHeight(10, widget.constraints),
              )
            : const SizedBox(),
        widget.isEmail
            ? TextFormField(
                obscureText: shouldObscureText,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  widget.onLogin(widget.isEmail);
                },
                decoration: InputDecoration(
                  suffixIcon: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        setState(() {
                          shouldObscureText = false;
                        });
                      }, //call this method when incontact
                      onTapUp: (TapUpDetails details) {
                        setState(() {
                          shouldObscureText = true;
                        });
                      }, //call this method when contact with screen is removed
                      child: const Icon(
                        Icons.remove_red_eye,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  prefixIcon: const Icon(Icons.lock_rounded),
                  hintStyle: fonts(
                      Theme.of(context).textTheme.bodyMedium?.fontSize,
                      FontWeight.normal,
                      Colors.grey[400]),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                keyboardAppearance: Brightness.dark,
                controller:
                    widget.loginPageController.passwordTextEditController,
              )
            : const SizedBox(),
        SizedBox(
          height: getProportionateHeight(
              widget.isEmail ? 10 : 0, widget.constraints),
        ),
        widget.isEmail
            ? Row(
                children: [
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      //Navigator.of(context).pop();
                    },
                    child: TextWidget(
                      "Forgot Password",
                      color: Theme.of(context).primaryColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(
          height: getProportionateHeight(
              widget.isEmail ? 20 : 10, widget.constraints),
        ),
        ElevatedButtonWidget(
          onClick: () async {
            //if (data.shouldShowLoader) return;

            /*await loginPageController!.dataToOTP(
                                              context, loginProvider!);*/
            widget.onLogin(widget.isEmail);
          },
          height: getProportionateHeight(64, widget.constraints),
          bgColor: Theme.of(context).primaryColor,
          borderSideColor: Theme.of(context).primaryColor,
          buttonName: widget.isEmail ? "Login" : "Get OTP".toUpperCase(),
          borderRadius: 12,
          trailingIcon: Icons.arrow_forward,
        ),
        SizedBox(
          height: getProportionateHeight(8, widget.constraints),
        ),
        Platform.isAndroid || Platform.isIOS
            ? TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  widget.onChangeLoginMethod();
                },
                child: TextWidget(
                  widget.isEmail
                      ? "or, Login With Mobile"
                      : "or, Login With Email",
                  color: calculateContrast(
                              const Color(0xFF769F77),
                              createMaterialColor(
                                      Theme.of(context).colorScheme.primary)
                                  .shade700) >
                          3
                      ? createMaterialColor(
                              Theme.of(context).colorScheme.primary)
                          .shade700
                      : createMaterialColor(
                              Theme.of(context).colorScheme.primary)
                          .shade100,
                  weight: FontWeight.w500,
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: getProportionateHeight(15, widget.constraints),
        ),
        Column(
          children: [
            TextWidget(
              "I agree to the terms and conditions of",
              color: Colors.white,
              align: TextAlign.center,
              flow: TextOverflow.visible,
              size: Theme.of(context).textTheme.bodyMedium?.fontSize,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Nandikrushi",
              style: TextStyle(
                  color: calculateContrast(
                              const Color(0xFF769F77),
                              createMaterialColor(
                                      Theme.of(context).colorScheme.primary)
                                  .shade700) >
                          3
                      ? createMaterialColor(
                              Theme.of(context).colorScheme.primary)
                          .shade700
                      : createMaterialColor(
                              Theme.of(context).colorScheme.primary)
                          .shade100,
                  fontFamily: 'Samarkan',
                  fontSize: getProportionateHeight(32, widget.constraints)),
            ),
          ],
        ),
      ],
    );
  }
}

class LoginWidgetLargeScreens extends StatefulWidget {
  final BoxConstraints constraints;
  final LoginController loginPageController;
  final bool isEmail;
  final Function onChangeLoginMethod;
  final Function(bool) onLogin;
  const LoginWidgetLargeScreens(
      {Key? key,
      required this.constraints,
      required this.loginPageController,
      this.isEmail = true,
      required this.onChangeLoginMethod,
      required this.onLogin})
      : super(key: key);

  @override
  State<LoginWidgetLargeScreens> createState() =>
      _LoginWidgetLargeScreensState();
}

class _LoginWidgetLargeScreensState extends State<LoginWidgetLargeScreens> {
  var shouldObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          widget.isEmail
              ? "Enter the credentials to login"
              : "Enter your mobile number",
          color: Colors.black,
          weight: FontWeight.w500,
          align: TextAlign.start,
          size: Theme.of(context).textTheme.titleMedium?.fontSize,
        ),
        SizedBox(
          height: getProportionateHeight(12, widget.constraints),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32, top: 12),
          child: Column(
            children: [
              widget.isEmail
                  ? TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_rounded),
                        hintStyle: fonts(
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                            FontWeight.w400,
                            Colors.grey[400]),
                        hintText: 'Email Address',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) {
                        if (value == null ||
                            !value.characters.contains("@") ||
                            !value.contains(".com")) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller:
                          widget.loginPageController.emailTextEditController,
                    )
                  : TextFormField(
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        widget.onLogin(widget.isEmail);
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefix: AnimatedContainer(
                            width: widget.loginPageController
                                    .phoneTextEditController.text.isNotEmpty
                                ? 40
                                : 0,
                            duration: const Duration(milliseconds: 250),
                            child: widget.loginPageController
                                    .phoneTextEditController.text.isNotEmpty
                                ? TextWidget(
                                    '+91',
                                    size: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.fontSize,
                                    weight: FontWeight.bold,
                                    color: Colors.grey,
                                  )
                                : const SizedBox(),
                          ),
                          counterStyle: fonts(
                              Theme.of(context).textTheme.bodySmall?.fontSize,
                              FontWeight.normal,
                              Theme.of(context).primaryColor),
                          hintStyle: fonts(
                              Theme.of(context).textTheme.bodyMedium?.fontSize,
                              FontWeight.w500,
                              Colors.grey[400]),
                          prefixIcon: const Icon(Icons.phone_rounded),
                          hintText: 'Phone number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          isDense: true,
                          errorBorder: InputBorder.none),
                      validator: (value) {
                        if (value?.length != 10) {
                          snackbar(
                              context, "Please enter a valid mobile number");
                        }
                        return null;
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller:
                          widget.loginPageController.phoneTextEditController,
                    ),
              widget.isEmail
                  ? SizedBox(
                      height: getProportionateHeight(20, widget.constraints),
                    )
                  : const SizedBox(),
              widget.isEmail
                  ? TextFormField(
                      obscureText: shouldObscureText,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        widget.onLogin(widget.isEmail);
                      },
                      decoration: InputDecoration(
                        suffixIcon: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              setState(() {
                                shouldObscureText = false;
                              });
                            }, //call this method when incontact
                            onTapUp: (TapUpDetails details) {
                              setState(() {
                                shouldObscureText = true;
                              });
                            }, //call this method when contact with screen is removed
                            child: const Icon(
                              Icons.remove_red_eye,
                            ),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.lock_rounded),
                        hintStyle: fonts(
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                            FontWeight.normal,
                            Colors.grey[400]),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      keyboardAppearance: Brightness.dark,
                      controller:
                          widget.loginPageController.passwordTextEditController,
                    )
                  : const SizedBox(),
              SizedBox(
                height: getProportionateHeight(
                    widget.isEmail ? 10 : 0, widget.constraints),
              ),
              widget.isEmail
                  ? Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            //Navigator.of(context).pop();
                          },
                          child: TextWidget(
                            "Forgot Password",
                            color: Theme.of(context).primaryColor,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: getProportionateHeight(20, widget.constraints),
              ),
              ElevatedButtonWidget(
                onClick: () async {
                  widget.onLogin(widget.isEmail);
                  // log(loginPageController!.numberController.text);
                  // loginPageController?.dataToEmail(context);
                },
                minWidth: double.infinity,
                height: getProportionateHeight(75, widget.constraints),
                borderRadius: 10,
                bgColor: Theme.of(context).primaryColor,
                borderSideColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                buttonName: widget.isEmail ? "Login" : "Get OTP".toUpperCase(),
                trailingIcon: Icons.arrow_forward,
              ),
              Platform.isAndroid || Platform.isIOS
                  ? SizedBox(
                      height: getProportionateHeight(10, widget.constraints),
                    )
                  : const SizedBox(),
              Platform.isAndroid || Platform.isIOS
                  ? TextButton(
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      onPressed: () {
                        widget.onChangeLoginMethod();
                      },
                      child: TextWidget(
                        widget.isEmail
                            ? "or, Login With Mobile"
                            : "or, Login With Email",
                        color: Theme.of(context).primaryColor,
                        weight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: getProportionateHeight(20, widget.constraints),
              ),
              TextWidget(
                "I agree to the terms and conditions of",
                align: TextAlign.center,
                flow: TextOverflow.visible,
                size: Theme.of(context).textTheme.bodyMedium?.fontSize,
              ),
              Text(
                "Nandikrushi",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Samarkan',
                    fontSize: getProportionateHeight(32, widget.constraints)),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 6,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Image.asset("assets/images/farmer_ploughing.png"),
          ),
        ),
      ],
    );
  }
}
