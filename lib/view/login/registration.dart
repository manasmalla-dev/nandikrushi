import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushi/controller/registration_controller.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/nandi_krushi_title.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi/view/basket/add_address.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends StateMVC<RegistrationScreen> {
  late RegistrationController homeController;

  _RegistrationScreenState() : super(RegistrationController()) {
    homeController = controller as RegistrationController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height(context) * 0.04,
            ),
            const Image(
              image: AssetImage("assets/png/registration_apple.png"),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width(context) * 0.075,
              ),
              child: Row(
                children: [
                  TextWidget(
                    text: "Welcome to",
                    size: height(context) * 0.03,
                    weight: FontWeight.w500,
                  ),
                  const NandiKrushiTitle(),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.075,
                        vertical: width(context) * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "One last step to go...",
                          color: Colors.grey.shade800,
                          weight: FontWeight.w600,
                          size: height(context) * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                controller: homeController
                                    .formControllers['first_name'],
                                label: 'First Name',
                                hintSize: 20,
                                hintColor: Colors.grey.shade600,
                                style:
                                    fonts(20.0, FontWeight.w500, Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: width(context) * 0.05,
                            ),
                            Expanded(
                              child: TextFieldWidget(
                                controller:
                                    homeController.formControllers['last_name'],
                                label: 'Last Name',
                                hintSize: 20,
                                hintColor: Colors.grey.shade600,
                                style:
                                    fonts(15.0, FontWeight.w500, Colors.black),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        TextFieldWidget(
                          controller: homeController.formControllers['email'],
                          label: 'Email Address',
                          hintSize: 20,
                          style: fonts(20.0, FontWeight.w500, Colors.black),
                        ),
                        TextFieldWidget(
                          controller:
                              homeController.formControllers['password'],
                          label: 'Create Password',
                          obscureText: true,
                          hintSize: 20,
                          style: fonts(20.0, FontWeight.w400, Colors.black),
                        ),
                        TextFieldWidget(
                          controller:
                              homeController.formControllers['c_password'],
                          label: 'Confirm Password',
                          hintSize: 20,
                          obscureText: true,
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
                                controller:
                                    homeController.formControllers['location'],
                                prefix: const Icon(Icons.location_on_rounded),
                                suffix: TextWidget(
                                  text: "Apply",
                                  weight: FontWeight.bold,
                                  color: Colors.red,
                                  size: height(context) * 0.02,
                                ),
                                style:
                                    fonts(20.0, FontWeight.w500, Colors.black),
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
                          height: height(context) * 0.015,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: height(context) * 0.03),
                    child: ElevatedButtonWidget(
                      onClick: () {
                        homeController.registerUser(context);
                      },
                      minWidth: width(context) * 0.85,
                      height: height(context) * 0.06,
                      borderRadius: 0,
                      allRadius: true,
                      bgColor: Colors.green[900],
                      textColor: Colors.white,
                      buttonName: "Proceed".toUpperCase(),
                      innerPadding: 0.02,
                      textSize: width(context) * 0.045,
                      // textStyle: FontWeight.bold,
                      trailingIcon: Icon(
                        Icons.arrow_forward,
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
    );
  }
}
