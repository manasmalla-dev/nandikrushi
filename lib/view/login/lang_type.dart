import 'package:flutter/material.dart';
import 'package:nandikrushi/provider/registration_provider.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/login_bg.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:provider/provider.dart';

class LangType extends StatefulWidget {
  const LangType({Key? key}) : super(key: key);

  @override
  State<LangType> createState() => _LangTypeState();
}

class _LangTypeState extends State<LangType> {
  RegistrationProvider? registrationProvider;
  @override
  void initState() {
    registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBG(
      bottomWidget:
          Consumer<RegistrationProvider>(builder: (context, value, child) {
        dynamic type = value.langType;
        return Container(
          padding: EdgeInsets.only(
              top: width(context) * 0.04, bottom: width(context) * 0.06),
          height: height(context) * 0.5,
          width: width(context),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, (height(context) * -0.01)),
                  blurRadius: 6,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextWidget(
                    text: "Select Language".toUpperCase(),
                    size: width(context) * 0.04,
                    weight: FontWeight.w800,
                    color: Theme.of(context).primaryColor,
                    align: TextAlign.start,
                    lSpace: 2.5,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.languegeType('english');
                    },
                    minWidth: width(context) * 0.8,
                    height: height(context) * 0.045,
                    bgColor: type == 'english'
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderSideColor: Theme.of(context).primaryColor,
                    textColor: type == 'english'
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    buttonName: "ENGLISH",
                    center: true,
                    allRadius: true,
                    borderRadius: 12,
                    textSize: width(context) * 0.04,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.languegeType('telugu');
                    },
                    minWidth: width(context) * 0.8,
                    height: height(context) * 0.045,
                    allRadius: true,
                    bgColor: type == 'telugu'
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderSideColor: Theme.of(context).primaryColor,
                    textColor: type == 'telugu'
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    buttonName: "తెలుగు",
                    center: true,
                    borderRadius: 12,
                    textSize: width(context) * 0.04,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.languegeType('hindi');
                    },
                    minWidth: width(context) * 0.8,
                    height: height(context) * 0.045,
                    allRadius: true,
                    bgColor: type == 'hindi'
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderSideColor: Theme.of(context).primaryColor,
                    textColor: type == 'hindi'
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    buttonName: "हिन्दी",
                    center: true,
                    borderRadius: 12,
                    textSize: width(context) * 0.04,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.languegeType('kannada');
                    },
                    minWidth: width(context) * 0.8,
                    height: height(context) * 0.045,
                    allRadius: true,
                    bgColor: type == 'kannada'
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderSideColor: Theme.of(context).primaryColor,
                    textColor: type == 'kannada'
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    buttonName: "ಕನ್ನಡ",
                    center: true,
                    borderRadius: 12,
                    textSize: width(context) * 0.04,
                  ),
                ],
              ),
              ElevatedButtonWidget(
                onClick: () {
                  value.lanType(context);
                },
                allRadius: true,
                borderRadius: height(context) * 0.015,
                minWidth: width(context) * 0.8,
                height: height(context) * 0.06,
                bgColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                buttonName: "NEXT",
                textSize: width(context) * 0.04,
                trailingIcon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: width(context) * 0.045,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
