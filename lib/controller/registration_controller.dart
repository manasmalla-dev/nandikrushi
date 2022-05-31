// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushifarmer/model/user.dart';
import 'package:nandikrushifarmer/provider/registration_provider.dart';
import 'package:nandikrushifarmer/repo/api_methods.dart';
import 'package:nandikrushifarmer/repo/api_urls.dart';
import 'package:provider/provider.dart';

class RegistrationController extends ControllerMVC {
  PageController pageController = PageController(initialPage: 0);
  var acresInInt = 1.0;
  var checkBoxStates = [true, false, false, false, false, false];
  var user = User();
  String comingSms = '';
  XFile? image;
  Position? location;
  List<Placemark>? locationGeoCoded;
  var formControllers = {
    'first_name': TextEditingController(),
    'last_name': TextEditingController(),
    'house_number': TextEditingController(),
    'city': TextEditingController(),
    'mandal': TextEditingController(),
    'district': TextEditingController(),
    'state': TextEditingController(),
    'pincode': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'c_password': TextEditingController(),
    'telePhone': TextEditingController(),
    'storeName': TextEditingController(),
  };
  var checkBoxStatesText = [
    'Self Declared Natural Farmer',
    'PGS India Green',
    'PGS India Organic',
    'Organic FPO',
    'Organic FPC',
    'Other Certification +'
  ];

  registerButton(context) async {
    var body = {
      "firstname": user.firstName.toString(),
      "lastname": user.lastName.toString(),
      "email": user.email.toString(),
      "telephone": user.telePhone.toString(),
      "password": user.pass.toString(),
      "confirm": user.cpass.toString(),
      "agree": 1.toString(),
      "become_seller": 1.toString(),
      "seller_storename": user.firstName.toString(),
      "seller_type": "Farmers",
      "land": user.landAreaInAcres,
      "seller_image": user.farmerImage,
      "additional_comments": "Farmer is the backbone of India",
      "additional_documents": user.certificationType,
      "upload_document": user.certificates.toString(),
      "seller_storename": user.certificationRegisterationNumber,
      "store_logo": user.farmerImage,
      "store_address": user.city,
      // "agree": "1"
    };
    log(body.toString());

    var provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updateUser(user);
    var resp =
        await Server().postMethodParems(jsonEncode(body)).catchError((e) {
      log("64" + e.toString());
    });
    log(resp.body.toString());
  }

  Future<void> getImages(ImageSource imageSource) async {
    ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: imageSource);
    // Navigator.of(context).pop();
    setState(() {});
  }

  Future<void> checkLocationPermissionAndGetLocation() async {
    var permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.always ||
        permissionGranted == LocationPermission.whileInUse) {
      location = await Geolocator.getLastKnownPosition();
      var isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        location = await Geolocator.getCurrentPosition();
        geocodeLocation();
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      var locationPermission = await Geolocator.requestPermission();
      checkLocationPermissionAndGetLocation();
    }
  }

  Future<void> geocodeLocation() async {
    locationGeoCoded =
        await placemarkFromCoordinates(location!.latitude, location!.longitude);
    log(locationGeoCoded.toString());
    formControllers["pincode"]?.text = locationGeoCoded?.first.postalCode ?? "";
    formControllers["state"]?.text =
        locationGeoCoded?.first.administrativeArea ?? "";
    formControllers["district"]?.text =
        locationGeoCoded?.first.subAdministrativeArea ?? "";
    formControllers["city"]?.text = locationGeoCoded?.first.locality ?? "";
    formControllers["house_number"]?.text =
        locationGeoCoded?.first.street ?? "";
    formControllers["mandal"]?.text = locationGeoCoded?.first.subLocality ?? "";
  }

  fetchUserData(context) {
    var provider = Provider.of<RegistrationProvider>(context, listen: false);
    formControllers = {
      'first_name': TextEditingController(text: provider.user?.firstName ?? ""),
      'last_name': TextEditingController(text: provider.user?.lastName ?? ""),
      'house_number':
          TextEditingController(text: provider.user?.houseNumber ?? ""),
      'city': TextEditingController(text: provider.user?.city ?? ""),
      'mandal': TextEditingController(text: provider.user?.mandal ?? ""),
      'district': TextEditingController(text: provider.user?.district ?? ""),
      'state': TextEditingController(text: provider.user?.state ?? ""),
      'pincode': TextEditingController(text: provider.user?.pincode ?? ""),
      'email': TextEditingController(text: provider.user?.email ?? ""),
      'password': TextEditingController(text: provider.user?.pass ?? ""),
      'c_password': TextEditingController(text: provider.user?.cpass ?? ""),
      'telePhone': TextEditingController(text: provider.user?.telePhone ?? ""),
      'storeName': TextEditingController(
          text: provider.user?.certificationRegisterationNumber ?? ""),
    };
  }
}
