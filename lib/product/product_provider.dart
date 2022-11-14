import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';

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
    "Vegetables": 24,
    "Fruits": 33,
    "Ghee": 57,
    "Oil": 20,
    "Millets": 18,
  };
  var subcategories = {
    17: [
      {"A2 Milk": 17}
    ],
    24: [
      {"Vegetables": 24}
    ],
    33: [
      {"Fruits": 33}
    ],
    57: [
      {"Ghee": 57}
    ],
    20: [
      {"Oil": 20}
    ],
    18: [
      {"Millets": 18}
    ],
  };

  List<Map<String, String>> cart = [];
  List<Map<String, String>> products = [];
  List<Map<String, String>> myProducts = [];
  List<Map<String, dynamic>> orders = [];
  List<Map<String, String>> coupons = [];
  Map<String, List<Map<String, String>>> categorizedProducts = {};
  Map<String, String> appliedCoupon = {};
  String myProductsMessage = "Oops!";

  getCategories(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
    profileProvider.showLoader();
    var url =
        "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getcategories";
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
      try {
        if (jsonDecode(response.body)["status"]) {
          categories = {};
          (jsonDecode(response.body)["message"])
              .where(
                  (element) => element["customer_group_id"].toString() == "2")
              .toList()
              .forEach((e) => categories.addAll({
                    capitalize(e["category_name"].toString().toLowerCase()):
                        int.tryParse(e["category_id"]) ?? 24
                  }));
          print(jsonDecode(response.body)["message"]);
          print(categories);
        } else {
          showMessage("Error fetching data!");
          profileProvider.hideLoader();
          notifyListeners();
        }

        notifyListeners();
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
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

  getSubCategories(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
    profileProvider.showLoader();
    var url =
        "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getsubcategories";
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
      try {
        if (jsonDecode(response.body)["status"]) {
          subcategories = {};
          (jsonDecode(response.body)["message"])
              .where(
                  (element) => element["customer_group_id"].toString() == "2")
              .toList()
              .forEach((e) {
            if (subcategories.isNotEmpty &&
                (subcategories[int.tryParse(e["parent_id"]) ?? 0]?.isNotEmpty ??
                    false)) {
              subcategories[int.tryParse(e["parent_id"]) ?? 0]!.add({
                capitalize(e["sub_category_name"].toString().toLowerCase()):
                    int.tryParse(e["sub_category_id"]) ?? 62
              });
            } else {
              subcategories.addAll({
                int.tryParse(e["parent_id"]) ?? 0: [
                  {
                    capitalize(e["sub_category_name"].toString().toLowerCase()):
                        int.tryParse(e["sub_category_id"]) ?? 62
                  }
                ]
              });
            }
          });
          print(subcategories);
        } else {
          showMessage("Error fetching data!");
          profileProvider.hideLoader();
          notifyListeners();
        }

        notifyListeners();
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
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

  getAllProducts(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
    profileProvider.showLoader();
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
      try {
        List<dynamic> decodedResponse = jsonDecode(response.body)["Products"];
        products = [];

        for (var e in decodedResponse) {
          if (categories.entries
              .where((element) =>
                  element.value ==
                  int.tryParse(e["category"][0]["category_id"] ?? "-1"))
              .isNotEmpty) {
            var locationGeoCoded = await placemarkFromCoordinates(
                e["vendor_details"][0]["location"]["lagtitude"]
                        .toString()
                        .contains("0.0")
                    ? double.tryParse(e["vendor_details"][0]["location"]
                                ["lagtitude"]
                            .toString()) ??
                        17.7003844
                    : 17.7003844,
                e["vendor_details"][0]["location"]["latitude"]
                        .toString()
                        .contains("0.0")
                    ? double.tryParse(e["vendor_details"][0]["location"]
                                ["latitude"]
                            .toString()) ??
                        83.1016542
                    : 83.1016542);

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
              'place':
                  "${locationGeoCoded.first.subLocality ?? "Paravada"}, ${locationGeoCoded.first.subAdministrativeArea ?? "Visakhapatnam"}",
              'url': Uri.tryParse(e["Products"][0]["image"].toString())
                          ?.host
                          .isNotEmpty ??
                      false
                  ? e["Products"][0]["image"].toString()
                  : "http://images.jdmagicbox.com/comp/visakhapatnam/q2/0891px891.x891.180329082226.k1q2/catalogue/nandi-krushi-visakhapatnam-e-commerce-service-providers-aomg9cai5i-250.jpg",
              'seller_name':
                  (e["vendor_details"][0]["name"] ?? "Farmer").toString(),
              'seller_mobile':
                  (e["vendor_details"][0]["mobile"] ?? "8341980196").toString(),
              'seller_email':
                  (e["vendor_details"][0]["email"] ?? "info@spotmies.com")
                      .toString(),
              'seller_place':
                  "${locationGeoCoded.first.subLocality ?? "Paravada"}, ${locationGeoCoded.first.subAdministrativeArea ?? "Visakhapatnam"}",
              'seller_certificate': (e["vendor_details"][0]["certificates"] ??
                      "Organic Certification")
                  .toString(),
              'rating': (((double.tryParse(e["Products"][0]["aggregateRating"]
                                      .toString()) ??
                                  0) *
                              2)
                          .round() /
                      2)
                  .toString(),
            };
            log("12Prod->$element ,; $e");
            products.add(element);
          }
        }
        products = products.toSet().toList();

        for (var element in categories.keys) {
          categorizedProducts[element] = [];
          for (var product in products) {
            if (product["category_id"] == element) {
              categorizedProducts[element]?.add(product);
            }
          }
        }

        notifyListeners();
        await getMyProducts(
            showMessage: showMessage,
            profileProvider: profileProvider,
            isFromNavHost: isFromNavHost);
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
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

  getOrders(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
    profileProvider.showLoader();

    var ordersData = await post(
      Uri.parse(
          "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/getorders"),
      body: jsonEncode({"customer_id": profileProvider.sellerID.toString()}),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
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
      orders = [];
      try {
        if (jsonDecode(ordersData.body)["status"]) {
          List<dynamic> orderJSONResponse =
              jsonDecode(ordersData.body)["order"];
          print(orderJSONResponse);
          for (var element in orderJSONResponse) {
            print("order - 1- > $element");
            var orderData = {"order_id": element["order_id"]};
            orderData["products"] = [];
            for (var productOrderDetails
                in (element["product_details"] as List<dynamic>)) {
              if (products
                  .where((e) =>
                      e["product_id"] == productOrderDetails["product_id"])
                  .isNotEmpty) {
                (orderData["products"]).add({
                  "product_name": productOrderDetails["product_name"],
                  "description": products
                          .where((e) =>
                              e["product_id"] ==
                              productOrderDetails["product_id"])
                          .isNotEmpty
                      ? products
                          .where((e) =>
                              e["product_id"] ==
                              productOrderDetails["product_id"])
                          .first["description"]
                          .toString()
                      : productOrderDetails["description"],
                  "url": (Uri.tryParse(products
                                  .where((e) =>
                                      e["product_id"] ==
                                      productOrderDetails["product_id"])
                                  .first["url"]
                                  .toString())
                              ?.host
                              .isNotEmpty ??
                          false)
                      ? products
                          .where((e) =>
                              e["product_id"] ==
                              productOrderDetails["product_id"])
                          .first["url"]
                          .toString()
                      : "http://images.jdmagicbox.com/comp/visakhapatnam/q2/0891px891.x891.180329082226.k1q2/catalogue/nandi-krushi-visakhapatnam-e-commerce-service-providers-aomg9cai5i-250.jpg",
                  "price": productOrderDetails["price"],
                  "product_id": productOrderDetails["product_id"],
                  "quantity": productOrderDetails["quantity"],
                  "units": products
                      .where((e) =>
                          e["product_id"] == productOrderDetails["product_id"])
                      .first["units"]
                      .toString(),
                  "place": element["shipping_details"][0]["shipping_city"],
                });
              }
            }
            orderData.addAll({
              "customer_name":
                  "${element["customer_details"][0]["firstname"]} ${element["customer_details"][0]["lastname"]}",
              "date": element["delivery_details"][0]["delivery_date"]
            });

            print("order - 2- > $orderData");
            orders.add(orderData);
          }
          log(orders.toString());
          if (!isFromNavHost) {
            profileProvider.isDataFetched = true;
            notifyListeners();
            profileProvider.hideLoader();
          } else {
            notifyListeners();
          }
        } else {
          orders = [];
          notifyListeners();
          if (!isFromNavHost) {
            profileProvider.isDataFetched = true;
            notifyListeners();
            profileProvider.hideLoader();
          } else {
            notifyListeners();
          }
        }
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
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
  }

  getCart(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
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
      try {
        if (jsonDecode(cartData.body)["status"]) {
          List<dynamic> cartJSONResponse =
              jsonDecode(cartData.body)["cart_products"];
          cart = cartJSONResponse.map((cartItem) {
            var productCartItem = products
                .where((element) =>
                    element["product_id"] ==
                    (cartItem["product_id"].toString()))
                .first;
            return {
              "cart_id": cartItem["cart_id"].toString(),
              "name": productCartItem["name"].toString(),
              'unit': productCartItem["units"].toString(),
              "product_id": cartItem["product_id"].toString(),
              "quantity": cartItem['quantity'].toString(),
              'price': productCartItem['price']
                  .toString()
                  .replaceFirst("\$", "")
                  .toString(),
              'place': productCartItem["place"].toString(),
              'url': (Uri.tryParse(productCartItem["url"].toString())
                          ?.host
                          .isNotEmpty ??
                      false)
                  ? productCartItem["url"].toString()
                  : "http://images.jdmagicbox.com/comp/visakhapatnam/q2/0891px891.x891.180329082226.k1q2/catalogue/nandi-krushi-visakhapatnam-e-commerce-service-providers-aomg9cai5i-250.jpg",
            };
          }).toList();
          log("CART: $cart");
          if (!isFromNavHost) {
            profileProvider.isDataFetched = true;
            notifyListeners();
            profileProvider.hideLoader();
          } else {
            notifyListeners();
          }
        } else {
          cart = [];

          log("CART: $cart");
          if (!isFromNavHost) {
            profileProvider.isDataFetched = true;
            notifyListeners();
            profileProvider.hideLoader();
          } else {
            notifyListeners();
          }
        }
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
      }
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
  }

  getMyProducts(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
    print("Getting data");
    var myProductsData = await Server().postFormData(
        url:
            "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/sellerproduct/GetSellerproductdata",
        body: {
          "user_id": profileProvider.userIdForAddress,
        });
    if (myProductsData == null) {
      showMessage("Failed to get a response from the server!");
      //hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return;
    }

    if (myProductsData.statusCode == 200) {
      try {
        if (jsonDecode(myProductsData.body)["status"]) {
          List<dynamic> myProductsJSONResponse =
              jsonDecode(myProductsData.body)["message"];
          myProducts = myProductsJSONResponse
              .map((e) => (e as Map<String, dynamic>)
                  .map((key, value) => MapEntry(key, value.toString())))
              .toList();
          log(myProducts.toString());
        } else {
          myProducts = [];
          myProductsMessage =
              myProductsData.body.toLowerCase().contains("disabled")
                  ? "Products have been disabled"
                  : "Oops!";
        }
        if (!isFromNavHost) {
          profileProvider.isDataFetched = true;
          notifyListeners();
          profileProvider.hideLoader();
        } else {
          notifyListeners();
        }
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
      }
    } else if (myProductsData.statusCode == 400) {
      showMessage("Undefined parameter when calling API");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } else if (myProductsData.statusCode == 404) {
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

  getCoupons(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider,
      bool isFromNavHost = false}) async {
    var couponsData = await Server().getMethodParams(
        "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/coupon/getcoupon");
    if (couponsData == null) {
      showMessage("Failed to get a response from the server!");
      //hideLoader();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return;
    }
    if (couponsData.statusCode == 200) {
      try {
        if (jsonDecode(couponsData.body)["status"]) {
          List<dynamic> couponsJSONResponse =
              jsonDecode(couponsData.body)["message"];
          coupons = couponsJSONResponse
              .map((e) => (e as Map<String, dynamic>)
                  .map((key, value) => MapEntry(key, value.toString())))
              .toList();
          coupons.retainWhere((e) {
            return DateFormat("yyyy-MM-dd")
                    .parse(e["date_end"].toString())
                    .isAfter(DateTime.now()) &&
                DateFormat("yyyy-MM-dd")
                    .parse(e["date_start"].toString())
                    .isBefore(DateTime.now());
          });
          log(coupons.toString());
        }
        if (!isFromNavHost) {
          profileProvider.isDataFetched = true;
          notifyListeners();
          profileProvider.hideLoader();
        } else {
          notifyListeners();
        }
      } on Exception catch (e) {
        showMessage("Error fetching data: $e");
        profileProvider.hideLoader();
        notifyListeners();
      }
    } else if (couponsData.statusCode == 400) {
      showMessage("Undefined parameter when calling API");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } else if (couponsData.statusCode == 404) {
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
        if (jsonDecode(cartData.body)["status"]) {
          //TODO add to cart manually and then notifyListener
          print("Hello!");
          await getCart(
              showMessage: showMessage, profileProvider: profileProvider);
          await getAllProducts(
              showMessage: showMessage, profileProvider: profileProvider);
        } else {
          snackbar(context, jsonDecode(cartData.body)["message"]);
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
                            profileProvider.showLoader();
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
                            log("payload->${updateCartBody}");
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
                              if (jsonDecode(cartData.body)["status"]) {
                                //TODO update to cart manually and then notifyListener

                                await getAllProducts(
                                    showMessage: showMessage,
                                    profileProvider: profileProvider);
                                await getCart(
                                    showMessage: showMessage,
                                    profileProvider: profileProvider);
                              }
                              profileProvider.isDataFetched = true;
                            } else if (cartData.statusCode == 400) {
                              showMessage(
                                  "Undefined parameter when calling API");
                              profileProvider.hideLoader();
                            } else if (cartData.statusCode == 404) {
                              showMessage("API not found");
                              profileProvider.hideLoader();
                            } else {
                              showMessage("Failed to get data!");
                              profileProvider.hideLoader();
                            }
                            Navigator.of(context).pop();
                          },
                          height: 54,
                          borderRadius: 8,
                          bgColor: Theme.of(context).colorScheme.primary,
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
      modifyProductToCart(
          context: context,
          productID: productID,
          onSuccessful: onSuccessful,
          showMessage: showMessage,
          profileProvider: profileProvider);

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
        notifyListeners();
        profileProvider.hideLoader();
        return;
      }
      if (cartData.statusCode == 200) {
        if (jsonDecode(cartData.body)["status"]) {
          //TODO add to cart manually and then notifyListener
          await getCart(
              showMessage: showMessage, profileProvider: profileProvider);
          await getAllProducts(
              showMessage: showMessage, profileProvider: profileProvider);
        }
        profileProvider.isDataFetched = true;
        notifyListeners();
      } else if (cartData.statusCode == 400) {
        showMessage("Undefined parameter when calling API");
      } else if (cartData.statusCode == 404) {
        showMessage("API not found");
      } else {
        showMessage("Failed to get data!");
      }
      profileProvider.hideLoader();
      notifyListeners();
    }
  }

  updateCoupon(Map<String, String> _) {
    appliedCoupon = _;
    notifyListeners();
  }

  Future<void> getData(
      {required Function(String) showMessage,
      required ProfileProvider profileProvider}) async {
    await getCategories(
        showMessage: showMessage,
        profileProvider: profileProvider,
        isFromNavHost: true);
    await getSubCategories(
        showMessage: showMessage,
        profileProvider: profileProvider,
        isFromNavHost: true);
    await getAllProducts(
        showMessage: showMessage,
        profileProvider: profileProvider,
        isFromNavHost: true);
    await getOrders(
        showMessage: showMessage,
        profileProvider: profileProvider,
        isFromNavHost: true);
    await getCart(
        showMessage: showMessage,
        profileProvider: profileProvider,
        isFromNavHost: true);

    await getCoupons(
        showMessage: showMessage,
        profileProvider: profileProvider,
        isFromNavHost: true);

    profileProvider.isDataFetched = true;
    notifyListeners();
    profileProvider.hideLoader();
    //TODO: Update the above get methods to include the hide loader
    // as soon as data is fetched unless first time
  }
}
