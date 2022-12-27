import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi/nav_host.dart';
import 'package:nandikrushi/onboarding/login_controller.dart';
import 'package:nandikrushi/onboarding/login_provider.dart';
import 'package:nandikrushi/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi/utils/custom_color_util.dart';
import 'package:nandikrushi/utils/login_utils.dart';
import 'package:nandikrushi/utils/size_config.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  LoginController loginPageController = LoginController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //loginPageController.checkLocationPermissionAndGetLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Consumer<LoginProvider>(builder: (context, loginProvider, __) {
        return LayoutBuilder(builder: (context, constraints) {
          return constraints.maxWidth < 500
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      child: Stack(
                        children: [
                          Positioned(
                            top: -(getProportionateHeight(28, constraints)),
                            left: getProportionateWidth(210, constraints),
                            child: const Image(
                              image: AssetImage("assets/images/ic_farmer.png"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getProportionateHeight(75, constraints)),
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nandikrushi",
                                  style: TextStyle(
                                      color: calculateContrast(
                                                  const Color(0xFF769F77),
                                                  createMaterialColor(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary)
                                                      .shade700) >
                                              3
                                          ? createMaterialColor(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary)
                                              .shade700
                                          : createMaterialColor(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary)
                                              .shade100,
                                      fontFamily: 'Samarkan',
                                      fontSize: getProportionateHeight(
                                          32, constraints)),
                                ),
                                TextWidget(
                                  "Create Account".toUpperCase(),
                                  color: Theme.of(context).colorScheme.primary,
                                  weight: FontWeight.bold,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getProportionateHeight(150, constraints)),
                            child: Column(
                                children: registrationDetailsFirstPage(
                                    loginProvider, constraints)),
                          ),
                        ],
                      ),
                    ),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, _) {
                      return loginProvider.shouldShowLoader
                          ? const LoaderScreen()
                          : const SizedBox();
                    }),
                  ],
                )
              : Stack(
                  children: [
                    Positioned(
                      top: -(getProportionateHeight(28, constraints)),
                      left: getProportionateWidth(210, constraints),
                      child: const Image(
                        image: AssetImage("assets/images/ic_farmer.png"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: getProportionateHeight(75, constraints)),
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nandikrushi",
                            style: TextStyle(
                                color: calculateContrast(
                                            const Color(0xFF769F77),
                                            createMaterialColor(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary)
                                                .shade700) >
                                        3
                                    ? createMaterialColor(Theme.of(context)
                                            .colorScheme
                                            .primary)
                                        .shade700
                                    : createMaterialColor(Theme.of(context)
                                            .colorScheme
                                            .primary)
                                        .shade100,
                                fontFamily: 'Samarkan',
                                fontSize:
                                    getProportionateHeight(32, constraints)),
                          ),
                          TextWidget(
                            "Create Account".toUpperCase(),
                            color: Theme.of(context).colorScheme.primary,
                            weight: FontWeight.bold,
                            size: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.fontSize,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateHeight(150, constraints)),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: registrationDetailsFirstPage(
                                  loginProvider, constraints),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        });
      }),
    );
  }

  void showImagePickerSheet(
      {required Function(XFile) onImageSelected,
      required BoxConstraints constraints}) {
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            height: getProportionateHeight(300, constraints),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Choose Profile Picture",
                  size: Theme.of(context).textTheme.titleLarge?.fontSize,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextWidget(
                  "Choose an image as a profile picture from one of the following sources",
                  flow: TextOverflow.visible,
                  size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  weight: Theme.of(context).textTheme.bodyLarge?.fontWeight,
                ),
                const Spacer(),
                Row(
                  children: const [
                    Expanded(
                      flex: 3,
                      child: Icon(Icons.photo_library_rounded, size: 48),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: Icon(Icons.camera_alt_rounded, size: 48),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary),
                        onPressed: () async {
                          var pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          setState(() {
                            Navigator.of(context).pop();
                            if (pickedImage != null) {
                              onImageSelected(pickedImage);
                            } else {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                snackbar(context,
                                    "The image you selected is empty or you didn't select an image.");
                              });
                            }
                          });
                        },
                        child: const Text(
                          "Gallery",
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPrimary: Theme.of(context).colorScheme.onPrimary),
                        onPressed: () async {
                          var pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          setState(() {
                            Navigator.of(context).pop();
                            if (pickedImage != null) {
                              onImageSelected(pickedImage);
                            } else {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                snackbar(context,
                                    "The image you selected is empty or you didn't select an image.");
                              });
                            }
                          });
                        },
                        child: const Text("Camera"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  List<Widget> registrationDetailsFirstPage(
      LoginProvider loginProvider, BoxConstraints constraints) {
    return [
      Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          bottom: 24,
          top: 8,
        ),
        child: Form(
          key: loginPageController.registrationFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "Your Information",
                weight: Theme.of(context).textTheme.titleMedium?.fontWeight,
                size: Theme.of(context).textTheme.titleMedium?.fontSize,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['first_name'],
                      label: "First Name",
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid first name");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['last_name'],
                      label: "Last Name",
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid last name");
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                controller: loginPageController
                    .registrationPageFormControllers['email'],
                label: 'Email Address',
                validator: (value) {
                  if (!(value?.contains("@") ?? false) &&
                      !(value?.contains(".") ?? false)) {
                    return snackbar(
                        context, "Please enter a valid email address");
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['password'],
                      label: 'Create Password',
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid password");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['c_password'],
                      label: 'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if ((value?.isEmpty ?? false) &&
                            value ==
                                loginPageController
                                    .registrationPageFormControllers['password']
                                    ?.text
                                    .toString()) {
                          return snackbar(context, "Oops! Passwords mismatch");
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        child: ElevatedButtonWidget(
          onClick: () async {
            if (constraints.maxWidth < 500) {
              var formValidatedState = loginPageController
                      .registrationFormSecondPageKey.currentState
                      ?.validate() ??
                  true;

              if (formValidatedState) {
                loginProvider.registerUser(
                    loginPageController: loginPageController,
                    onError: (error) {
                      snackbar(context, error);
                    },
                    onSuccess: (name, _, uID, cID) {
                      snackbar(
                          context, "Welcome to the Nandikrushi family, $name!",
                          isError: false);
                      loginProvider.showLoader();
                      context.setAsReturningUser(uID);
                      Navigator.maybeOf(context)?.push(
                        MaterialPageRoute(
                          builder: (context) => NandikrushiNavHost(
                            userId: uID,
                          ),
                        ),
                      );
                    });
              } else {
                snackbar(context, "Please enter a valid response");
              }
            } else {
              var formValidatedState = loginPageController
                      .registrationFormKey.currentState
                      ?.validate() ??
                  false;

              if (formValidatedState) {
                var formValidatedState = loginPageController
                        .registrationFormSecondPageKey.currentState
                        ?.validate() ??
                    true;

                if (formValidatedState) {
                  loginProvider.registerUser(
                      loginPageController: loginPageController,
                      onError: (error) {
                        snackbar(context, error);
                      },
                      onSuccess: (name, _, uID, cID) {
                        snackbar(context,
                            "Welcome to the Nandikrushi family, $name!",
                            isError: false);
                        loginProvider.showLoader();
                        context.setAsReturningUser(uID);
                        Navigator.maybeOf(context)?.push(
                          MaterialPageRoute(
                            builder: (context) => NandikrushiNavHost(
                              userId: uID,
                            ),
                          ),
                        );
                      });
                } else {
                  snackbar(context, "Please enter a valid response");
                }
              }
            }
          },
          height: getProportionateHeight(64, constraints),
          borderRadius: 12,
          buttonName: "Submit".toUpperCase(),
          trailingIcon: Icons.check_rounded,
        ),
      ),
    ];
  }
}
