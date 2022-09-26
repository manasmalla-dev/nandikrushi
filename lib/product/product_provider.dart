import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';

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
  List<Map<String, String>> orders = [];
  Map<String, List<Map<String, String>>> categorizedProducts = {};

  getData(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider}) async {
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
      for (var e in decodedResponse) {
        if (categories.entries
            .where((element) =>
                element.value ==
                int.tryParse(e["category"][0]["category_id"] ?? "-1"))
            .isNotEmpty) {
          var element = {
            'name': e["Products"][0]["product_name"].toString(),
            'description': e["Products"][0]["description"].toString(),
            'price': (((double.tryParse(e["Products"][0]["final_price"]
                                    .toString()) ??
                                0.0) *
                            100)
                        .roundToDouble() /
                    100)
                .toString(),
            "category_id": categories.entries
                .where((element) =>
                    element.value ==
                    int.tryParse(e["category"][0]["category_id"] ?? "-1"))
                .first
                .key,
            'product_id': e["Products"][0]["product_id"].toString(),
            'units':
                '${e["Products"][0]["min_purchase"]} ${e["Products"][0]["units"]}'
                    .toString(),
            'place': 'Paravada, Visakhapatnam.',
            'url': e["Products"][0]["image"].toString()
          };
          products.add(element);
        }
      }

      for (var element in categories.keys) {
        categorizedProducts[element] = [];
        for (var product in products) {
          if (product["category_id"] == element) {
            categorizedProducts[element]?.add(product);
          }
        }
      }
      var ordersData = await Server().postFormData(
          url:
              "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getorders",
          body: {"customer_id": profileProvider.sellerID.toString()});
      if (ordersData == null) {
        showMessage("Failed to get a response from the server!");
        //hideLoader();
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return;
      }
      if (ordersData.statusCode == 200) {
        if (!ordersData.body.contains('"status":false')) {
          var orderJSONResponse = jsonDecode(ordersData.body);
          log(orderJSONResponse.toString());
          //TODO: Work with this data to add to orders list
        }
        var cartData = await Server().postFormData(
            url:
                "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/products",
            body: {
              "customer_id": profileProvider.sellerID.toString(),
            });
        if (cartData == null) {
          showMessage("Failed to get a response from the server!");
          //hideLoader();
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
          return;
        }
        if (cartData.statusCode == 200) {
          if (!cartData.body.contains('"status":false')) {
            List<dynamic> cartJSONResponse =
                jsonDecode(cartData.body)["products"];
            cart = cartJSONResponse.map((cartItem) {
              var productCartItem = products
                  .where((element) =>
                      element["product_id"] ==
                      (cartItem["product_id"].toString()))
                  .first;
              return {
                "cart_id": cartItem["cart_id"].toString(),
                "name": cartItem["name"].toString(),
                'unit': productCartItem["units"].toString(),
                "product_id": cartItem["product_id"].toString(),
                "quantity": cartItem['quantity'].toString(),
                'price': cartItem['price']
                    .toString()
                    .replaceFirst("\$", "")
                    .toString(),
                'place': productCartItem["place"].toString(),
                'url': productCartItem["url"].toString()
              };
            }).toList();
            log("CART: " + cart.toString());
          }
          //TODO: Add the my products API, purchases API, units API, subcategories API.
          profileProvider.isDataFetched = true;
          profileProvider.hideLoader();
        } else if (cartData.statusCode == 400) {
          showMessage("Undefined parameter when calling API");
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        } else if (cartData.statusCode == 404) {
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
      } else if (ordersData.statusCode == 400) {
        showMessage("Undefined parameter when calling API");
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      } else if (ordersData.statusCode == 404) {
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

  Future<void> addProductToCart(
      {required String productID,
      required Function() onSuccessful,
      required Function(String) showMessage,
      required ProfileProvider profileProvider}) async {
    var cartElementExists =
        cart.where((element) => element["product_id"] == productID).isNotEmpty;
    profileProvider.showLoader();
    if (cartElementExists) {
      //TODO: Show BS

      // String apiURL =
      //     "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/update";
      // var cartData = await Server().postFormData(url: apiURL, body: {
      //   "customer_id": profileProvider.sellerID,
      //   "product_id": productID,
      //   "quantity": ((int.tryParse(cart
      //                       .where(
      //                           (element) => element["product_id"] == productID)
      //                       .first["quantity"] ??
      //                   "") ??
      //               0) +
      //           1)
      //       .toString()
      // });
      // if (cartData == null) {
      //   showMessage("Failed to get a response from the server!");
      //   //hideLoader();
      //   if (Platform.isAndroid) {
      //     SystemNavigator.pop();
      //   } else if (Platform.isIOS) {
      //     exit(0);
      //   }
      //   return;
      // }
      // if (cartData.statusCode == 200) {
      //   if (!cartData.body.contains('"status":false')) {
      //     getData(showMessage: showMessage, profileProvider: profileProvider);
      //   }
      //   profileProvider.isDataFetched = true;
      // } else if (cartData.statusCode == 400) {
      //   showMessage("Undefined parameter when calling API");
      // } else if (cartData.statusCode == 404) {
      //   showMessage("API not found");
      // } else {
      //   showMessage("Failed to get data!");
      // }
      profileProvider.hideLoader();
    } else {
      String apiURL =
          "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/add";
      var cartData = await Server().postFormData(url: apiURL, body: {
        "customer_id": profileProvider.sellerID,
        "product_id": productID,
        "quantity": 1.toString(),
      });
      if (cartData == null) {
        showMessage("Failed to get a response from the server!");
        profileProvider.hideLoader();
        return;
      }
      if (cartData.statusCode == 200) {
        if (!cartData.body.contains('"status":false')) {
          getData(showMessage: showMessage, profileProvider: profileProvider);
        }
        profileProvider.isDataFetched = true;
      } else if (cartData.statusCode == 400) {
        showMessage("Undefined parameter when calling API");
      } else if (cartData.statusCode == 404) {
        showMessage("API not found");
      } else {
        showMessage("Failed to get data!");
      }
      profileProvider.hideLoader();
    }
  }

  Future<void> removeProductFromCart(
      {required String productID,
      required Function() onSuccessful,
      required Function(String) showMessage,
      required ProfileProvider profileProvider}) async {
    var cartElementExists = (int.tryParse(cart
                    .where((element) => element["product_id"] == productID)
                    .first["quantity"] ??
                "") ??
            0) >
        1;
    profileProvider.showLoader();
    if (cartElementExists) {
      //TODO: Show BS

      // String apiURL =
      //     "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/update";
      // var body = {
      //   "customer_id": profileProvider.sellerID,
      //   "product_id": productID,
      //   "quantity": ((int.tryParse(cart
      //                       .where(
      //                           (element) => element["product_id"] == productID)
      //                       .first["quantity"] ??
      //                   "") ??
      //               0) -
      //           1)
      //       .toString()
      // };

      // var cartData = await Server().postFormData(url: apiURL, body: body);
      // if (cartData == null) {
      //   showMessage("Failed to get a response from the server!");
      //   profileProvider.hideLoader();
      //   return;
      // }
      // if (cartData.statusCode == 200) {
      //   if (!cartData.body.contains('"status":false')) {
      //     getData(showMessage: showMessage, profileProvider: profileProvider);
      //   }
      //   profileProvider.isDataFetched = true;
      //   profileProvider.hideLoader();
      // } else if (cartData.statusCode == 400) {
      //   showMessage("Undefined parameter when calling API");
      // } else if (cartData.statusCode == 404) {
      //   showMessage("API not found");
      // } else {
      //   showMessage("Failed to get data!");
      // }
      profileProvider.hideLoader();
    } else {
      String apiURL =
          "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/remove";
      var body = {
        "customer_id": profileProvider.sellerID,
        "product_id": productID,
      };

      var cartData = await Server().postFormData(url: apiURL, body: body);
      if (cartData == null) {
        showMessage("Failed to get a response from the server!");
        profileProvider.hideLoader();
        return;
      }
      if (cartData.statusCode == 200) {
        if (!cartData.body.contains('"status":false')) {
          getData(showMessage: showMessage, profileProvider: profileProvider);
        }
        profileProvider.isDataFetched = true;
      } else if (cartData.statusCode == 400) {
        showMessage("Undefined parameter when calling API");
      } else if (cartData.statusCode == 404) {
        showMessage("API not found");
      } else {
        showMessage("Failed to get data!");
      }
      profileProvider.hideLoader();
    }
  }
}
