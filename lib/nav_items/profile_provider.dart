import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String userIdForAddress = "";

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
    userIdForAddress = userID;
    var url =
        "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getparticularuser";
    var response =
        await Server().postFormData(body: {"user_id": userID}, url: url);
    //TODO: Videos API needs to be integrated

    if (response == null) {
      showMessage("Failed to get a response from the server!");
      hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return;
    }

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
      customerGroupId = profileJSON["customer_group_id"] ?? "Farmer";
      sellerType = profileJSON["seller_type"];
      landInAcres = (double.tryParse(profileJSON["land"]) ?? 1.0).ceil();
      sellerImage = profileJSON["seller_image"];
      additionalComments = profileJSON["additional_comments"];
      certificationType = profileJSON["addtional_documents"];
      certificates = (json.decode(profileJSON["document"]) as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      storeName = profileJSON["store_name"];
      storeLogo = profileJSON["store_logo"];
      storeAddress = jsonStringToMap(profileJSON["store_address"]);
      var userAddressResponse = await Server().postFormData(body: {
        "customer_id": sellerID.toString()
      }, url: "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/address/getallAddress");
      if (userAddressResponse == null) {
        showMessage("Failed to get a response from the server!");
        hideLoader();
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return;
      }
      if (userAddressResponse.statusCode == 200) {
        log(userAddressResponse.body);
        if (jsonDecode(userAddressResponse.body)["status"]) {
          var userAddressJSON =
              jsonDecode(userAddressResponse.body)["message"].values.first;
          //log(userAddressJSON.toString());
          Map<String, String> body = {};
          userAddresses = [];
          userAddressJSON.forEach((key, value) {
            body.addAll({key: value.toString()});
          });
          userAddresses.add(body);
          log(userAddresses.toString());
        }
      } else if (response.statusCode == 400) {
        showMessage("Undefined parameter when calling API");
        hideLoader();
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      } else if (response.statusCode == 404) {
        showMessage("API not found");
        hideLoader();
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      } else {
        log("Error: ${response.statusCode}");
        showMessage("Failed to get data!");
        hideLoader();
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      }
      notifyListeners();
    } else if (response.statusCode == 400) {
      showMessage("Undefined parameter when calling API");
      hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } else if (response.statusCode == 404) {
      showMessage("API not found");
      hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } else {
      showMessage("Failed to get data!");
      hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }
  }

  Map<String, String> jsonStringToMap(String data) {
    List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result
        .map((key, value) => MapEntry(key.toString(), value.toString()));
  }

  Future<void> createAddress(NavigatorState navigatorState,
      Map<String, String> addressList, Function(String) showMessage) async {
    //Send this data to the server
    var response = await Server().postFormData(
        url:
            "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/address/add",
        body: {
          "customer_id": sellerID,
          "firstname": firstName,
          "lastname": lastName,
          "company": addressList["address_type"] ?? "",
          "address_1": addressList["landmark"] ?? "",
          "address_2": addressList["full_address"] ?? "",
          "city": addressList["city"] ?? "",
          "country": addressList["state"] ?? "",
          "state": addressList["country"] ?? "",
          "default": 1.toString(),
          "postcode": addressList["pincode"] ?? "",
        });
    if (response == null) {
      showMessage("Failed to get a response from the server!");
      hideLoader();
      return;
    }

    if (response.statusCode == 200) {
      getProfile(userID: userIdForAddress, showMessage: showMessage);
      hideLoader();
      notifyListeners();
    } else if (response.statusCode == 400) {
      showMessage("Undefined parameter when calling API");
      hideLoader();
    } else if (response.statusCode == 404) {
      showMessage("API not found");
      hideLoader();
    } else {
      showMessage("Failed to get data!");
      hideLoader();
    }

    navigatorState.pop();
  }
}
