import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushi/model/user.dart';
import 'package:nandikrushi/reusable_widgets/app_bar.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi/view/basket/add_address.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user = User();
  var formControllers = {
    'first_name': TextEditingController(),
    'last_name': TextEditingController(),
    'email': TextEditingController(),
    'location': TextEditingController(),
    'password': TextEditingController(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithTitle(context, title: 'Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: height(context) * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: formControllers['first_name'],
                        label: 'First Name',
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
                        controller: formControllers['last_name'],
                        label: 'Last Name',
                        hintSize: 20,
                        hintColor: Colors.grey.shade600,
                        style: fonts(15.0, FontWeight.w500, Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                TextFieldWidget(
                  controller: formControllers['email'],
                  label: 'Email Address',
                  hintSize: 20,
                  style: fonts(20.0, FontWeight.w500, Colors.black),
                ),
                TextFieldWidget(
                  controller: formControllers['password'],
                  label: 'Password',
                  obscureText: true,
                  hintSize: 20,
                  style: fonts(20.0, FontWeight.w400, Colors.black),
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),
                TextWidget(
                  text: "Payment invoices are emailed to this address",
                  color: Colors.grey.shade600,
                  weight: FontWeight.w500,
                  size: height(context) * 0.015,
                ),
                SizedBox(
                  height: height(context) * 0.03,
                ),
                TextWidget(
                  text: "Enter your loction",
                  weight: FontWeight.bold,
                  size: height(context) * 0.02,
                ),
                TextWidget(
                  text: "Select location to see product availability.",
                  color: Colors.grey.shade600,
                  weight: FontWeight.w500,
                  size: height(context) * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: formControllers['location'],
                        prefix: const Icon(Icons.location_on_rounded),
                        suffix: TextWidget(
                          text: "Apply",
                          weight: FontWeight.bold,
                          color: Colors.red,
                          size: height(context) * 0.02,
                        ),
                        style: fonts(20.0, FontWeight.w500, Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            AddAddressScreen(onSaveAddress: (_) {})));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.gps_fixed_rounded,
                        size: height(context) * 0.02,
                        color: Colors.blue.shade800,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      TextWidget(
                        text: "Detect my loction",
                        weight: FontWeight.bold,
                        color: Colors.blue.shade800,
                        size: height(context) * 0.02,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.24,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: height(context) * 0.03),
                  child: ElevatedButtonWidget(
                    onClick: () {
                      var firstName = formControllers['first_name']?.text ?? "";
                      var lastName = formControllers['last_name']?.text ?? "";
                      var email = formControllers['email']?.text ?? "";
                      var location = formControllers['location']?.text ?? "";
                      var password = formControllers['password']?.text ?? "";
                      user = User.registerUser(
                          firstName: firstName,
                          lastName: lastName,
                          location: location,
                          email: email,
                          password: password);

                      log(user.toString());
                      Navigator.of(context).pop();
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
          ),
        ));
  }
}
