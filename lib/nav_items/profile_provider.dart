import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/utils/server.dart';
import 'package:provider/provider.dart';

import '../onboarding/login_provider.dart';

class ProfileProvider extends ChangeNotifier {
  bool shouldShowLoader = false;

  //DataStates
  String customerID = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String telephone = "";
  int languageID = 1;

  List<Map<String, String>> userAddresses = [];
  String userIdForAddress = "";
  List<Map<String, String>> carousel = [];

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
      {required LoginProvider loginProvider,
      required String userID,
      required Function(String) showMessage}) async {
    userIdForAddress = userID;

    var url =
        "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/customerregister/getparticularcustomer";
    var response =
        await Server().postFormData(body: {"user_id": userID}, url: url);

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
      customerID = profileJSON["customer_id"];
      firstName = profileJSON["firstname"];
      lastName = profileJSON["lastname"];
      email = profileJSON["email"];
      telephone =
          "+91 ${profileJSON["telephone"].toString().substring(0, 5)} ${profileJSON["telephone"].toString().substring(5, 10)}";
      //languageID = int.tryParse(profileJSON["language_id"]) ?? 1;

      var userAddressResponse = await Server().postFormData(body: {
        "customer_id": customerID.toString()
      }, url: "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/address/getallAddress");
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
      carousel = await getCarouselData(showMessage);
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
      print(response.statusCode);
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
      Function(String) showMessage,
      LoginProvider loginProvider) async {
    //Send this data to the server
    var response = await post(
      Uri.parse(
          "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/address/add"),
      body: jsonEncode({
        "customer_id": customerID,
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

    if (response.statusCode == 200) {
      log(response.body);
      getProfile(
          userID: userIdForAddress,
          showMessage: showMessage,
          loginProvider: loginProvider);
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

  String city = "Visakhapatnam";
  void setCity(String locality) {
    city = locality;
    notifyListeners();
  }

  Future<List<Map<String, String>>> getCarouselData(
      Function(String) showError) async {
    var isTimedOut = false;
    var url =
        "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/carousel/getcarousel";

    var response = await Server()
        .getMethodParams(
      url,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      isTimedOut = true;
      return [
        {
          "title": "We\'re Fresh.",
          "description": "We believe in Truly food is a Medicine"
        },
        {
          "title": "We\'re Fresh.",
          "description": "We believe in Truly food is a Medicine"
        }
      ];
    });

    if (!isTimedOut) {
      if (response.statusCode == 200) {
        log("sucess");
        log(response.body);
        List<dynamic> values = jsonDecode(response.body)["message"];

        var iterables = values.map(
          (e) => {
            "title": e["title"].toString(),
            "description": e["description"].toString(),
            "image": e["url"].toString()
          },
        );
        return iterables.toList();
      } else if (response.statusCode == 400) {
        showError("Undefined Parameter when calling API");
        log("Undefined Parameter");
        return [
          {
            "title": "We\'re Fresh.",
            "description": "We believe in Truly food is a Medicine"
          },
          {
            "title": "We\'re Fresh.",
            "description": "We believe in Truly food is a Medicine"
          }
        ];
      } else if (response.statusCode == 404) {
        showError("API Not found");
        log("Not found");
        return [
          {
            "title": "We\'re Fresh.",
            "description": "We believe in Truly food is a Medicine"
          },
          {
            "title": "We\'re Fresh.",
            "description": "We believe in Truly food is a Medicine"
          }
        ];
      } else {
        showError("Failed to get data!");
        log("failure ${response.statusCode}");
        return [
          {
            "title": "We\'re Fresh.",
            "description": "We believe in Truly food is a Medicine"
          },
          {
            "title": "We\'re Fresh.",
            "description": "We believe in Truly food is a Medicine"
          }
        ];
      }
    } else {
      showError("Failed to get data!");
      log("failure");
      return [
        {
          "title": "We\'re Fresh.",
          "description": "We believe in Truly food is a Medicine"
        },
        {
          "title": "We\'re Fresh.",
          "description": "We believe in Truly food is a Medicine"
        }
      ];
    }
  }
}
