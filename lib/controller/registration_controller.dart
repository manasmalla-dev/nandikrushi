import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushi/model/user.dart';
import 'package:nandikrushi/repo/api_methods.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/view/login/nav_bar.dart';

class RegistrationController extends ControllerMVC {
  var user = User();

  var formControllers = {
    'first_name': TextEditingController(),
    'last_name': TextEditingController(),
    'email': TextEditingController(),
    'location': TextEditingController(),
    'password': TextEditingController(),
    'c_password': TextEditingController(),
  };

  registerUser(context) async {
    var firstName = formControllers['first_name']?.text ?? "";
    var lastName = formControllers['last_name']?.text ?? "";
    var email = formControllers['email']?.text ?? "";
    var location = formControllers['location']?.text ?? "";
    var password = formControllers["password"]?.text ?? "";
    var cPassword = formControllers["c_password"]?.text ?? "";
    if (cPassword != password) {
      return snackbar(context, "Passwords not the same!");
    }
    user = User.registerUser(
        firstName: firstName,
        lastName: lastName,
        location: location,
        email: email,
        password: password);
    registerButton();

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NavBar()));
  }

  registerButton() async {
    var body = {
      "firstname": user.firstName.toString(),
      "lastname": user.lastName.toString(),
      "email": user.email.toString(),
      "telephone": user.phoneNumber.toString(),
      "password": user.password.toString(),
      "confirm": user.password.toString(),
      "agree": 1.toString(),
      "become_seller": 1.toString(),
      "seller_storename": user.firstName.toString(),
    };
    log(body.toString());

    var resp =
        await Server().postMethodParems(jsonEncode(body)).catchError((e) {
      log("64" + e.toString());
    });
    log(resp.body.toString());
  }
}
