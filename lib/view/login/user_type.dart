import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/registration_provider.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/login_bg.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:provider/provider.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
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
        dynamic type = value.userAccountType;
        return Container(
          padding: EdgeInsets.only(
              top: width(context) * 0.04, bottom: width(context) * 0.06),
          height: height(context) * 0.5,
          width: width(context),
          decoration: const BoxDecoration(
              color: Color(0xffF2F5F4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                  topRight: Radius.circular(70.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextWidget(
                    text: "REGISTER AS",
                    size: width(context) * 0.04,
                    weight: FontWeight.w800,
                    color: SpotmiesTheme.primaryColor,
                    align: TextAlign.start,
                    lSpace: 2.5,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(context, 'farmer');
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    bgColor: type == 'farmer'
                        ? SpotmiesTheme.primaryColor
                        : Colors.white,
                    borderSideColor: SpotmiesTheme.primaryColor,
                    textColor: type == 'farmer'
                        ? Colors.white
                        : SpotmiesTheme.primaryColor,
                    buttonName: "FARMER",
                    center: true,
                    allRadius: true,
                    borderRadius: 15,
                    textSize: width(context) * 0.03,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(context, 'store');
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    allRadius: true,
                    bgColor: type == 'store'
                        ? SpotmiesTheme.primaryColor
                        : Colors.white,
                    borderSideColor: SpotmiesTheme.primaryColor,
                    textColor: type == 'store'
                        ? Colors.white
                        : SpotmiesTheme.primaryColor,
                    buttonName: "ORGANIC STORE",
                    center: true,
                    borderRadius: 15,
                    textSize: width(context) * 0.03,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(context, 'restaurant');
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    allRadius: true,
                    bgColor: type == 'restaurant'
                        ? SpotmiesTheme.primaryColor
                        : Colors.white,
                    borderSideColor: SpotmiesTheme.primaryColor,
                    textColor: type == 'restaurant'
                        ? Colors.white
                        : SpotmiesTheme.primaryColor,
                    buttonName: "ORGANIC RESTAURANT",
                    center: true,
                    borderRadius: 15,
                    textSize: width(context) * 0.03,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(context, 'ads');
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    allRadius: true,
                    bgColor: type == 'ads'
                        ? SpotmiesTheme.primaryColor
                        : Colors.white,
                    borderSideColor: SpotmiesTheme.primaryColor,
                    textColor: type == 'ads'
                        ? Colors.white
                        : SpotmiesTheme.primaryColor,
                    buttonName: "SPONSORED ADS",
                    center: true,
                    borderRadius: 15,
                    textSize: width(context) * 0.03,
                  ),
                ],
              ),
              ElevatedButtonWidget(
                onClick: () {
                  value.userType(context);
                },
                minWidth: width(context) * 0.8,
                height: height(context) * 0.06,
                bgColor: SpotmiesTheme.primaryColor,
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
