import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  PageController pageController =  PageController(initialPage: 0);
  var acresInInt = 0.0;
  var checkBoxStates = [true, false, false, false, false, false];
  var checkBoxStatesText = [
    'Self Declared Natural Farmer',
    'PGS India Green',
    'PGS India Organic',
    'Organic FPO',
    'Organic FPC',
    'Other Certification'
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageController,
        itemCount: 2,
        itemBuilder: (context, page) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(children: [
              Positioned(
                top: -(height(context) * 0.03),
                left: width(context) * 0.48,
                child: const Image(
                  image: AssetImage("assets/images/ic_farmer.png"),
                ),
              ),
              SizedBox(
                height: height(context) * 0.12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.1),
                      child: Text(
                        "Nandikrushi",
                        style: TextStyle(
                            color: const Color(0xFF006838),
                            fontFamily: 'Samarkan',
                            fontSize: height(context) * 0.034),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
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
                    Container(
                      height: height(context) * 0.92,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          page == 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: height(context) * 0.02,
                                    ),
                                    IconButton(
                                      iconSize: height(context) * 0.1,
                                      color: const Color(0xFF006838),
                                      onPressed: () {
                                        log("Hello");
                                      },
                                      splashRadius: height(context) * 0.05,
                                      icon:
                                          const Icon(Icons.add_a_photo_rounded),
                                    ),
                                    TextWidget(
                                      text: "Add Farmer Image",
                                      color: Colors.grey,
                                      weight: FontWeight.bold,
                                      size: height(context) * 0.02,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.all(
                                          width(context) * 0.075),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: "Farmer Information",
                                            color: Colors.grey.shade800,
                                            weight: FontWeight.bold,
                                            size: height(context) * 0.02,
                                          ),
                                          TextFieldWidget(
                                            label: 'Farmer Name',
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
                                          SizedBox(
                                            height: height(context) * 0.4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFieldWidget(
                                                        label: 'H.No.',
                                                        hintSize: 20,
                                                        hintColor: Colors
                                                            .grey.shade600,
                                                        style: fonts(
                                                            20.0,
                                                            FontWeight.w500,
                                                            Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          width(context) * 0.05,
                                                    ),
                                                    Expanded(
                                                      child: TextFieldWidget(
                                                        label: 'Mandal',
                                                        hintSize: 20,
                                                        hintColor: Colors
                                                            .grey.shade600,
                                                        style: fonts(
                                                            15.0,
                                                            FontWeight.w500,
                                                            Colors.black),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFieldWidget(
                                                        label: 'City/Vilage',
                                                        hintSize: 20,
                                                        hintColor: Colors
                                                            .grey.shade600,
                                                        style: fonts(
                                                            15.0,
                                                            FontWeight.w500,
                                                            Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          width(context) * 0.05,
                                                    ),
                                                    Expanded(
                                                      child: TextFieldWidget(
                                                        label: 'District',
                                                        hintSize: 20,
                                                        hintColor: Colors
                                                            .grey.shade600,
                                                        style: fonts(
                                                            15.0,
                                                            FontWeight.w500,
                                                            Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFieldWidget(
                                                        label: 'State',
                                                        hintSize: 20,
                                                        hintColor: Colors
                                                            .grey.shade600,
                                                        style: fonts(
                                                            15.0,
                                                            FontWeight.w500,
                                                            Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          width(context) * 0.05,
                                                    ),
                                                    Expanded(
                                                      child: TextFieldWidget(
                                                        label: 'Pincode',
                                                        hintSize: 20,
                                                        hintColor: Colors
                                                            .grey.shade600,
                                                        style: fonts(
                                                            20.0,
                                                            FontWeight.w500,
                                                            Colors.black),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                            width(context) * 0.08),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text:
                                                  "Cultivated Land Area (in acres)",
                                              color: Colors.grey.shade800,
                                              weight: FontWeight.bold,
                                              size: height(context) * 0.02,
                                            ),
                                            SizedBox(
                                              height: height(context) * 0.03,
                                            ),
                                            Slider(
                                                thumbColor:
                                                    const Color(0xFF006838),
                                                activeColor:
                                                    const Color(0xFF006838),
                                                inactiveColor:
                                                    const Color(0x16006838),
                                                value: acresInInt,
                                                // ignore: avoid_types_as_parameter_names
                                                onChanged: (num) {
                                                  setState(() {
                                                    acresInInt = num;
                                                  });
                                                }),
                                            SizedBox(
                                              height: height(context) * 0.03,
                                            ),
                                            TextWidget(
                                              text:
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
                                        height: height(context) * 0.5,
                                        child: ListView.builder(
                                            itemCount: 6,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <= 5;
                                                        i++) {
                                                      checkBoxStates[i] = false;
                                                    }
                                                    checkBoxStates[index] =
                                                        true;
                                                  });
                                                },
                                                child: Container(
                                                  color: checkBoxStates[index]
                                                      ? const Color(0xFF006838)
                                                      : Colors.transparent,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color(
                                                                    0xFF006838),
                                                            value:
                                                                checkBoxStates[
                                                                    index],
                                                            onChanged:
                                                                (boolean) {
                                                              setState(() {
                                                                for (int i = 0;
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
                                                            weight:
                                                                FontWeight.w600,
                                                            color:
                                                                checkBoxStates[
                                                                        index]
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: height(context) * 0.03),
                            child: ElevatedButtonWidget(
                              onClick: () {
                                if (page == 1) {
                                 
                                } else {
                                  pageController.animateToPage(page + 1,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              minWidth: width(context) * 0.9,
                              height: height(context) * 0.08,
                              borderRadius: 16,
                              bgColor: Colors.green[900],
                              textColor: Colors.white,
                              buttonName:
                                  (page == 1 ? "Submit" : "Next").toUpperCase(),
                              innerPadding: 0.02,
                              textSize: width(context) * 0.055,
                              textStyle: FontWeight.bold,
                              trailingIcon: Icon(
                                page == 0
                                    ? Icons.arrow_forward
                                    : Icons.check_rounded,
                                color: Colors.white,
                                size: width(context) * 0.045,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        });
  }
}
