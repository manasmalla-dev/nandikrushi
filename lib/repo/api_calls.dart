import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/repo/api_methods.dart';
import 'package:nandikrushifarmer/repo/api_urls.dart';
import 'package:nandikrushifarmer/utilities/shared_preference.dart';

getUserDetailsFromDB() async {
  // String uId = FirebaseAuth.instance.currentUser!.uid;
  String uId = "";
  dynamic response = await Server().getMethod(API.userDetails + uId);
  if (response.statusCode == 200) {
    dynamic user = jsonDecode(response.body);
    return user;
  }
  return null;
}

getProductDetailsFromDB() async {
  dynamic response = await Server().getMethod(API.allProducts);
  if (response.statusCode == 200) {
    dynamic product = jsonDecode(response.body);
    return product;
  }
  return null;
}

constantsAPI() async {
  dynamic response = await Server().getMethod(API.appSettings);
  if (response.statusCode == 200) {
    dynamic appConstants = jsonDecode(response?.body);
    log(appConstants.toString());
    setAppConstants(appConstants);
    // var currentUser = FirebaseAuth.instance.currentUser;
    var currentUser = "";
    if (currentUser.isNotEmpty) {
      log("confirming all costanst downloaded");
      /* -------------- CONFIRM ALL CONSTANTS AND SETTINGS DOWNLOADED ------------- */
      Map<String, String> body = {"appConfig": "false"};
      Server().editMethod(API.userDetails + currentUser.toString(), body);
    }
    return appConstants;
  } else {
    log("something went wrong");
    return null;
  }
}

signout(BuildContext context) async {
  // await FirebaseAuth.instance.signOut().then((action) {
  //   Navigator.pushAndRemoveUntil(context,
  //       MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
  // }).catchError((e) {
  //   log(e);
  // });
}
