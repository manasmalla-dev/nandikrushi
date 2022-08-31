import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final int isPhoneOrEmail;
  const RegistrationScreen({Key? key, required this.isPhoneOrEmail})
      : super(key: key);

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

  /* bool validateData() {
    var isDataValid = true;
    registrationController.formControllers.forEach((key, value) {
      if (key == "first_name" || key == "last_name") {
        if (value.text.isNotEmpty) {
          //Name is valid
        } else {
          //Name is empty
          isDataValid = false;
          snackbar(context, "Please enter a valid full name");
        }
      } else if (key == 'telePhone' || key == "reg_number") {
        log("data");
      } else if (key == "pincode") {
        if (int.tryParse(value.text) == null) {
          //Invalid Pincode

          isDataValid = false;
          snackbar(context, "Please enter a valid numeric pincode");
        } else {
          //Pincode correct
        }
      } else if (key == "email") {
        if (value.text.contains("@") && value.text.contains(".")) {
          //Email is valid
        } else {
          //Email is invalid

          isDataValid = false;
          snackbar(context, "Please enter a valid email address");
        }
      } else if (key == "storeName") {
        if (value.text.isNotEmpty ||
            SpotmiesTheme.appTheme == UserAppTheme.farmer) {
          //Value is valid
        } else {
          //Value is invalid
          isDataValid = false;
          snackbar(context,
              "Please enter a valid ${SpotmiesTheme.appTheme == UserAppTheme.restaurant ? "Restaurant" : "Store"}'s Name");
        }
      } else if (key == "c_password") {
        log("Passwrd: ${registrationController.formControllers["password"]?.text}");
        log("Confirm Password: ${value.text}");
        if (value.text ==
            registrationController.formControllers["password"]?.text) {
          //Passwords are same
        } else {
          //Password Mismatch

          isDataValid = false;
          snackbar(context, "Passwords mismatch");
        }
      } else {
        if (value.text.isNotEmpty) {
          //Valid input
        } else {
          //Invalid input
          isDataValid = false;
          snackbar(context, "Please enter a valid $key");
        }
      }
    });
    if (registrationController.image == null) {
      isDataValid = false;
      snackbar(
          context,
          "Please upload ${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "the Farmer" : SpotmiesTheme.appTheme == UserAppTheme.store ? "your" : "your"} image");
    }
    if (SpotmiesTheme.appTheme != UserAppTheme.farmer) {
      if (registrationController.storeImage == null) {
        isDataValid = false;
        snackbar(context,
            "Please upload the ${SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"}'s logo");
      }
    }
    return isDataValid;
  }
  */

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
                            image: AssetImage("assets/png/ic_farmer.png"),
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
                                ? registrationDetailsFirstPage()
                                : registrationDetailsSecondPage(loginProvider),
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

  List<Widget> registrationDetailsFirstPage(LoginProvider loginProvider) {
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
            registrationController.image == null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 75,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          showImagePickerSheet(
                              onImageSelected: (XFile profileImage) {
                            //TODO: assign image
                          });
                        },
                        splashRadius: 42,
                        icon: const Icon(Icons.add_a_photo_rounded),
                      ),
                      TextWidget(
                        "Add ${loginProvider.userAppTheme.key.contains("Farmer") ? "Farmer" : "your"} Image",
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
                          File(registrationController.image?.path ?? ""),
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
                              showImagePickerSheet(false, false);
                            },
                            icon: Icon(Icons.edit_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
            SpotmiesTheme.appTheme != UserAppTheme.farmer
                ? registrationController.storeImage == null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: height(context) * 0.085,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              showImagePickerSheet(false, true);
                            },
                            splashRadius: height(context) * 0.04,
                            icon: const Icon(Icons.add_a_photo_rounded),
                          ),
                          TextWidget(
                            "Add ${SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"} Logo",
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
                              File(registrationController.storeImage?.path ??
                                  ""),
                              height: height(context) * 0.1,
                              width: height(context) * 0.1,
                              fit: BoxFit.cover,
                            )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: height(context) * 0.04,
                              height: height(context) * 0.04,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  showImagePickerSheet(false, true);
                                },
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color: Colors.white,
                                  size: height(context) * 0.02,
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
                "${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"} Information",
                color: Colors.grey.shade800,
                weight: FontWeight.bold,
                size: height(context) * 0.02,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['first_name'],
                      label:
                          "${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "Farmer's" : SpotmiesTheme.appTheme == UserAppTheme.store ? "" : ""} First Name",
                      style: fonts(height(context) * 0.021, FontWeight.w500,
                          Colors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['last_name'],
                      label:
                          "${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "Farmer's" : SpotmiesTheme.appTheme == UserAppTheme.store ? "" : ""} Last Name",
                      style: fonts(height(context) * 0.021, FontWeight.w500,
                          Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SpotmiesTheme.appTheme != UserAppTheme.farmer
                  ? TextFieldWidget(
                      controller:
                          registrationController.formControllers['storeName'],
                      label:
                          "${SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"}'s Name",
                      style: fonts(height(context) * 0.021, FontWeight.w500,
                          Colors.black),
                    )
                  : const SizedBox(),
              SpotmiesTheme.appTheme != UserAppTheme.farmer
                  ? SizedBox(
                      height: height(context) * 0.005,
                    )
                  : const SizedBox(),
              TextFieldWidget(
                controller: registrationController.formControllers['email'],
                label: 'Email Address',
                style: fonts(
                    height(context) * 0.021, FontWeight.w400, Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['password'],
                      label: 'Create Password',
                      obscureText: true,
                      style: fonts(height(context) * 0.021, FontWeight.w400,
                          Colors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['c_password'],
                      label: 'Confirm Password',
                      obscureText: true,
                      style: fonts(height(context) * 0.021, FontWeight.w400,
                          Colors.black),
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
                weight: FontWeight.bold,
                size: height(context) * 0.02,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['state'],
                      label: 'State',
                      style: fonts(height(context) * 0.02, FontWeight.w500,
                          Colors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['district'],
                      label: 'District',
                      style: fonts(height(context) * 0.02, FontWeight.w500,
                          Colors.black),
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
                      controller:
                          registrationController.formControllers['mandal'],
                      label: 'Locality',
                      style: fonts(height(context) * 0.02, FontWeight.w500,
                          Colors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      controller:
                          registrationController.formControllers['city'],
                      label: 'City/Vilage',
                      style: fonts(height(context) * 0.02, FontWeight.w500,
                          Colors.black),
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
                      controller: registrationController
                          .formControllers['house_number'],
                      label: 'H.No.',
                      style: fonts(height(context) * 0.02, FontWeight.w500,
                          Colors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextFieldWidget(
                      textInputAction: TextInputAction.done,
                      controller:
                          registrationController.formControllers['pincode'],
                      label: 'Pincode',
                      style: fonts(height(context) * 0.02, FontWeight.w500,
                          Colors.black),
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
              /*
              TODO: Manage data handling
              registrationController.user = Users.registerPartA(
                  firstName: registrationController
                          .formControllers['first_name']?.text ??
                      "",
                  lastName:
                      registrationController.formControllers['last_name']?.text ??
                          "",
                  email: registrationController.formControllers['email']?.text ??
                      "",
                  telePhone:
                      registrationController.formControllers['telePhone']?.text ??
                          "",
                  pass: registrationController.formControllers['password']?.text ??
                      "",
                  cpass: registrationController
                          .formControllers['c_password']?.text ??
                      "",
                  city: registrationController.formControllers['city']?.text ?? "",
                  houseNumber: registrationController.formControllers['house_number']?.text ?? "",
                  district: registrationController.formControllers['district']?.text ?? "",
                  mandal: registrationController.formControllers['mandal']?.text ?? "",
                  farmerImage: "",
                  pincode: registrationController.formControllers['pincode']?.text ?? "",
                  state: registrationController.formControllers['state']?.text ?? "");
              log(registrationController.user.toString());*/
              await loginPageController.pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            }
          },
          minWidth: width(context) * 0.85,
          height: height(context) * 0.06,
          borderRadius: 12,
          bgColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).colorScheme.onPrimary,
          buttonName: "Next".toUpperCase(),
          innerPadding: 0.02,
          trailingIcon: Icons.arrow_forward),
    ];
  }

  registrationDetailsSecondPage(LoginProvider loginProvider) {
    return [
      Container(
        padding: EdgeInsets.only(
            left: width(context) * 0.08,
            right: width(context) * 0.08,
            top: width(context) * 0.08),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpotmiesTheme.appTheme == UserAppTheme.farmer
                ? TextWidget(
                    "Cultivated Land Area (in acres)",
                    color: Colors.grey.shade800,
                    weight: FontWeight.bold,
                    size: height(context) * 0.02,
                  )
                : const SizedBox(),
            SizedBox(
              height: SpotmiesTheme.appTheme == UserAppTheme.farmer
                  ? height(context) * 0.02
                  : 0,
            ),
            SpotmiesTheme.appTheme == UserAppTheme.farmer
                ? SliderTheme(
                    data: SliderThemeData(
                        activeTickMarkColor:
                            SpotmiesTheme.appTheme == UserAppTheme.restaurant
                                ? Colors.black
                                : Colors.white,
                        inactiveTickMarkColor:
                            SpotmiesTheme.appTheme == UserAppTheme.restaurant
                                ? Colors.black
                                : Colors.white),
                    child: Slider(
                        divisions: 30,
                        thumbColor: const Color(0xFF006838),
                        activeColor: const Color(0xFF006838),
                        inactiveColor: const Color(0x16006838),
                        value: registrationController.acresInInt,
                        max: 30,
                        min: 1,
                        label: (registrationController.acresInInt)
                            .round()
                            .toString(),
                        // ignore: avoid_types_as_parameter_names
                        onChanged: (num) {
                          log("$num");
                          setState(() {
                            registrationController.acresInInt = num;
                          });
                        }),
                  )
                : const SizedBox(),
            SizedBox(
              height: height(context) * 0.02,
            ),
            TextWidget(
              "Select Certification Details",
              color: Colors.grey.shade800,
              weight: FontWeight.bold,
              size: height(context) * 0.02,
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: registrationController.checkBoxStatesText.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    registrationController.user.certificates[index] = [];
                    for (int i = 0;
                        i <=
                            (registrationController.checkBoxStatesText.length -
                                1);
                        i++) {
                      registrationController.checkBoxStates[i] = false;
                    }
                    registrationController.checkBoxStates[index] = true;
                    registrationController.formControllers["reg_number"]?.text =
                        "";
                  });
                },
                child: Container(
                  color: registrationController.checkBoxStates[index]
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
                                activeColor: SpotmiesTheme.appTheme ==
                                        UserAppTheme.restaurant
                                    ? Colors.green[900]
                                    : Colors.white,
                                checkColor: Theme.of(context).primaryColor,
                                value: registrationController
                                    .checkBoxStates[index],
                                onChanged: (boolean) {
                                  setState(() {
                                    for (int i = 0; i <= 5; i++) {
                                      registrationController.checkBoxStates[i] =
                                          false;
                                    }
                                    registrationController
                                            .checkBoxStates[index] =
                                        boolean ?? false;
                                  });
                                }),
                            SizedBox(
                              width: width(context) * 0.6,
                              child: TextWidget(
                                registrationController
                                    .checkBoxStatesText[index],
                                weight: FontWeight.w500,
                                color:
                                    registrationController.checkBoxStates[index]
                                        ? SpotmiesTheme.appTheme ==
                                                UserAppTheme.restaurant
                                            ? Colors.green[900]
                                            : Colors.white
                                        : Colors.black,
                              ),
                            )
                          ]),
                      (SpotmiesTheme.appTheme == UserAppTheme.farmer
                                  ? index != 0
                                  : true) &&
                              index != 5 &&
                              registrationController.checkBoxStates[index]
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  SizedBox(
                                    width: width(context) * 0.1,
                                  ),
                                  Column(
                                    children: [
                                      const TextWidget(
                                        "Reference Number",
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: width(context) * 0.32,
                                        height: height(context) * 0.05,
                                        child: FilledTextFieldWidget(
                                          controller: registrationController
                                              .formControllers["reg_number"],
                                          label: "",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width(context) * 0.05,
                                  ),
                                  Column(
                                    children: [
                                      const TextWidget(
                                        text: "Upload Certificate",
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
                                                    true, false);
                                              },
                                              child: const TextWidget(
                                                text: "Choose File",
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
                      (SpotmiesTheme.appTheme == UserAppTheme.farmer
                                  ? index != 0
                                  : true) &&
                              index != 5 &&
                              registrationController.checkBoxStates[index] &&
                              (registrationController
                                      .user.certificates[index]?.isNotEmpty ??
                                  false)
                          ? SizedBox(
                              height: height(context) * 0.12,
                              child: ListView.builder(
                                  itemCount: registrationController
                                      .user.certificates[index]?.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, imageIndex) {
                                    // print(registrationController
                                    //    .user.certificates);
                                    return registrationController
                                                .user
                                                .certificates[index]
                                                    ?[imageIndex]
                                                .path !=
                                            null
                                        ? Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.file(
                                                    File(registrationController
                                                        .user
                                                        .certificates[index]![
                                                            imageIndex]
                                                        .path),
                                                    height:
                                                        height(context) * 0.1,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      registrationController
                                                          .user
                                                          .certificates[index]
                                                          ?.removeAt(
                                                              imageIndex);
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
                                          )
                                        : const SizedBox();
                                  }),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              );
            }),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: height(context) * 0.03),
        child: ElevatedButtonWidget(
          onClick: () async {
            //Validate the acresInLand or the certification
            if (registrationController.checkBoxStates
                    .where((element) => element == true)
                    .length ==
                1) {
              registrationController.registerButton(
                  scaffoldKey.currentContext ?? context,
                  registrationProvider,
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavBar()));
                  },
                  false,
                  () {
                    Navigator.maybeOf(scaffoldKey.currentContext ?? context)
                        ?.push(MaterialPageRoute(
                            builder: (context) => const NavBar()));
                  });
            }
          },
          minWidth: width(context) * 0.85,
          height: height(context) * 0.06,
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
