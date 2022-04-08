import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/model/user.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/nandi_krushi_title.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  PageController pageController = PageController(initialPage: 0);
  var acresInInt = 1.0;
  var checkBoxStates = [true, false, false, false, false, false];
  var user = User();
  var formControllers = {
    'farmer_name': TextEditingController(),
    'house_number': TextEditingController(),
    'city': TextEditingController(),
    'mandal': TextEditingController(),
    'district': TextEditingController(),
    'state': TextEditingController(),
    'pincode': TextEditingController()
  };
  var checkBoxStatesText = [
    'Self Declared Natural Farmer',
    'PGS India Green',
    'PGS India Organic',
    'Organic FPO',
    'Organic FPC',
    'Other Certification +'
  ];
  @override
  Widget build(BuildContext context) {
    checkBoxStatesText = SpotmiesTheme.appTheme == UserAppTheme.RESTERAUNT
        ? [
            'FSSAI',
            'Eating House License',
            'Fire Safety License',
            'Certificate of Environmental Clearance',
            'Other Certification +'
          ]
        : [
            'FSSAI',
            'Fire Safety License',
            'Certificate of Environmental Clearance',
            'Other Certification +'
          ];
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: 2,
        itemBuilder: (context, pageIndex) {
          return SingleChildScrollView(
            child: SizedBox(
              height: height(context),
              width: width(context),
              child: Stack(
                children: [
                  Positioned(
                    top: -(height(context) * 0.03),
                    left: width(context) * 0.48,
                    child: const Image(
                      image: AssetImage("assets/png/ic_farmer.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height(context) * 0.08),
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.1),
                    child: const NandiKrushiTitle(),
                  ),
                  Column(children: [
                    SizedBox(
                      height: height(context) * 0.15,
                    ),
                    TextWidget(
                      text: "Create Account".toUpperCase(),
                      color: const Color(0xFF006838),
                      weight: FontWeight.w900,
                      size: height(context) * 0.02,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          children: pageIndex == 0
                              ? [
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  IconButton(
                                    iconSize: height(context) * 0.1,
                                    color: SpotmiesTheme.primaryColor,
                                    onPressed: () {
                                      log("Hello");
                                    },
                                    splashRadius: height(context) * 0.05,
                                    icon: const Icon(Icons.add_a_photo_rounded),
                                  ),
                                  TextWidget(
                                    text:
                                        "Add ${SpotmiesTheme.appTheme == UserAppTheme.FARMER ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.STORE ? "Store" : "Restaurant"} Image",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text:
                                              "${SpotmiesTheme.appTheme == UserAppTheme.FARMER ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.STORE ? "Store" : "Restaurant"} Information",
                                          color: Colors.grey.shade800,
                                          weight: FontWeight.bold,
                                          size: height(context) * 0.02,
                                        ),
                                        TextFieldWidget(
                                          controller:
                                              formControllers['farmer_name'],
                                          label:
                                              '${SpotmiesTheme.appTheme == UserAppTheme.FARMER ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.STORE ? "Store" : "Restaurant"} Name',
                                          hintSize: 20,
                                          style: fonts(20.0, FontWeight.w500,
                                              Colors.black),
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
                                                controller: formControllers[
                                                    'house_number'],
                                                label: 'H.No.',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    20.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.05,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller:
                                                    formControllers['mandal'],
                                                label: 'Mandal',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
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
                                                controller:
                                                    formControllers['city'],
                                                label: 'City/Vilage',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.05,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller:
                                                    formControllers['district'],
                                                label: 'District',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
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
                                                controller:
                                                    formControllers['state'],
                                                label: 'State',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.05,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller:
                                                    formControllers['pincode'],
                                                label: 'Pincode',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    20.0,
                                                    FontWeight.w500,
                                                    Colors.black),
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
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.only(
                                          bottom: height(context) * 0.03),
                                      child: ElevatedButtonWidget(
                                        onClick: () {
                                          var farmerName =
                                              formControllers['farmer_name']
                                                      ?.text ??
                                                  "";
                                          var houseNumber =
                                              formControllers['house_number']
                                                      ?.text ??
                                                  "";
                                          var mandal =
                                              formControllers['mandal']?.text ??
                                                  "";
                                          var city =
                                              formControllers['city']?.text ??
                                                  "";
                                          var district =
                                              formControllers['district']
                                                      ?.text ??
                                                  "";
                                          var state =
                                              formControllers['state']?.text ??
                                                  "";
                                          var pincode =
                                              formControllers['pincode']
                                                      ?.text ??
                                                  "";
                                          user = User.registerPartA(
                                              farmerName: farmerName,
                                              city: city,
                                              houseNumber: houseNumber,
                                              district: district,
                                              mandal: mandal,
                                              farmerImage: "IMAGE",
                                              pincode: pincode,
                                              state: state);

                                          log(user.toString());

                                          pageController.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut);
                                        },
                                        minWidth: width(context) * 0.85,
                                        height: height(context) * 0.06,
                                        borderRadius: 0,
                                        allRadius: true,
                                        bgColor: SpotmiesTheme.primaryColor,
                                        textColor: SpotmiesTheme.appTheme ==
                                                UserAppTheme.RESTERAUNT
                                            ? Colors.black
                                            : Colors.white,
                                        buttonName:
                                            (pageIndex == 1 ? "Submit" : "Next")
                                                .toUpperCase(),
                                        innerPadding: 0.02,
                                        textSize: width(context) * 0.045,
                                        // textStyle: FontWeight.bold,
                                        trailingIcon: Icon(
                                          pageIndex == 0
                                              ? Icons.arrow_forward
                                              : Icons.check_rounded,
                                          color: SpotmiesTheme.appTheme ==
                                                  UserAppTheme.RESTERAUNT
                                              ? Colors.black
                                              : Colors.white,
                                          size: width(context) * 0.045,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              : [
                                  Container(
                                    padding:
                                        EdgeInsets.all(width(context) * 0.08),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SpotmiesTheme.appTheme ==
                                                UserAppTheme.FARMER
                                            ? TextWidget(
                                                text:
                                                    "Cultivated Land Area (in acres)",
                                                color: Colors.grey.shade800,
                                                weight: FontWeight.bold,
                                                size: height(context) * 0.02,
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: SpotmiesTheme.appTheme ==
                                                  UserAppTheme.FARMER
                                              ? height(context) * 0.02
                                              : 0,
                                        ),
                                        SpotmiesTheme.appTheme ==
                                                UserAppTheme.FARMER
                                            ? SliderTheme(
                                                data: SliderThemeData(
                                                    activeTickMarkColor:
                                                        SpotmiesTheme
                                                                    .appTheme ==
                                                                UserAppTheme
                                                                    .RESTERAUNT
                                                            ? Colors.black
                                                            : Colors.white,
                                                    inactiveTickMarkColor:
                                                        SpotmiesTheme
                                                                    .appTheme ==
                                                                UserAppTheme
                                                                    .RESTERAUNT
                                                            ? Colors.black
                                                            : Colors.white),
                                                child: Slider(
                                                    divisions: 30,
                                                    thumbColor:
                                                        const Color(0xFF006838),
                                                    activeColor:
                                                        const Color(0xFF006838),
                                                    inactiveColor:
                                                        const Color(0x16006838),
                                                    value: acresInInt,
                                                    max: 30,
                                                    min: 1,
                                                    label: (acresInInt)
                                                        .round()
                                                        .toString(),
                                                    // ignore: avoid_types_as_parameter_names
                                                    onChanged: (num) {
                                                      log("$num");
                                                      setState(() {
                                                        acresInInt = num;
                                                      });
                                                    }),
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        TextWidget(
                                          text: "Select Certification Details",
                                          color: Colors.grey.shade800,
                                          weight: FontWeight.bold,
                                          size: height(context) * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ListView.builder(
                                          itemCount: checkBoxStatesText.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  for (int i = 0;
                                                      i <=
                                                          (checkBoxStatesText
                                                                  .length -
                                                              1);
                                                      i++) {
                                                    checkBoxStates[i] = false;
                                                  }
                                                  checkBoxStates[index] = true;
                                                });
                                              },
                                              child: Container(
                                                color: checkBoxStates[index]
                                                    ? SpotmiesTheme.primaryColor
                                                    : Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Checkbox(
                                                              activeColor: SpotmiesTheme
                                                                          .appTheme ==
                                                                      UserAppTheme
                                                                          .RESTERAUNT
                                                                  ? Colors.green[
                                                                      900]
                                                                  : Colors
                                                                      .white,
                                                              checkColor:
                                                                  SpotmiesTheme
                                                                      .primaryColor,
                                                              value:
                                                                  checkBoxStates[
                                                                      index],
                                                              onChanged:
                                                                  (boolean) {
                                                                setState(() {
                                                                  for (int i =
                                                                          0;
                                                                      i <= 5;
                                                                      i++) {
                                                                    checkBoxStates[
                                                                            i] =
                                                                        false;
                                                                  }
                                                                  checkBoxStates[
                                                                          index] =
                                                                      boolean ??
                                                                          false;
                                                                });
                                                              }),
                                                          SizedBox(
                                                            width:
                                                                width(context) *
                                                                    0.6,
                                                            child: TextWidget(
                                                              text:
                                                                  checkBoxStatesText[
                                                                      index],
                                                              weight: FontWeight
                                                                  .w600,
                                                              color: checkBoxStates[
                                                                      index]
                                                                  ? SpotmiesTheme
                                                                              .appTheme ==
                                                                          UserAppTheme
                                                                              .RESTERAUNT
                                                                      ? Colors.green[
                                                                          900]
                                                                      : Colors
                                                                          .white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          )
                                                        ]),
                                                    (SpotmiesTheme.appTheme ==
                                                                    UserAppTheme
                                                                        .FARMER
                                                                ? index != 0
                                                                : true) &&
                                                            index != 5 &&
                                                            checkBoxStates[
                                                                index]
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                                SizedBox(
                                                                  width: width(
                                                                          context) *
                                                                      0.1,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    const TextWidget(
                                                                      text:
                                                                          "Reference Number",
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: width(
                                                                              context) *
                                                                          0.32,
                                                                      height: height(
                                                                              context) *
                                                                          0.05,
                                                                      child:
                                                                          const FilledTextFieldWidget(
                                                                        label:
                                                                            "",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    const TextWidget(
                                                                      text:
                                                                          "Upload Certificate",
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        MaterialButton(
                                                                            padding:
                                                                                const EdgeInsets.all(0),
                                                                            color: Colors.white,
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                            onPressed: () {},
                                                                            child: const TextWidget(
                                                                              text: "Choose File",
                                                                            )),
                                                                        Icon(
                                                                          Icons
                                                                              .archive_rounded,
                                                                          color: Colors
                                                                              .white
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
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: height(context) * 0.03),
                                    child: ElevatedButtonWidget(
                                      onClick: () {
                                        if (pageIndex == 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NavBar()));
                                        } else {
                                          var farmerName =
                                              formControllers['farmer_name']
                                                      ?.text ??
                                                  "";
                                          var houseNumber =
                                              formControllers['house_number']
                                                      ?.text ??
                                                  "";
                                          var mandal =
                                              formControllers['mandal']?.text ??
                                                  "";
                                          var city =
                                              formControllers['city']?.text ??
                                                  "";
                                          var district =
                                              formControllers['district']
                                                      ?.text ??
                                                  "";
                                          var state =
                                              formControllers['state']?.text ??
                                                  "";
                                          var pincode =
                                              formControllers['pincode']
                                                      ?.text ??
                                                  "";
                                          user = User.registerPartA(
                                              farmerName: farmerName,
                                              city: city,
                                              houseNumber: houseNumber,
                                              district: district,
                                              mandal: mandal,
                                              farmerImage: "IMAGE",
                                              pincode: pincode,
                                              state: state);

                                          log(user.toString());

                                          pageController.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const NavBar()),
                                              (route) => false);
                                        }
                                      },
                                      minWidth: width(context) * 0.85,
                                      height: height(context) * 0.06,
                                      borderRadius: 0,
                                      allRadius: true,
                                      bgColor: SpotmiesTheme.primaryColor,
                                      textColor: SpotmiesTheme.appTheme ==
                                              UserAppTheme.RESTERAUNT
                                          ? Colors.black
                                          : Colors.white,
                                      buttonName:
                                          (pageIndex == 1 ? "Submit" : "Next")
                                              .toUpperCase(),
                                      innerPadding: 0.02,
                                      textSize: width(context) * 0.045,
                                      // textStyle: FontWeight.bold,
                                      trailingIcon: Icon(
                                        pageIndex == 0
                                            ? Icons.arrow_forward
                                            : Icons.check_rounded,
                                        color: SpotmiesTheme.appTheme ==
                                                UserAppTheme.RESTERAUNT
                                            ? Colors.black
                                            : Colors.white,
                                        size: width(context) * 0.045,
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
