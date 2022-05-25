import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nandikrushi/provider/registration_provider.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/login_bg.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  var userTypeData = [];
  RegistrationProvider? registrationProvider;
  @override
  void initState() {
    getUserRegistrationData();
    registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    super.initState();
  }

  getUserRegistrationData() async {
    var url =
        'http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/customergroups';
    var jsonUri = Uri.tryParse(url);
    if (jsonUri == null) {
      return;
    }
    final response = await http.get(jsonUri);
    if (response.statusCode == 200) {
      List<dynamic> values = json.decode(response.body)["message"];
      userTypeData = values.map((e) => e["name"]).toList();
      print(values.map((e) => e["name"]));
    }
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
                    color: Colors.green[900],
                    align: TextAlign.start,
                    lSpace: 2.5,
                  ),
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(userTypeData[0]);
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
                      value.updateUserType(userTypeData[1]);
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
                      value.updateUserType(userTypeData[2]);
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
                  SizedBox(
                    height: height(context) * 0.035,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      value.updateUserType(userTypeData[3]);
                    },
                    minWidth: width(context) * 0.55,
                    height: height(context) * 0.035,
                    allRadius: true,
                    bgColor: type == userTypeData[3]
                        ? Colors.green[900]
                        : Colors.white,
                    borderSideColor: Colors.green[900],
                    textColor: type == userTypeData[3]
                        ? Colors.white
                        : Colors.green[900],
                    buttonName: userTypeData[3],
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
