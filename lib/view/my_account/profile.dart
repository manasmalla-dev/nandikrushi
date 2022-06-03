import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushifarmer/controller/registration_controller.dart';
import 'package:nandikrushifarmer/model/user.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateMVC<ProfileScreen> {
  late RegistrationController homeController;

  _ProfileScreenState() : super(RegistrationController()) {
    homeController = controller as RegistrationController;
  }
  // var acresInInt = 1.0;
  // var checkBoxStates = [true, false, false, false, false, false];
  // var user = User();
  // var formControllers = {
  //   'farmer_name': TextEditingController(),
  //   'house_number': TextEditingController(),
  //   'city': TextEditingController(),
  //   'mandal': TextEditingController(),
  //   'district': TextEditingController(),
  //   'state': TextEditingController(),
  //   'pincode': TextEditingController()
  // };
  // var checkBoxStatesText = [
  //   'Self Declared Natural Farmer',
  //   'PGS India Green',
  //   'PGS India Organic',
  //   'Organic FPO',
  //   'Organic FPC',
  //   'Other Certification +'
  // ];
  @override
  Widget build(BuildContext context) {
    homeController.fetchUserData(context);
    return Scaffold(
        appBar: appBarWithTitle(context, title: 'Profile'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: height(context) * 0.02,
              ),
              IconButton(
                iconSize: height(context) * 0.1,
                color: const Color(0xFF3da894),
                onPressed: () {
                  log("Hello");
                },
                splashRadius: height(context) * 0.05,
                icon: const Icon(Icons.add_a_photo_rounded),
              ),
              TextWidget(
                text: "Add Farmer Image",
                color: Colors.grey,
                weight: FontWeight.bold,
                size: height(context) * 0.02,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: width(context) * 0.075,
                    vertical: width(context) * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Farmer Information",
                      color: Colors.grey.shade800,
                      weight: FontWeight.bold,
                      size: height(context) * 0.02,
                    ),
                    TextFieldWidget(
                      controller: homeController.formControllers['first_name'],
                      label: 'Farmer Name',
                      hintSize: 20,
                      style: fonts(20.0, FontWeight.w500, Colors.black),
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    ),
                    TextWidget(
                      text: "Location Details",
                      color: Colors.grey.shade800,
                      weight: FontWeight.bold,
                      size: height(context) * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            controller:
                                homeController.formControllers['house_number'],
                            label: 'H.No.',
                            hintSize: 20,
                            hintColor: Colors.grey.shade600,
                            style: fonts(20.0, FontWeight.w500, Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.05,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            controller:
                                homeController.formControllers['mandal'],
                            label: 'Mandal',
                            hintSize: 20,
                            hintColor: Colors.grey.shade600,
                            style: fonts(15.0, FontWeight.w500, Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            controller: homeController.formControllers['city'],
                            label: 'City/Vilage',
                            hintSize: 20,
                            hintColor: Colors.grey.shade600,
                            style: fonts(15.0, FontWeight.w500, Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.05,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            controller:
                                homeController.formControllers['district'],
                            label: 'District',
                            hintSize: 20,
                            hintColor: Colors.grey.shade600,
                            style: fonts(15.0, FontWeight.w500, Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            controller: homeController.formControllers['state'],
                            label: 'State',
                            hintSize: 20,
                            hintColor: Colors.grey.shade600,
                            style: fonts(15.0, FontWeight.w500, Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.05,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            textInputAction: TextInputAction.done,
                            controller:
                                homeController.formControllers['pincode'],
                            label: 'Pincode',
                            hintSize: 20,
                            hintColor: Colors.grey.shade600,
                            style: fonts(20.0, FontWeight.w500, Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.015,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Cultivated Land Area (in acres)",
                      color: Colors.grey.shade800,
                      weight: FontWeight.bold,
                      size: height(context) * 0.02,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    SliderTheme(
                      data: const SliderThemeData(
                          activeTickMarkColor: Colors.white,
                          inactiveTickMarkColor: Colors.white),
                      child: Slider(
                          divisions: 30,
                          thumbColor: const Color(0xFF368b86),
                          activeColor: const Color(0xFF368b86),
                          inactiveColor: const Color(0x16368b86),
                          value: homeController.acresInInt,
                          max: 30,
                          min: 1,
                          label: (homeController.acresInInt).round().toString(),
                          // ignore: avoid_types_as_parameter_names
                          onChanged: (num) {
                            log("$num");
                            setState(() {
                              homeController.acresInInt = num;
                            });
                          }),
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    TextWidget(
                      text: "Select Certification Details",
                      color: Colors.grey.shade800,
                      weight: FontWeight.bold,
                      size: height(context) * 0.02,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            for (int i = 0; i <= 5; i++) {
                              homeController.checkBoxStates[i] = false;
                            }
                            homeController.checkBoxStates[index] = true;
                          });
                        },
                        child: Container(
                          color: homeController.checkBoxStates[index]
                              ? const Color(0xFF3da894)
                              : Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.white,
                                        checkColor: const Color(0xFF368b86),
                                        value: homeController
                                            .checkBoxStates[index],
                                        onChanged: (boolean) {
                                          setState(() {
                                            for (int i = 0; i <= 5; i++) {
                                              homeController.checkBoxStates[i] =
                                                  false;
                                            }
                                            homeController
                                                    .checkBoxStates[index] =
                                                boolean ?? false;
                                          });
                                        }),
                                    SizedBox(
                                      width: width(context) * 0.6,
                                      child: TextWidget(
                                        text: homeController
                                            .checkBoxStatesText[index],
                                        weight: FontWeight.w600,
                                        color:
                                            homeController.checkBoxStates[index]
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    )
                                  ]),
                              index != 0 &&
                                      index != 5 &&
                                      homeController.checkBoxStates[index]
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          SizedBox(
                                            width: width(context) * 0.1,
                                          ),
                                          Column(
                                            children: [
                                              const TextWidget(
                                                text: "Reference Number",
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: width(context) * 0.32,
                                                height: height(context) * 0.05,
                                                child:
                                                    const FilledTextFieldWidget(
                                                  label: "",
                                                ),
                                              ),
                                            ],
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      onPressed: () {},
                                                      child: const TextWidget(
                                                        text: "Choose File",
                                                      )),
                                                  Icon(
                                                    Icons.archive_rounded,
                                                    color: Colors.white
                                                        .withAlpha(150),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ])
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: height(context) * 0.03),
                child: ElevatedButtonWidget(
                  onClick: () {
                    homeController.user = User.registerPartA(
                        firstName:
                            homeController.formControllers['first_name']?.text ??
                                "",
                        lastName:
                            homeController.formControllers['last_name']?.text ??
                                "",
                        email:
                            homeController.formControllers['email']?.text ?? "",
                        telePhone:
                            homeController.formControllers['telePhone']?.text ??
                                "",
                        pass: homeController.formControllers['password']?.text ??
                            "",
                        cpass:
                            homeController.formControllers['c_password']?.text ??
                                "",
                        city:
                            homeController.formControllers['city']?.text ?? "",
                        houseNumber:
                            homeController.formControllers['house_number']?.text ?? "",
                        district: homeController.formControllers['district']?.text ?? "",
                        mandal: homeController.formControllers['mandal']?.text ?? "",
                        farmerImage: "IMAGE",
                        pincode: homeController.formControllers['pincode']?.text ?? "",
                        state: homeController.formControllers['state']?.text ?? "");

                    log(homeController.user.toString());
                  },
                  minWidth: width(context) * 0.85,
                  height: height(context) * 0.06,
                  borderRadius: 8,
                  allRadius: true,
                  bgColor: const Color(0xFF368b86),
                  textColor: Colors.white,
                  buttonName: "Update".toUpperCase(),
                  innerPadding: 0.02,
                  textSize: width(context) * 0.045,
                  // textStyle: FontWeight.bold,
                  trailingIcon: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: width(context) * 0.045,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/png/farmer_ploughing.png',
                  width: width(context) * 0.7,
                ),
              )
            ],
          ),
        ));
  }
}
