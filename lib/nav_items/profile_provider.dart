import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
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

  Future<void> getProfile(
      {required String userID, required Function(String) showMessage}) async {
    var url =
        "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getparticularuser";
    var response =
        await Server().postFormData(body: {"user_id": userID}, url: url);
    if (response == null) {
      showMessage("Failed to get a response from the server!");
      return;
    }

    //TODO: Check if status is true and we recieved the data and then put isDataFethched true
    if (response.statusCode == 200) {
      Map<String, dynamic> profileJSON = jsonDecode(response.body)["message"];
      log(profileJSON.toString());
      sellerID = profileJSON["seller_id"];
      firstName = profileJSON["firstname"];
      lastName = profileJSON["lastname"];
      email = profileJSON["email"];
      telephone =
          "+91 ${profileJSON["telephone"].toString().substring(0, 5)} ${profileJSON["telephone"].toString().substring(5, 10)}";
      languageID = int.tryParse(profileJSON["language_id"]) ?? 1;
      customerGroupId = profileJSON["customer_group_id"];
      sellerType = profileJSON["seller_type"];
      landInAcres = int.tryParse(profileJSON["land"]) ?? 1;
      sellerImage = profileJSON["seller_image"];
      additionalComments = profileJSON["additional_comments"];
      certificationType = profileJSON["addtional_documents"];
      certificates = (json.decode(profileJSON["document"]) as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      storeName = profileJSON["store_name"];
      storeLogo = profileJSON["store_logo"];
      // storeAddress = (json.decode(profileJSON["store_address"]
      //         .toString()
      //         .replaceAll("&quot;", "")) as Map<dynamic, dynamic>)
      //     .map((key, value) => MapEntry(key.toString(), value.toString()));
      isDataFetched = true;
      notifyListeners();
    } else if (response.statusCode == 400) {
      showMessage("Undefined parameter when calling API");
    } else if (response.statusCode == 404) {
      showMessage("API not found");
    } else {
      showMessage("Failed to get data!");
    }
    hideLoader();
  }
}
