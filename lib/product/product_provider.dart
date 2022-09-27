import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

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
      {required BuildContext context,
      required String productID,
      required Function() onSuccessful,
      required Function(String) showMessage,
      required ProfileProvider profileProvider}) async {
    var cartElementExists =
        cart.where((element) => element["product_id"] == productID).isNotEmpty;
    profileProvider.showLoader();
    if (cartElementExists) {
      modifyProductToCart(
          context: context,
          productID: productID,
          onSuccessful: onSuccessful,
          showMessage: showMessage,
          profileProvider: profileProvider);
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

  Future<void> modifyProductToCart(
      {required BuildContext context,
      required String productID,
      required Function() onSuccessful,
      required Function(String) showMessage,
      required ProfileProvider profileProvider}) async {
    profileProvider.showLoader();
    var productDetails =
        products.where((e) => e["product_id"] == productID).first;
    var initialCartIems = int.tryParse(cart
                .where((e) => e["product_id"] == productDetails["product_id"])
                .first["quantity"] ??
            "0") ??
        0;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setSheetState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productDetails["name"] ?? "Product Name",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          productDetails["category_id"] ?? "Category",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        productDetails["description"] != null
                            ? SizedBox(
                                width: double.infinity,
                                child: TextWidget(
                                  productDetails["description"],
                                  flow: TextOverflow.ellipsis,
                                ),
                              )
                            : const SizedBox(),
                        TextWidget(
                            "Rs. ${double.tryParse(productDetails["price"] ?? "")?.toStringAsFixed(2) ?? ""}"),
                        TextWidget(productDetails["units"] ?? "1 unit"),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded),
                            Expanded(
                              child: TextWidget(
                                productDetails["place"] ?? "Visakhapatnam",
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.all(4), // and this
                                  side: const BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              onPressed: () {
                                setSheetState(() {
                                  initialCartIems--;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 2),
                                child: Icon(
                                  Icons.remove_rounded,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Text(
                              initialCartIems.toString(),
                              style: Theme.of(context).textTheme.button,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.all(4), // and this
                                  side: const BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              onPressed: () {
                                setSheetState(() {
                                  initialCartIems++;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 2),
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButtonWidget(
                          onClick: () async {
                            String apiURL = initialCartIems == 0
                                ? "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/remove"
                                : "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/cart/update";
                            var updateCartBody = {
                              "customer_id": profileProvider.sellerID,
                              "product_id": productID,
                            };
                            if (initialCartIems != 0) {
                              updateCartBody.addAll({
                                "quantity": initialCartIems.toString(),
                              });
                            }
                            var cartData = await Server().postFormData(
                                url: apiURL, body: updateCartBody);
                            if (cartData == null) {
                              showMessage(
                                  "Failed to get a response from the server!");
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
                                getData(
                                    showMessage: showMessage,
                                    profileProvider: profileProvider);
                              }
                              profileProvider.isDataFetched = true;
                            } else if (cartData.statusCode == 400) {
                              showMessage(
                                  "Undefined parameter when calling API");
                            } else if (cartData.statusCode == 404) {
                              showMessage("API not found");
                            } else {
                              showMessage("Failed to get data!");
                            }
                            profileProvider.hideLoader();
                          },
                          height: 54,
                          borderRadius: 8,
                          bgColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          buttonName: "Update".toUpperCase(),
                          innerPadding: 0.02,
                          // textStyle: FontWeight.bold,
                          trailingIcon: Icons.auto_fix_high_rounded,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      productDetails["url"] ?? "",
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<void> removeProductFromCart(
      {required BuildContext context,
      required String productID,
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
      modifyProductToCart(
          context: context,
          productID: productID,
          onSuccessful: onSuccessful,
          showMessage: showMessage,
          profileProvider: profileProvider);
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
