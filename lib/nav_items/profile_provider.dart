import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
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
      log(response.body.toString());
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
      certificates = profileJSON["document"].runtimeType == String
          ? [profileJSON["document"]].map((e) => e.toString()).toList()
          : profileJSON["document"].map((e) => e.toString()).toList();
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
        if (jsonDecode(userAddressResponse.body)["status"]) {
          List<dynamic> userAddressJSON =
              await jsonDecode(userAddressResponse.body)["message"];
          //log(userAddressJSON.toString());
          Map<String, String> body = {};
          userAddresses = [];
          for (var map in userAddressJSON) {
            body = {};
            map.forEach((key, value) {
              body.addAll({key: value.toString()});
            });
            userAddresses.add(body);
          }
          log(userAddresses.toString());
          notifyListeners();
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

  Future<void> createAddress(
      NavigatorState navigatorState,
      Map<String, String> addressList,
      Position? location,
      Function(String) showMessage) async {
    //Send this data to the server
    var response = await post(
      Uri.parse(
          "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/address/add"),
      body: jsonEncode({
        "customer_id": sellerID,
        "address_title": addressList["address_type"] ?? "",
        "firstname": firstName,
        "lastname": lastName,
        "company": "Nandikrushi",
        "flat_no": addressList["house_number"] ?? "",
        "landmark": addressList["landmark"] ?? "",
        "address_1":
            "${(addressList["full_address"] ?? "").split(",")[0]},${(addressList["full_address"] ?? "").split(",")[1]}",
        "address_2": (addressList["full_address"] ?? "").replaceFirst(
            "${(addressList["full_address"] ?? "").split(",")[0]},${(addressList["full_address"] ?? "").split(",")[1]},",
            ""),
        "city": addressList["city"] ?? "",
        "state": addressList["state"] ?? "",
        "country": addressList["country"] ?? "",
        "default": 1.toString(),
        "postcode": addressList["pincode"] ?? "",
        "alternative_number": addressList["alternate_mobile_number"] ?? "",
        "coordinates": [
          {"longitude": location?.longitude, "latitude": location?.latitude}
        ]
      }),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    if (response == null) {
      showMessage("Failed to get a response from the server!");
      hideLoader();
      return;
    }

    if (response.statusCode == 200) {
      log(response.body);
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
