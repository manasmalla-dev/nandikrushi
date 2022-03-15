import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/model/product.dart';
import 'package:nandikrushifarmer/model/user.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/success_screen.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formControllers = {
    'category': TextEditingController(),
    'sub-category': TextEditingController(),
    'units': TextEditingController(),
    'quantity': TextEditingController(),
    'price': TextEditingController(),
    'description': TextEditingController()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Positioned(
          top: -(height(context) * 0.03),
          left: width(context) * 0.48,
          child: const Image(
            image: AssetImage("assets/png/ic_farmer.png"),
          ),
        ),
        SizedBox(
          height: height(context) * 0.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(context) * 0.1),
                child: Text(
                  "Nandikrushi",
                  style: TextStyle(
                      color: const Color(0xFF006838),
                      fontFamily: 'Samarkan',
                      fontSize: height(context) * 0.034),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height(context) * 0.15,
              ),
              Container(
                height: height(context) * 0.95,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        IconButton(
                          iconSize: height(context) * 0.1,
                          color: const Color(0xFF006838),
                          onPressed: () {
                            log("Hello");
                          },
                          splashRadius: height(context) * 0.05,
                          icon: const Icon(Icons.add_a_photo_rounded),
                        ),
                        TextWidget(
                          text: "Add Product Image",
                          color: Colors.grey,
                          weight: FontWeight.bold,
                          size: height(context) * 0.02,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(width(context) * 0.075),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height(context) * 0.2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller:
                                                formControllers['category'],
                                            label: 'Category',
                                            hintSize: 20,
                                            hintColor: Colors.grey.shade600,
                                            style: fonts(20.0, FontWeight.w500,
                                                Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width(context) * 0.05,
                                        ),
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller:
                                                formControllers['sub-category'],
                                            label: 'Sub-Category',
                                            hintSize: 20,
                                            hintColor: Colors.grey.shade600,
                                            style: fonts(15.0, FontWeight.w500,
                                                Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller:
                                                formControllers['units'],
                                            label: 'Units',
                                            hintSize: 20,
                                            hintColor: Colors.grey.shade600,
                                            style: fonts(15.0, FontWeight.w500,
                                                Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width(context) * 0.05,
                                        ),
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller:
                                                formControllers['quantity'],
                                            label: 'Quantity',
                                            hintSize: 20,
                                            hintColor: Colors.grey.shade600,
                                            style: fonts(15.0, FontWeight.w500,
                                                Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              TextFieldWidget(
                                shouldShowCurreny: true,
                                keyBoardType: TextInputType.number,
                                controller: formControllers['price'],
                                label: 'Price',
                                hintSize: 20,
                                style:
                                    fonts(20.0, FontWeight.w500, Colors.black),
                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              TextWidget(
                                text: "Product Description",
                                color: Colors.grey.shade800,
                                weight: FontWeight.bold,
                                size: height(context) * 0.02,
                              ),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: height(context) * 0.16,
                                child: FilledTextFieldWidget(
                                  keyBoardType: TextInputType.number,
                                  controller: formControllers['description'],
                                  hintSize: 20,
                                  style: fonts(
                                      20.0, FontWeight.w500, Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height(context) * 0.03),
                      child: ElevatedButtonWidget(
                        onClick: () {
                          var category =
                              formControllers['category']?.text ?? "";
                          var subcategory =
                              formControllers['sub-category']?.text ?? "";
                          var units = formControllers['units']?.text ?? "";
                          var quantity =
                              formControllers['quantity']?.text ?? "";
                          var price = formControllers['price']?.text ?? "";
                          var description =
                              formControllers['description']?.text ?? "";
                          var product = Product(
                              category: category,
                              subcategory: subcategory,
                              units: units,
                              price: double.tryParse(price) ?? 0.0,
                              quantity: int.tryParse(quantity) ?? 0,
                              description: description,
                              productImage: "");

                          log(product.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuccessScreen()));
                        },
                        minWidth: width(context) * 0.85,
                        height: height(context) * 0.06,
                        borderRadius: 0,
                        allRadius: true,
                        bgColor: Colors.green[900],
                        textColor: Colors.white,
                        buttonName: "Submit".toUpperCase(),
                        innerPadding: 0.02,
                        textSize: width(context) * 0.045,
                        // textStyle: FontWeight.bold,
                        trailingIcon: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: width(context) * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
