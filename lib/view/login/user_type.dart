import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/data_provider.dart';
import 'package:nandikrushifarmer/provider/registration_provider.dart';
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
  late DataProvider dataProvider;

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
      isPrimary: false,
      bottomWidget:
          Consumer<RegistrationProvider>(builder: (context, value, child) {
        var userTypeData = value.userTypes;
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
                    color: Colors.green[900],
                    align: TextAlign.start,
                    lSpace: 2.5,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(context, userTypeData[0]);
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    bgColor: type == userTypeData[0]
                        ? Colors.green[900]
                        : Colors.white,
                    borderSideColor: Colors.green[900],
                    textColor: type == userTypeData[0]
                        ? Colors.white
                        : Colors.green[900],
                    buttonName: userTypeData[0],
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
                      value.updateUserType(context, userTypeData[1]);
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    allRadius: true,
                    bgColor: type == userTypeData[1]
                        ? Colors.green[900]
                        : Colors.white,
                    borderSideColor: Colors.green[900],
                    textColor: type == userTypeData[1]
                        ? Colors.white
                        : Colors.green[900],
                    buttonName: userTypeData[1],
                    center: true,
                    borderRadius: 15,
                    textSize: width(context) * 0.03,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(context, userTypeData[2]);
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    allRadius: true,
                    bgColor: type == userTypeData[2]
                        ? Colors.green[900]
                        : Colors.white,
                    borderSideColor: Colors.green[900],
                    textColor: type == userTypeData[2]
                        ? Colors.white
                        : Colors.green[900],
                    buttonName: userTypeData[2],
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
                bgColor: Colors.green[900],
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
