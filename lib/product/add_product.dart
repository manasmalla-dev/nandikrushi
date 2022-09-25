// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/firebase_storage_utils.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:nandikrushi_farmer/product/product_controller.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ProductController addProductController = ProductController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(children: [
            const Positioned(
              top: -30,
              left: 200,
              child: Image(
                image: AssetImage("assets/images/ic_farmer.png"),
              ),
            ),
            SizedBox(
              height: 140,
              child: Container(
                margin: const EdgeInsets.only(top: 72),
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nandikrushi",
                      style: TextStyle(
                          color: calculateContrast(
                                      const Color(0xFF769F77),
                                      createMaterialColor(Theme.of(context)
                                              .colorScheme
                                              .primary)
                                          .shade700) >
                                  3
                              ? createMaterialColor(
                                      Theme.of(context).colorScheme.primary)
                                  .shade700
                              : createMaterialColor(
                                      Theme.of(context).colorScheme.primary)
                                  .shade100,
                          fontFamily: 'Samarkan',
                          fontSize: getProportionateHeight(32, constraints)),
                    ),
                    TextWidget(
                      "Add Product".toUpperCase(),
                      color: const Color(0xFF006838),
                      weight: FontWeight.bold,
                      size: Theme.of(context).textTheme.titleSmall?.fontSize,
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 140,
                  ),
                  SizedBox(
                    height: 900,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 54,
                            ),
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 12),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(18)),
                              child: addProductController.productImage.isEmpty
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          iconSize: 64,
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                builder: (context) {
                                                  return Container(
                                                    height: 180,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const TextWidget(
                                                          "Product Image",
                                                          size: 27,
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const TextWidget(
                                                          "Choose an image of the product from one of the following sources",
                                                          flow: TextOverflow
                                                              .visible,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        const Spacer(),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    primary: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8)),
                                                                    onPrimary:
                                                                        Colors
                                                                            .white),
                                                                onPressed:
                                                                    () async {
                                                                  var image = await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                                  if (image !=
                                                                      null) {
                                                                    addProductController
                                                                        .productImage
                                                                        .add(
                                                                            image);
                                                                  } else {
                                                                    Navigator.maybeOf(
                                                                            context)
                                                                        ?.maybePop();
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    const TextWidget(
                                                                  "Gallery",
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    primary: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8)),
                                                                    onPrimary:
                                                                        Colors
                                                                            .white),
                                                                onPressed:
                                                                    () async {
                                                                  var image = await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                                  if (image !=
                                                                      null) {
                                                                    addProductController
                                                                        .productImage
                                                                        .add(
                                                                            image);
                                                                  } else {
                                                                    Navigator.maybeOf(
                                                                            context)
                                                                        ?.maybePop();
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: const TextWidget(
                                                                    "Camera",
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          splashRadius: 36,
                                          icon: const Icon(
                                              Icons.add_a_photo_rounded),
                                        ),
                                        TextWidget(
                                          "Add Product Image",
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.7),
                                          weight: FontWeight.w500,
                                          size: 18,
                                        )
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              height: 128,
                                              child: ListView.builder(
                                                  itemCount:
                                                      addProductController
                                                          .productImage.length,
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var image =
                                                        addProductController
                                                                .productImage[
                                                            index];
                                                    return SizedBox(
                                                      height: 128,
                                                      width: 128,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                              child: SizedBox(
                                                                height: 120,
                                                                width: 120,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Center(
                                                                    child: ClipOval(
                                                                        child: Image.file(
                                                                      File(image
                                                                              ?.path ??
                                                                          ""),
                                                                      height:
                                                                          120,
                                                                      width:
                                                                          120,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                12)),
                                                                        builder:
                                                                            (context) {
                                                                          return Container(
                                                                            height:
                                                                                180,
                                                                            padding:
                                                                                const EdgeInsets.all(16),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const TextWidget(
                                                                                  "Product Image",
                                                                                  size: 27,
                                                                                  weight: FontWeight.w500,
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 12,
                                                                                ),
                                                                                const TextWidget(
                                                                                  "Choose an image of the product from one of the following sources",
                                                                                  flow: TextOverflow.visible,
                                                                                  size: 126,
                                                                                  color: Colors.grey,
                                                                                ),
                                                                                const Spacer(),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 3,
                                                                                      child: ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), onPrimary: Colors.white),
                                                                                        onPressed: () async {
                                                                                          var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                                                          if (image != null) {
                                                                                            addProductController.productImage[index] = image;
                                                                                          } else {
                                                                                            Navigator.maybeOf(context)?.maybePop();
                                                                                          }

                                                                                          setState(() {});
                                                                                        },
                                                                                        child: const TextWidget(
                                                                                          "Gallery",
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const Spacer(),
                                                                                    Expanded(
                                                                                      flex: 3,
                                                                                      child: ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), onPrimary: Colors.white),
                                                                                        onPressed: () async {
                                                                                          var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                                                                          if (image != null) {
                                                                                            addProductController.productImage[index] = image;
                                                                                          } else {
                                                                                            Navigator.maybeOf(context)?.maybePop();
                                                                                          }
                                                                                          setState(() {});
                                                                                        },
                                                                                        child: const TextWidget("Camera", color: Colors.white),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        });
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .edit_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      builder: (context) {
                                                        return Container(
                                                          height: 180,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const TextWidget(
                                                                "Product Image",
                                                                size: 27,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              const TextWidget(
                                                                "Choose an image of the product from one of the following sources",
                                                                flow:
                                                                    TextOverflow
                                                                        .visible,
                                                                size: 18,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: Theme.of(context)
                                                                              .primaryColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                          onPrimary: Colors.white),
                                                                      onPressed:
                                                                          () async {
                                                                        var image =
                                                                            await ImagePicker().pickImage(source: ImageSource.gallery);
                                                                        if (image !=
                                                                            null) {
                                                                          addProductController
                                                                              .productImage
                                                                              .add(image);
                                                                        } else {
                                                                          Navigator.maybeOf(context)
                                                                              ?.maybePop();
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          const TextWidget(
                                                                        "Gallery",
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: Theme.of(context)
                                                                              .primaryColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                          onPrimary: Colors.white),
                                                                      onPressed:
                                                                          () async {
                                                                        var image =
                                                                            await ImagePicker().pickImage(source: ImageSource.camera);
                                                                        if (image !=
                                                                            null) {
                                                                          addProductController
                                                                              .productImage
                                                                              .add(image);
                                                                        } else {
                                                                          Navigator.maybeOf(context)
                                                                              ?.maybePop();
                                                                        }
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child: const TextWidget(
                                                                          "Camera",
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                icon: const Icon(
                                                  Icons.add_a_photo_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 256,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          "Product Information",
                                          color: Colors.grey.shade800,
                                          weight: FontWeight.bold,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        TextFieldWidget(
                                          controller: addProductController
                                              .formControllers['product-name'],
                                          label: 'Product Name',
                                          style: fonts(15.0, FontWeight.w500,
                                              Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFF006838))),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                    ),
                                                  ),
                                                  isExpanded: true,
                                                  style: fonts(
                                                      20.0,
                                                      FontWeight.w500,
                                                      Colors.black),
                                                  hint: TextWidget(
                                                    'Category',
                                                    size: 20,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  value: addProductController
                                                      .selectedCategory,
                                                  items: productProvider
                                                      .categories.keys
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e,
                                                            child:
                                                                TextWidget(e),
                                                          ))
                                                      .toList(),
                                                  onChanged: (_) {
                                                    setState(() {
                                                      addProductController
                                                          .selectedCategory = _;
                                                    });
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFF006838))),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                    ),
                                                  ),
                                                  isExpanded: true,
                                                  style: fonts(
                                                      20.0,
                                                      FontWeight.w500,
                                                      Colors.black),
                                                  hint: TextWidget(
                                                    'Sub-Category',
                                                    size: 20,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  value: addProductController
                                                      .selectedSubCategory,
                                                  items: [
                                                    "Daily Basket",
                                                    "Weekly Basket",
                                                    "Monthly Basket",
                                                  ]
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e,
                                                            child:
                                                                TextWidget(e),
                                                          ))
                                                      .toList(),
                                                  onChanged: (_) {
                                                    setState(() {
                                                      addProductController
                                                          .selectedSubCategory = _;
                                                    });
                                                  }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 18),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFF006838))),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                    ),
                                                  ),
                                                  isExpanded: true,
                                                  style: fonts(
                                                      20.0,
                                                      FontWeight.w500,
                                                      Colors.black),
                                                  hint: TextWidget(
                                                    'Units',
                                                    size: 20,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  value: addProductController
                                                      .selectedUnits,
                                                  items: productProvider.units
                                                      .map((key, value) =>
                                                          MapEntry(
                                                              key,
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                    '$key ($value)'),
                                                              )))
                                                      .values
                                                      .toList(),
                                                  onChanged: (_) {
                                                    setState(() {
                                                      addProductController
                                                          .selectedUnits = _;
                                                    });
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller: addProductController
                                                        .formControllers[
                                                    'quantity'],
                                                label: 'Quantity',
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
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
                                    keyboardType: TextInputType.number,
                                    controller: addProductController
                                        .formControllers['price'],
                                    label: 'Price',
                                    style: fonts(
                                        20.0, FontWeight.w500, Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 27,
                                  ),
                                  TextWidget(
                                    "Product Description",
                                    color: Colors.grey.shade800,
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    height: 150,
                                    padding: const EdgeInsets.all(4),
                                    child: TextFieldWidget(
                                      keyboardType: TextInputType.text,
                                      controller: addProductController
                                          .formControllers['description'],
                                      style: fonts(
                                          16.0, FontWeight.w400, Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButtonWidget(
                            onClick: () async {
                              List<String> urls = [];
                              await Future.forEach(
                                  addProductController.productImage,
                                  (element) async {
                                String urlData = await uploadFilesToCloud(
                                    element,
                                    cloudLocation: "product_images",
                                    fileType: ".png");
                                urls.add(urlData);
                              });
                              if (urls.isNotEmpty) {
                                addProductController.addProduct(context, urls,
                                    productProvider.units.values.toList());
                              } else {
                                snackbar(context,
                                    "Please upload a picture of the product!");
                              }
                            },

                            height: 54,
                            borderRadius: 8,
                            bgColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            buttonName: "Submit".toUpperCase(),
                            innerPadding: 0.02,
                            // textStyle: FontWeight.bold,
                            trailingIcon: Icons.check_rounded,
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
      });
    });
  }
}
