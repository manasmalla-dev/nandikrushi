import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/utils/server.dart';

class ProfileProvider extends ChangeNotifier {
  bool shouldShowLoader = false;

  //DataStates
  String sellerID = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String telephone = "";
  int languageID = 1;
  String customerGroupId = "";
  String sellerType = "";
  int landInAcres = 1;
  String sellerImage = "";
  String additionalComments = "";
  String certificationType = "";
  List<String> certificates = [];
  String storeName = "";
  String storeLogo = "";
  Map<String, String> storeAddress = {};
  List<Map<String, String>> userAddresses = [];

  bool isDataFetched = false;

  showLoader() {
    shouldShowLoader = true;
    notifyListeners();
  }

  hideLoader() {
    shouldShowLoader = false;
    notifyListeners();
  }

  Future<void> getProfile({required String userID}) async {
    var url =
        "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getparticularuser";
    var response =
        await Server().postFormData(body: {"user_id": userID}, url: url);
    log(response?.body ?? "No response");
    log(response?.statusCode.toString() ?? "No response");
    //TODO: Check if status is true and we recieved the data and then put isDataFethched true
    isDataFetched = true;
    hideLoader();
  }
}
