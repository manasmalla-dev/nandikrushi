import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushifarmer/model/product.dart';
import 'package:nandikrushifarmer/repo/api_methods.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/reusable_widgets/success_screen.dart';

class AddProductController extends ControllerMVC {
  var formControllers = {
    'category': TextEditingController(),
    'sub-category': TextEditingController(),
    'units': TextEditingController(),
    'quantity': TextEditingController(),
    'price': TextEditingController(),
    'description': TextEditingController()
  };

  addProduct(context, image) async {
    var category = formControllers['category']?.text ?? "";
    var subcategory = formControllers['sub-category']?.text ?? "";
    var units = formControllers['units']?.text ?? "";
    var quantity = formControllers['quantity']?.text ?? "";
    var price = formControllers['price']?.text ?? "";
    var description = formControllers['description']?.text ?? "";
    var product = Product(
        category: category,
        subcategory: subcategory,
        units: units,
        price: double.tryParse(price) ?? 0.0,
        quantity: int.tryParse(quantity) ?? 0,
        description: description,
        productImage: image);
    var body = {
      "seller_id": "57",
      "category_id": product.category.toString(),
      "name": product.subcategory.toString(),
      "units": product.units.toString(),
      "price": product.price.toString(),
      "quantity": product.quantity.toString(),
      "description": product.description.toString(),
      "product_image": product.productImage.toString(),
    };
    log(body.toString());

    Server()
        .postMethodParems(body,
            url:
                "http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/addsellerproduct/index")
        .then((response) {
      if (response.statusCode == 200) {
        log("sucess");
        log(response.body);
      } else if (response.statusCode == 400) {
        snackbar(context, "Undefined Parameter when calling API");
        log("Undefined Parameter");
      } else if (response.statusCode == 404) {
        snackbar(context, "API Not found");
        log("Not found");
      } else {
        snackbar(context, "Failed to get data!");
        log("failure");
      }
    });

    /*var resp =
        await Server().postMethodParems(jsonEncode(body)).catchError((e) {
      log("64" + e.toString());
    });
    
    log(resp.body.toString());*/

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()));
  }
}
