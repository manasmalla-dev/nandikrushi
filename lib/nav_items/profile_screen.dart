// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi_farmer/utils/firebase_storage_utils.dart';
import 'package:nandikrushi_farmer/utils/server.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginController loginPageController = LoginController();
  @override
  void initState() {
    super.initState();
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    loginPageController.getDataFromProvider(profileProvider);
  }

  @override
  Widget build(BuildContext context) {
    void showImagePickerSheet(
        {required Function(XFile) onImageSelected,
        required BoxConstraints constraints}) {
      showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                              primary: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              onPrimary:
                                  Theme.of(context).colorScheme.onPrimary),
                          onPressed: () async {
                            var pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            setState(() {
                              Navigator.of(context).pop();
                              if (pickedImage != null) {
                                onImageSelected(pickedImage);
                              } else {
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
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
                              onPrimary:
                                  Theme.of(context).colorScheme.onPrimary),
                          onPressed: () async {
                            var pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            setState(() {
                              Navigator.of(context).pop();
                              if (pickedImage != null) {
                                onImageSelected(pickedImage);
                              } else {
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
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

    return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
      return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
        var phoneNumberController = TextEditingController();
        return Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: kToolbarHeight,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: TextWidget(
                      'Profile',
                      size: Theme.of(context).textTheme.titleMedium?.fontSize,
                      color: Colors.grey[900],
                      weight: FontWeight.w700,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          margin: const EdgeInsets.all(32),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              loginPageController.profileImage == null
                                  ? Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              iconSize: 75,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                showImagePickerSheet(
                                                    constraints: constraints,
                                                    onImageSelected:
                                                        (XFile profileImage) {
                                                      loginPageController
                                                              .profileImage =
                                                          profileImage;
                                                    });
                                              },
                                              splashRadius: 42,
                                              icon: const Icon(
                                                  Icons.add_a_photo_rounded),
                                            ),
                                            TextWidget(
                                              "Add ${loginProvider.isFarmer ? "Farmer" : "your"} Image",
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.7),
                                              weight: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.fontWeight,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.fontSize,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: ClipOval(
                                                  child: Image.file(
                                                File(loginPageController
                                                        .profileImage?.path ??
                                                    ""),
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
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    shape: BoxShape.circle),
                                                child: IconButton(
                                                  onPressed: () {
                                                    showImagePickerSheet(
                                                        constraints:
                                                            constraints,
                                                        onImageSelected: (XFile
                                                            profileImage) {
                                                          loginPageController
                                                                  .profileImage =
                                                              profileImage;
                                                        });
                                                  },
                                                  icon: Icon(Icons.edit_rounded,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      size: 16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              !loginProvider.isFarmer
                                  ? loginPageController.storeLogo == null
                                      ? Expanded(
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  iconSize: 75,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    showImagePickerSheet(
                                                        constraints:
                                                            constraints,
                                                        onImageSelected:
                                                            (XFile storeLogo) {
                                                          loginPageController
                                                                  .storeLogo =
                                                              storeLogo;
                                                        });
                                                  },
                                                  splashRadius: 42,
                                                  icon: const Icon(Icons
                                                      .add_a_photo_rounded),
                                                ),
                                                TextWidget(
                                                  "Add ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"} Logo",
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.7),
                                                  weight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.fontWeight,
                                                  size: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.fontSize,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Center(
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: ClipOval(
                                                      child: Image.file(
                                                    File(loginPageController
                                                            .storeLogo?.path ??
                                                        ""),
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        shape: BoxShape.circle),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        showImagePickerSheet(
                                                            constraints:
                                                                constraints,
                                                            onImageSelected:
                                                                (XFile
                                                                    storeLogo) {
                                                              loginPageController
                                                                      .storeLogo =
                                                                  storeLogo;
                                                            });
                                                      },
                                                      icon: Icon(
                                                        Icons.edit_rounded,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                                  weight: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontWeight,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontSize,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'first_name'],
                                        label:
                                            "${loginProvider.isFarmer ? "Farmer's" : ""} First Name",
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid first name");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'last_name'],
                                        label:
                                            "${loginProvider.isFarmer ? "Farmer's" : ""} Last Name",
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid last name");
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
                                                .registrationPageFormControllers[
                                            'storeName'],
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
                                FirebaseAuth.instance.currentUser
                                                ?.phoneNumber ==
                                            null ||
                                        (FirebaseAuth.instance.currentUser
                                                ?.phoneNumber?.isEmpty ??
                                            false)
                                    ? TextFieldWidget(
                                        controller: phoneNumberController,
                                        label: 'Phone Number',
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              value.length != 10) {
                                            return snackbar(context,
                                                "Please enter a valid phone number");
                                          }
                                          return null;
                                        },
                                      )
                                    : SizedBox(),
                                TextFieldWidget(
                                  controller: loginPageController
                                      .registrationPageFormControllers['email'],
                                  label: 'Email Address',
                                  validator: (value) {
                                    if (!(value?.contains("@") ?? false) &&
                                        !(value?.contains(".") ?? false)) {
                                      return snackbar(context,
                                          "Please enter a valid email address");
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
                                                .registrationPageFormControllers[
                                            'password'],
                                        label: 'Create Password',
                                        obscureText: true,
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid password");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'c_password'],
                                        label: 'Confirm Password',
                                        obscureText: true,
                                        validator: (value) {
                                          if ((value?.isEmpty ?? false) &&
                                              value ==
                                                  loginPageController
                                                      .registrationPageFormControllers[
                                                          'password']
                                                      ?.text
                                                      .toString()) {
                                            return snackbar(context,
                                                "Oops! Passwords mismatch");
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
                                  weight: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontWeight,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontSize,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'state'],
                                        label: 'State',
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid state");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'district'],
                                        label: 'District',
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid district");
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
                                                .registrationPageFormControllers[
                                            'mandal'],
                                        label: 'Locality',
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid locality");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'city'],
                                        label: 'City/Vilage',
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid city/village");
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
                                                .registrationPageFormControllers[
                                            'house_number'],
                                        label: 'H.No.',
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid house number");
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
                                                .registrationPageFormControllers[
                                            'pincode'],
                                        label: 'Pincode',
                                        keyboardType: TextInputType.number,
                                        maxLength: 6,
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid pincode");
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
                        Container(
                          margin: const EdgeInsets.only(
                              left: 32, right: 32, bottom: 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              loginProvider.isFarmer
                                  ? TextWidget(
                                      "Cultivated Land Area (in acres)",
                                      color: Colors.grey.shade800,
                                      weight: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.fontWeight,
                                      size: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.fontSize,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              loginProvider.isFarmer
                                  ? SliderTheme(
                                      data: SliderThemeData(
                                        activeTickMarkColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        inactiveTickMarkColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                      child: Slider(
                                          divisions: 30,
                                          thumbColor:
                                              Theme.of(context).primaryColor,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          inactiveColor:
                                              const Color(0x16006838),
                                          value:
                                              loginPageController.landInAcres,
                                          max: 30,
                                          min: 1,
                                          label: loginPageController.landInAcres
                                              .round()
                                              .toString(),
                                          // ignore: avoid_types_as_parameter_names
                                          onChanged: (num) {
                                            setState(() {
                                              loginPageController.landInAcres =
                                                  num;
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
                                weight: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.fontWeight,
                                size: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.fontSize,
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
                                      if (loginPageController
                                          .userCertificates.isNotEmpty) {
                                        if (loginPageController
                                            .userCertificates[index]
                                            .isNotEmpty) {
                                          loginPageController
                                              .userCertificates[index] = [];
                                        }
                                      }
                                      loginPageController.userCertification =
                                          loginProvider
                                              .certificationList[index];
                                      loginPageController
                                          .registrationPageFormControllers[
                                              "reg_number"]
                                          ?.text = "";
                                    });
                                  },
                                  child: Container(
                                    color:
                                        loginPageController.userCertification ==
                                                loginProvider
                                                    .certificationList[index]
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.5)),
                                                  activeColor: loginProvider
                                                          .userAppTheme.key
                                                          .contains(
                                                              "Restaraunts")
                                                      ? Colors.green[900]
                                                      : Colors.white,
                                                  checkColor: Theme.of(context)
                                                      .primaryColor,
                                                  value: loginPageController
                                                          .userCertification ==
                                                      loginProvider
                                                              .certificationList[
                                                          index],
                                                  onChanged: (boolean) {
                                                    setState(() {
                                                      if (loginPageController
                                                          .userCertificates
                                                          .isNotEmpty) {
                                                        if (loginPageController
                                                            .userCertificates[
                                                                index]
                                                            .isNotEmpty) {
                                                          loginPageController
                                                                  .userCertificates[
                                                              index] = [];
                                                        }
                                                      }
                                                      loginPageController
                                                              .userCertification =
                                                          loginProvider
                                                                  .certificationList[
                                                              index];
                                                      loginPageController
                                                          .registrationPageFormControllers[
                                                              "reg_number"]
                                                          ?.text = "";
                                                    });
                                                  }),
                                              Expanded(
                                                child: SizedBox(
                                                  child: TextWidget(
                                                    loginProvider
                                                            .certificationList[
                                                        index],
                                                    weight: FontWeight.w500,
                                                    color: loginPageController
                                                                .userCertification ==
                                                            loginProvider
                                                                    .certificationList[
                                                                index]
                                                        ? loginProvider
                                                                .userAppTheme
                                                                .key
                                                                .contains(
                                                                    "Restaraunts")
                                                            ? Colors.green[900]
                                                            : Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              )
                                            ]),
                                        (loginProvider.isFarmer
                                                    ? index != 0
                                                    : true) &&
                                                index != 5 &&
                                                loginPageController
                                                        .userCertification ==
                                                    loginProvider
                                                            .certificationList[
                                                        index]
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 42,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const TextWidget(
                                                            "Reference Number",
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getProportionateWidth(
                                                                    136,
                                                                    constraints),
                                                            child: Form(
                                                              key: loginPageController
                                                                  .registrationFormSecondPageKey,
                                                              child:
                                                                  TextFormField(
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                onChanged: (_) {
                                                                  setState(
                                                                      () {});
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                8,
                                                                            horizontal:
                                                                                16),
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        counterStyle: fonts(
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodySmall
                                                                                ?.fontSize,
                                                                            FontWeight
                                                                                .normal,
                                                                            Colors
                                                                                .white),
                                                                        hintStyle: fonts(
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium
                                                                                ?.fontSize,
                                                                            FontWeight
                                                                                .w500,
                                                                            Colors.grey[
                                                                                400]),
                                                                        hintText:
                                                                            'Registration Number',
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        isDense:
                                                                            true,
                                                                        errorBorder:
                                                                            InputBorder.none),
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                          ?.isEmpty ??
                                                                      false) {
                                                                    snackbar(
                                                                        context,
                                                                        "Please enter a valid certificate registration number");
                                                                    return " ";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                controller: loginPageController
                                                                        .registrationPageFormControllers[
                                                                    "reg_number"],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const TextWidget(
                                                          "Upload Certificate",
                                                          color: Colors.white,
                                                        ),
                                                        Row(
                                                          children: [
                                                            MaterialButton(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        16),
                                                                color: Colors
                                                                    .white,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                onPressed: () {
                                                                  showImagePickerSheet(
                                                                    constraints:
                                                                        constraints,
                                                                    onImageSelected:
                                                                        (XFile
                                                                            certificate) {
                                                                      if (loginPageController
                                                                          .userCertificates
                                                                          .isEmpty) {
                                                                        for (var element
                                                                            in loginProvider.certificationList) {
                                                                          loginPageController
                                                                              .userCertificates
                                                                              .add([]);
                                                                        }
                                                                      }
                                                                      loginPageController
                                                                          .userCertificates[
                                                                              index]
                                                                          .add(
                                                                              certificate);
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    const TextWidget(
                                                                  "Choose File",
                                                                )),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .archive_rounded,
                                                              color: Colors
                                                                  .white
                                                                  .withAlpha(
                                                                      150),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 24,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                        (loginProvider.isFarmer
                                                    ? index != 0
                                                    : true) &&
                                                index != 5 &&
                                                loginPageController
                                                    .userCertificates
                                                    .isNotEmpty &&
                                                loginPageController
                                                        .userCertification ==
                                                    loginProvider
                                                            .certificationList[
                                                        index] &&
                                                loginPageController
                                                    .userCertificates[index]
                                                    .isNotEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 96),
                                                child: SizedBox(
                                                  height: 120,
                                                  child: ListView.builder(
                                                    itemCount:
                                                        loginPageController
                                                            .userCertificates[
                                                                index]
                                                            .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemBuilder:
                                                        (context, imageIndex) {
                                                      // log(registrationController
                                                      //    .userCertificates);
                                                      return Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child: Image.file(
                                                                File(loginPageController
                                                                    .userCertificates[
                                                                        index][
                                                                        imageIndex]
                                                                    .path),
                                                                height: 96,
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            child: Container(
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  loginPageController
                                                                      .userCertificates[
                                                                          index]
                                                                      .removeAt(
                                                                          imageIndex);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .delete_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        constraints.maxWidth < 500
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                child: ElevatedButtonWidget(
                                    onClick: () async {
                                      var formValidatedState =
                                          loginPageController
                                                  .registrationFormKey
                                                  .currentState
                                                  ?.validate() ??
                                              false;

                                      if (formValidatedState) {
                                        if (loginPageController.profileImage ==
                                            null) {
                                          formValidatedState = false;
                                          snackbar(
                                              context,
                                              "Please upload ${loginProvider.isFarmer ? "the Farmer" : loginProvider.userAppTheme.key.contains("Store") ? "your" : "your"} image");
                                        }
                                        if (!loginProvider.isFarmer) {
                                          if (loginPageController.storeLogo ==
                                              null) {
                                            formValidatedState = false;
                                            snackbar(context,
                                                "Please upload the ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"}'s logo");
                                          }
                                        }

                                        if (formValidatedState) {
                                          var formValidatedState =
                                              loginPageController
                                                      .registrationFormSecondPageKey
                                                      .currentState
                                                      ?.validate() ??
                                                  true;

                                          if (loginPageController.landInAcres >
                                              1) {
                                            if (formValidatedState &&
                                                loginPageController
                                                    .userCertification
                                                    .isNotEmpty) {
                                              if ((loginPageController
                                                          .userCertification
                                                          .isNotEmpty &&
                                                      loginPageController
                                                          .userCertificates
                                                          .where((element) =>
                                                              element
                                                                  .isNotEmpty)
                                                          .isNotEmpty) ||
                                                  loginPageController
                                                          .registrationFormSecondPageKey
                                                          .currentState ==
                                                      null) {
                                                profileProvider.showLoader();

                                                Map<String, String>
                                                    userAddress = {
                                                  "coordinates-x":
                                                      (loginPageController
                                                                  .location
                                                                  ?.latitude ??
                                                              0)
                                                          .toString(),
                                                  "coordinates-y":
                                                      (loginPageController
                                                                  .location
                                                                  ?.longitude ??
                                                              0)
                                                          .toString(),
                                                  "houseNumber": loginPageController
                                                          .registrationPageFormControllers[
                                                              "house_number"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "city": loginPageController
                                                          .registrationPageFormControllers[
                                                              "city"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "mandal": loginPageController
                                                          .registrationPageFormControllers[
                                                              "mandal"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "district": loginPageController
                                                          .registrationPageFormControllers[
                                                              "district"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "state": loginPageController
                                                          .registrationPageFormControllers[
                                                              "state"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "pincode": loginPageController
                                                          .registrationPageFormControllers[
                                                              "pincode"]
                                                          ?.text
                                                          .toString() ??
                                                      ""
                                                };

                                                var sellerImageURL =
                                                    await uploadFilesToCloud(
                                                        loginPageController
                                                            .profileImage,
                                                        cloudLocation:
                                                            "profile_pics");
                                                var storeLogoURL = "";
                                                if (!loginProvider.isFarmer) {
                                                  storeLogoURL =
                                                      await uploadFilesToCloud(
                                                          loginPageController
                                                              .storeLogo,
                                                          cloudLocation:
                                                              "logo");
                                                }
                                                List<String> certificatesURLs =
                                                    [];
                                                if (loginPageController
                                                    .userCertificates
                                                    .where((element) =>
                                                        element.isEmpty)
                                                    .isNotEmpty) {
                                                  await Future.forEach<XFile>(
                                                      loginPageController
                                                          .userCertificates
                                                          .firstWhere((element) =>
                                                              element
                                                                  .isNotEmpty),
                                                      (element) async {
                                                    String urlData =
                                                        await uploadFilesToCloud(
                                                            element,
                                                            cloudLocation:
                                                                "legal_docs",
                                                            fileType: ".jpg");
                                                    certificatesURLs
                                                        .add(urlData);
                                                  });
                                                }
                                                Map<String, String> body = {
                                                  "user_id": profileProvider
                                                      .userIdForAddress,
                                                  "firstname": loginPageController
                                                          .registrationPageFormControllers[
                                                              "first_name"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "lastname": loginPageController
                                                          .registrationPageFormControllers[
                                                              "last_name"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "email": loginPageController
                                                          .registrationPageFormControllers[
                                                              "email"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "telephone": FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          ?.phoneNumber ??
                                                      phoneNumberController
                                                          .text,
                                                  "password": loginPageController
                                                          .registrationPageFormControllers[
                                                              "password"]
                                                          ?.text
                                                          .toString() ??
                                                      "",
                                                  "seller_type": loginProvider
                                                      .userAppTheme.key
                                                      .toString(),
                                                  "land": loginPageController
                                                      .landInAcres
                                                      .toString(),
                                                  "seller_image":
                                                      sellerImageURL.toString(),
                                                  "additional_comments":
                                                      "Farmer is the backbone of India",
                                                  "additional_documents":
                                                      loginPageController
                                                          .userCertification,
                                                  "upload_document":
                                                      certificatesURLs
                                                          .toString(), //TODO: Check with backend on how to parse data
                                                  "store_address":
                                                      userAddress.toString(),
                                                  "store_status": 1.toString(),
                                                  "language": (loginProvider
                                                              .languages.entries
                                                              .toList()
                                                              .indexOf(loginProvider
                                                                  .usersLanguage) +
                                                          1)
                                                      .toString(),
                                                  // "agree": "1"
                                                };
                                                if (!loginProvider.isFarmer) {
                                                  body.addEntries([
                                                    MapEntry(
                                                        "seller_storename",
                                                        loginPageController
                                                                .registrationPageFormControllers[
                                                                    "storeName"]
                                                                ?.text
                                                                .toString() ??
                                                            ""),
                                                    MapEntry(
                                                      "store_logo",
                                                      storeLogoURL.toString(),
                                                    )
                                                  ]);
                                                } else {
                                                  //TODO: Check with backend
                                                  body.addEntries([
                                                    MapEntry(
                                                        "seller_storename",
                                                        loginPageController
                                                                .registrationPageFormControllers[
                                                                    "first_name"]
                                                                ?.text
                                                                .toString() ??
                                                            "XYZ"),
                                                    MapEntry(
                                                      "store_logo",
                                                      sellerImageURL,
                                                    )
                                                  ]);
                                                }

                                                var response = await Server()
                                                    .postFormData(
                                                        body: body,
                                                        url:
                                                            "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/updateparticularuser")
                                                    .catchError((e) {
                                                  log("64$e");
                                                });
                                                if (response?.statusCode ==
                                                    200) {
                                                  var decodedResponse =
                                                      jsonDecode(response
                                                              ?.body ??
                                                          '{"message": {},"success": false}');
                                                  log(response?.body ?? "");
                                                  var statusCodeBody = false;
                                                  if (decodedResponse[
                                                          "success"] !=
                                                      null) {
                                                    statusCodeBody =
                                                        decodedResponse[
                                                            "success"];
                                                  } else {
                                                    statusCodeBody =
                                                        decodedResponse[
                                                            "status"];
                                                  }
                                                  if (statusCodeBody) {
                                                    log("Successful update");
                                                    snackbar(context,
                                                        "Successfully updated your profile",
                                                        isError: false);
                                                    Navigator.of(context).pop();
                                                    profileProvider
                                                        .hideLoader();
                                                  } else {
                                                    snackbar(context,
                                                        "Failed to update, error: ${decodedResponse["message"]}");
                                                    profileProvider
                                                        .hideLoader();
                                                  }
                                                } else {
                                                  snackbar(context,
                                                      "Oops! Couldn't update your profile: ${response?.statusCode}");
                                                  profileProvider.hideLoader();
                                                  Navigator.of(context).pop();
                                                }
                                              } else {
                                                snackbar(context,
                                                    "Please upload a valid certificate");
                                              }
                                            } else {
                                              snackbar(context,
                                                  "Please select a certification type");
                                            }
                                          } else {
                                            snackbar(context,
                                                "Please select your cultivated land in acres with the slider");
                                          }
                                        }
                                      }
                                    },
                                    height:
                                        getProportionateHeight(64, constraints),
                                    borderRadius: 12,
                                    bgColor: Theme.of(context).primaryColor,
                                    textColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    buttonName: "Update".toUpperCase(),
                                    innerPadding: 0.02,
                                    trailingIcon: Icons.arrow_forward),
                              )
                            : const SizedBox(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/farmer_ploughing.png',
                            width: 300,
                          ),
                        )
                      ],
                    ),
                  ));
            }),
            profileProvider.shouldShowLoader
                ? const LoaderScreen()
                : const SizedBox(),
          ],
        );
      });
    });
  }
}
