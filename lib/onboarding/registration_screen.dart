import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi_farmer/nav_host.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
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
    loginPageController.checkLocationPermissionAndGetLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Consumer<LoginProvider>(builder: (context, loginProvider, __) {
        return LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: loginPageController.pageController,
                itemCount: 2,
                itemBuilder: (context, pageIndex) {
                  return SingleChildScrollView(
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
                                        ? createMaterialColor(Theme.of(context)
                                                .colorScheme
                                                .primary)
                                            .shade700
                                        : createMaterialColor(Theme.of(context)
                                                .colorScheme
                                                .primary)
                                            .shade100,
                                    fontFamily: 'Samarkan',
                                    fontSize: getProportionateHeight(
                                        32, constraints)),
                              ),
                              TextWidget(
                                "Create Account".toUpperCase(),
                                color: const Color(0xFF006838),
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
                            children: pageIndex == 0
                                ? registrationDetailsFirstPage(
                                    loginProvider, constraints)
                                : registrationDetailsSecondPage(
                                    loginProvider, constraints),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Consumer<LoginProvider>(builder: (context, loginProvider, _) {
                return loginProvider.shouldShowLoader
                    ? const LoaderScreen()
                    : const SizedBox();
              }),
            ],
          );
        });
      }),
    );
  }

  void showImagePickerSheet({required Function(XFile) onImageSelected}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Choose Profile Picture",
                  size: Theme.of(context).textTheme.titleLarge?.fontSize,
                  weight: Theme.of(context).textTheme.titleLarge?.fontWeight,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextWidget(
                  "Choose an image as a profile picture from one of the following sources",
                  flow: TextOverflow.visible,
                  size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  weight: Theme.of(context).textTheme.bodyLarge?.fontWeight,
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPrimary: Theme.of(context).colorScheme.onPrimary),
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
                            primary: Theme.of(context).primaryColor,
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
      Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            loginPageController.profileImage == null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 75,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          showImagePickerSheet(
                              onImageSelected: (XFile profileImage) {
                            loginPageController.profileImage = profileImage;
                          });
                        },
                        splashRadius: 42,
                        icon: const Icon(Icons.add_a_photo_rounded),
                      ),
                      TextWidget(
                        "Add ${loginProvider.isFarmer ? "Farmer" : "your"} Image",
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        weight:
                            Theme.of(context).textTheme.bodyLarge?.fontWeight,
                        size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      )
                    ],
                  )
                : Stack(
                    children: [
                      Center(
                        child: ClipOval(
                            child: Image.file(
                          File(loginPageController.profileImage?.path ?? ""),
                          height: 96,
                          width: 96,
                          fit: BoxFit.cover,
                        )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () {
                              showImagePickerSheet(
                                  onImageSelected: (XFile profileImage) {
                                loginPageController.profileImage = profileImage;
                              });
                            },
                            icon: Icon(Icons.edit_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
            !loginProvider.isFarmer
                ? loginPageController.storeLogo == null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 75,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              showImagePickerSheet(
                                  onImageSelected: (XFile storeLogo) {
                                loginPageController.storeLogo = storeLogo;
                              });
                            },
                            splashRadius: 42,
                            icon: const Icon(Icons.add_a_photo_rounded),
                          ),
                          TextWidget(
                            "Add ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"} Logo",
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                            weight: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.fontWeight,
                            size:
                                Theme.of(context).textTheme.bodyLarge?.fontSize,
                          )
                        ],
                      )
                    : Stack(
                        children: [
                          Center(
                            child: ClipOval(
                                child: Image.file(
                              File(loginPageController.storeLogo?.path ?? ""),
                              height: 96,
                              width: 96,
                              fit: BoxFit.cover,
                            )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  showImagePickerSheet(
                                      onImageSelected: (XFile storeLogo) {
                                    loginPageController.storeLogo = storeLogo;
                                  });
                                },
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                : const SizedBox()
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(
          32,
        ),
        child: Form(
          key: loginPageController.registrationFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "${loginProvider.isFarmer ? "Farmer" : loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"} Information",
                color: Colors.grey.shade800,
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
                      label:
                          "${loginProvider.isFarmer ? "Farmer's" : ""} First Name",
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
                      label:
                          "${loginProvider.isFarmer ? "Farmer's" : ""} Last Name",
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
              const SizedBox(
                height: 8,
              ),
              !loginProvider.isFarmer
                  ? TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['storeName'],
                      label:
                          "${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"}'s Name",
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(context,
                              "Please enter a valid ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"} name");
                        }
                        return null;
                      },
                    )
                  : const SizedBox(),
              !loginProvider.isFarmer
                  ? const SizedBox(
                      height: 8,
                    )
                  : const SizedBox(),
              TextFieldWidget(
                controller: loginPageController
                    .registrationPageFormControllers['email'],
                label: 'Email Address',
                validator: (value) {
                  if ((value?.contains("@") ?? false) &&
                      (value?.contains(".") ?? false)) {
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
              TextWidget(
                "Location Details",
                color: Colors.grey.shade800,
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
                          .registrationPageFormControllers['state'],
                      label: 'State',
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid state");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['district'],
                      label: 'District',
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid district");
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['mandal'],
                      label: 'Locality',
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid locality");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['city'],
                      label: 'City/Vilage',
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid city/village");
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: loginPageController
                          .registrationPageFormControllers['house_number'],
                      label: 'H.No.',
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid house number");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      textInputAction: TextInputAction.done,
                      controller: loginPageController
                          .registrationPageFormControllers['pincode'],
                      label: 'Pincode',
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return snackbar(
                              context, "Please enter a valid pincode");
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
      ElevatedButtonWidget(
          onClick: () async {
            var formValidatedState = loginPageController
                    .registrationFormKey.currentState
                    ?.validate() ??
                false;

            if (formValidatedState) {
              if (loginPageController.profileImage == null) {
                formValidatedState = false;
                snackbar(
                    context,
                    "Please upload ${loginProvider.isFarmer ? "the Farmer" : loginProvider.userAppTheme.key.contains("Store") ? "your" : "your"} image");
              }
              if (!loginProvider.isFarmer) {
                if (loginPageController.storeLogo == null) {
                  formValidatedState = false;
                  snackbar(context,
                      "Please upload the ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"}'s logo");
                }
              }
              if (formValidatedState) {
                await loginPageController.pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              }
            }
          },
          height: getProportionateHeight(64, constraints),
          borderRadius: 12,
          bgColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).colorScheme.onPrimary,
          buttonName: "Next".toUpperCase(),
          innerPadding: 0.02,
          trailingIcon: Icons.arrow_forward),
    ];
  }

  registrationDetailsSecondPage(
      LoginProvider loginProvider, BoxConstraints constraints) {
    return [
      Container(
        margin: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loginProvider.isFarmer
                ? TextWidget(
                    "Cultivated Land Area (in acres)",
                    color: Colors.grey.shade800,
                    weight: Theme.of(context).textTheme.titleMedium?.fontWeight,
                    size: Theme.of(context).textTheme.titleMedium?.fontSize,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            loginProvider.isFarmer
                ? SliderTheme(
                    data: SliderThemeData(
                      activeTickMarkColor:
                          Theme.of(context).colorScheme.onPrimary,
                      inactiveTickMarkColor:
                          Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Slider(
                        divisions: 30,
                        thumbColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: const Color(0x16006838),
                        value: loginPageController.landInAcres,
                        max: 30,
                        min: 1,
                        label:
                            loginPageController.landInAcres.round().toString(),
                        // ignore: avoid_types_as_parameter_names
                        onChanged: (num) {
                          setState(() {
                            loginPageController.landInAcres = num;
                          });
                        }),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              "Select Certification Details",
              color: Colors.grey.shade800,
              weight: Theme.of(context).textTheme.titleMedium?.fontWeight,
              size: Theme.of(context).textTheme.titleMedium?.fontSize,
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: loginProvider.certificationList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    loginPageController.userCertificates[index] = [];
                    loginPageController.userCertification =
                        loginProvider.certificationList[index];
                    loginPageController
                        .registrationPageFormControllers["reg_number"]
                        ?.text = "";
                  });
                },
                child: Container(
                  color: loginPageController.userCertification ==
                          loginProvider.certificationList[index]
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.5)),
                                activeColor: loginProvider.userAppTheme.key
                                        .contains("Restaraunts")
                                    ? Colors.green[900]
                                    : Colors.white,
                                checkColor: Theme.of(context).primaryColor,
                                value: loginPageController.userCertification ==
                                    loginProvider.certificationList[index],
                                onChanged: (boolean) {
                                  setState(() {
                                    loginPageController
                                        .userCertificates[index] = [];
                                    loginPageController.userCertification =
                                        loginProvider.certificationList[index];
                                    loginPageController
                                        .registrationPageFormControllers[
                                            "reg_number"]
                                        ?.text = "";
                                  });
                                }),
                            SizedBox(
                              width: getProportionateWidth(256, constraints),
                              child: TextWidget(
                                loginProvider.certificationList[index],
                                weight: FontWeight.w500,
                                color: loginPageController.userCertification ==
                                        loginProvider.certificationList[index]
                                    ? loginProvider.userAppTheme.key
                                            .contains("Restaraunts")
                                        ? Colors.green[900]
                                        : Colors.white
                                    : Colors.black,
                              ),
                            )
                          ]),
                      (loginProvider.isFarmer ? index != 0 : true) &&
                              index != 5 &&
                              loginPageController.userCertification ==
                                  loginProvider.certificationList[index]
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const SizedBox(
                                    width: 42,
                                  ),
                                  Column(
                                    children: [
                                      const TextWidget(
                                        "Reference Number",
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: getProportionateWidth(
                                            136, constraints),
                                        child: Form(
                                          key: loginPageController
                                              .registrationFormSecondPageKey,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            onChanged: (_) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                counterStyle: fonts(
                                                    Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.fontSize,
                                                    FontWeight.normal,
                                                    Colors.white),
                                                hintStyle: fonts(
                                                    Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.fontSize,
                                                    FontWeight.w500,
                                                    Colors.grey[400]),
                                                prefixIcon: const Icon(
                                                    Icons.phone_rounded),
                                                hintText: 'Registration Number',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                isDense: true,
                                                errorBorder: InputBorder.none),
                                            validator: (value) {
                                              if (value?.isEmpty ?? false) {
                                                snackbar(context,
                                                    "Please enter a valid certificate registration number");
                                              }
                                              return null;
                                            },
                                            controller: loginPageController
                                                    .registrationPageFormControllers[
                                                "reg_number"],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      const TextWidget(
                                        "Upload Certificate",
                                        color: Colors.white,
                                      ),
                                      Row(
                                        children: [
                                          MaterialButton(
                                              padding: const EdgeInsets.all(0),
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              onPressed: () {
                                                showImagePickerSheet(
                                                    onImageSelected:
                                                        (XFile certificate) {
                                                  loginPageController
                                                      .userCertificates[index]
                                                      .add(certificate);
                                                });
                                              },
                                              child: const TextWidget(
                                                "Choose File",
                                              )),
                                          Icon(
                                            Icons.archive_rounded,
                                            color: Colors.white.withAlpha(150),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ])
                          : const SizedBox(),
                      (loginProvider.isFarmer ? index != 0 : true) &&
                              index != 5 &&
                              loginPageController.userCertification ==
                                  loginProvider.certificationList[index] &&
                              loginPageController
                                  .userCertificates[index].isNotEmpty
                          ? ListView.builder(
                              itemCount: loginPageController
                                  .userCertificates[index].length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, imageIndex) {
                                // print(registrationController
                                //    .userCertificates);
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          File(loginPageController
                                              .userCertificates[index]
                                                  [imageIndex]
                                              .path),
                                          height: 96,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          onPressed: () {
                                            loginPageController
                                                .userCertificates[index]
                                                .removeAt(imageIndex);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                          : const SizedBox()
                    ],
                  ),
                ),
              );
            }),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 27),
        child: ElevatedButtonWidget(
          onClick: () async {
            var formValidatedState = loginPageController
                    .registrationFormSecondPageKey.currentState
                    ?.validate() ??
                false;

            if (formValidatedState &&
                loginPageController.landInAcres > 1 &&
                loginPageController.userCertification.isNotEmpty &&
                loginPageController.userCertificates
                    .where((element) => element.isNotEmpty)
                    .isNotEmpty) {
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
                    context.setAsReturningUser(uID, cID);
                    Navigator.maybeOf(context)?.push(
                      MaterialPageRoute(
                        builder: (context) => NandikrushiNavHost(
                          userId: uID,
                          customerId: cID,
                        ),
                      ),
                    );
                  });
            }
          },
          height: getProportionateHeight(64, constraints),
          borderRadius: 12,
          bgColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).colorScheme.onPrimary,
          buttonName: "Submit".toUpperCase(),
          trailingIcon: Icons.check_rounded,
        ),
      ),
    ];
  }
}
