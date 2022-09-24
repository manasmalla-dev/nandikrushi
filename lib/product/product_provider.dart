import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/server.dart';

class ProductProvider extends ChangeNotifier {
  var selectedIndex = 0;

  Map<String, String> units = {
    "Kilogram": "kg",
    "Gram": "g",
    "Liter": "lt",
    "Milliliter": "ml",
    "Dozen": "dz"
  };
  changeScreen(int _) {
    selectedIndex = _;
    notifyListeners();
  }

  var categories = {
    "A2 Milk": 17,
    "Vegetables": 62,
    "Fruits": 33,
    "Ghee": 57,
    "Oil": 20,
    "Millets": 18,
  };

  List<Map<String, String>> cart = [];
  List<Map<String, String>> products = [];
  Map<String, List<Map<String, String>>> categorizedProducts = {};

  getData({required Function(String) showMessage}) async {
    var url =
        "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getallproducts";
    var response = await Server().getMethodParams(url);
    if (response == null) {
      showMessage("Failed to get a response from the server!");
      //hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return;
    }
    if (response.statusCode == 200) {
      //  log(response.body);
      List<dynamic> decodedResponse = jsonDecode(response.body)["Products"];
      // log("64${decodedResponse}");
      decodedResponse.forEach((e) {
        print(e.toString());
        var element = {
          'name': e["Products"][0]["product_name"].toString(),
          'description': e["Products"][0]["description"].toString(),
          'price':
              (((double.tryParse(e["Products"][0]["final_price"].toString()) ??
                                  0.0) *
                              100)
                          .roundToDouble() /
                      100)
                  .toString(),
          "category_id": categories.entries
              .where(
                  (element) => element.value == e["category"][0]["category_id"])
              .first
              .key,
          'product_id': e["Products"][0]["product_id"].toString(),
          'units':
              '${e["Products"][0]["min_purchase"]} ${e["Products"][0]["units"]}'
                  .toString(),
          'place': 'Paravada, Visakhapatnam.',
          'url': e["Products"][0]["image"].toString()
        };
        log(element.toString());
        products.add(element);
      });

      //TODO Prepare categorized list of items
      log(products.toString());
    } else if (response.statusCode == 400) {
      showMessage("Undefined parameter when calling API");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } else if (response.statusCode == 404) {
      showMessage("API not found");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } else {
      showMessage("Failed to get data!");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }
  }
}
