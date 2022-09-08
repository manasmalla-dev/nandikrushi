/* import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Positioned(
          top: -(height(context) * 0.03),
          left: width(context) * 0.48,
          child: const Image(
            image: AssetImage("assets/images/ic_farmer.png"),
          ),
        ),
        SizedBox(
          height: height(context) * 0.15,
          child: Container(
            margin: EdgeInsets.only(top: height(context) * 0.08),
            padding: EdgeInsets.symmetric(horizontal: width(context) * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NandiKrushiTitle(),
                TextWidget(
                  "Add Product".toUpperCase(),
                  color: const Color(0xFF006838),
                  weight: FontWeight.bold,
                  size: height(context) * 0.017,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: height(context) * 0.15,
            ),
            SizedBox(
              height: height(context) * 0.99,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: height(context) * 0.06,
                      ),
                      Container(
                        width: width(context),
                        margin: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.075),
                        padding: EdgeInsets.only(
                            top: height(context) * 0.005,
                            bottom: height(context) * 0.015),
                        decoration: BoxDecoration(
                            color:
                                SpotmiesTheme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                                height(context) * 0.02)),
                        child: addProductController.productImage.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    iconSize: height(context) * 0.07,
                                    color: SpotmiesTheme.primaryColor,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          builder: (context) {
                                            return Container(
                                              height: height(context) * 0.2,
                                              padding:
                                                  const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    "Product Image",
                                                    size: height(context) *
                                                        0.03,
                                                    weight: FontWeight.w500,
                                                  ),
                                                  SizedBox(
                                                    height: height(context) *
                                                        0.01,
                                                  ),
                                                  TextWidget(
                                                    "Choose an image of the product from one of the following sources",
                                                    flow:
                                                        TextOverflow.visible,
                                                    size: height(context) *
                                                        0.016,
                                                    color: Colors.grey,
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              primary:
                                                                  SpotmiesTheme
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
                                                                    source: ImageSource
                                                                        .gallery);
                                                            if (image !=
                                                                null) {
                                                              addProductController
                                                                  .productImage
                                                                  .add(image);
                                                            } else {
                                                              Navigator.maybeOf(
                                                                      context)
                                                                  ?.maybePop();
                                                            }
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const TextWidget(
                                                            text: "Gallery",
                                                            color:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Expanded(
                                                        flex: 3,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              primary:
                                                                  SpotmiesTheme
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
                                                                    source: ImageSource
                                                                        .camera);
                                                            if (image !=
                                                                null) {
                                                              addProductController
                                                                  .productImage
                                                                  .add(image);
                                                            } else {
                                                              Navigator.maybeOf(
                                                                      context)
                                                                  ?.maybePop();
                                                            }
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const TextWidget(
                                                                  text:
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
                                    splashRadius: height(context) * 0.04,
                                    icon:
                                        const Icon(Icons.add_a_photo_rounded),
                                  ),
                                  TextWidget(
                                    text: "Add Product Image",
                                    color: SpotmiesTheme.primaryColor
                                        .withOpacity(0.7),
                                    weight: FontWeight.w500,
                                    size: height(context) * 0.02,
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
                                        height: height(context) * 0.138,
                                        child: ListView.builder(
                                            itemCount: addProductController
                                                .productImage.length,
                                            shrinkWrap: true,
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              var image = addProductController
                                                  .productImage[index];
                                              return SizedBox(
                                                height:
                                                    height(context) * 0.142,
                                                width:
                                                    height(context) * 0.142,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: SizedBox(
                                                          height: height(
                                                                  context) *
                                                              0.13,
                                                          width: height(
                                                                  context) *
                                                              0.13,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child: ClipOval(
                                                                  child: Image
                                                                      .file(
                                                                File(image
                                                                        ?.path ??
                                                                    ""),
                                                                height: height(
                                                                        context) *
                                                                    0.13,
                                                                width: height(
                                                                        context) *
                                                                    0.13,
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
                                                              color: SpotmiesTheme
                                                                  .primaryColor,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      height: height(context) *
                                                                          0.2,
                                                                      padding:
                                                                          const EdgeInsets.all(16),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          TextWidget(
                                                                            text: "Product Image",
                                                                            size: height(context) * 0.03,
                                                                            weight: FontWeight.w500,
                                                                          ),
                                                                          SizedBox(
                                                                            height: height(context) * 0.01,
                                                                          ),
                                                                          TextWidget(
                                                                            text: "Choose an image of the product from one of the following sources",
                                                                            flow: TextOverflow.visible,
                                                                            size: height(context) * 0.016,
                                                                            color: Colors.grey,
                                                                          ),
                                                                          const Spacer(),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                flex: 3,
                                                                                child: ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(primary: SpotmiesTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), onPrimary: Colors.white),
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
                                                                                    text: "Gallery",
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const Spacer(),
                                                                              Expanded(
                                                                                flex: 3,
                                                                                child: ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(primary: SpotmiesTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), onPrimary: Colors.white),
                                                                                  onPressed: () async {
                                                                                    var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                                                                    if (image != null) {
                                                                                      addProductController.productImage[index] = image;
                                                                                    } else {
                                                                                      Navigator.maybeOf(context)?.maybePop();
                                                                                    }
                                                                                    setState(() {});
                                                                                  },
                                                                                  child: const TextWidget(text: "Camera", color: Colors.white),
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
                                            color: SpotmiesTheme.primaryColor,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        height(context) * 0.2,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextWidget(
                                                          text:
                                                              "Product Image",
                                                          size: height(
                                                                  context) *
                                                              0.03,
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                        SizedBox(
                                                          height: height(
                                                                  context) *
                                                              0.01,
                                                        ),
                                                        TextWidget(
                                                          text:
                                                              "Choose an image of the product from one of the following sources",
                                                          flow: TextOverflow
                                                              .visible,
                                                          size: height(
                                                                  context) *
                                                              0.016,
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
                                                                    primary:
                                                                        SpotmiesTheme
                                                                            .primaryColor,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(
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
                                                                  text:
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
                                                                    primary:
                                                                        SpotmiesTheme
                                                                            .primaryColor,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(
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
                                                                    text:
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
                        margin: EdgeInsets.all(width(context) * 0.075),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height(context) * 0.28,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Product Information",
                                    color: Colors.grey.shade800,
                                    weight: FontWeight.bold,
                                    size: height(context) * 0.02,
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.01,
                                  ),
                                  TextFieldWidget(
                                    controller: addProductController
                                        .formControllers['product-name'],
                                    label: 'Product Name',
                                    hintSize: 20,
                                    hintColor: Colors.grey.shade600,
                                    style: fonts(
                                        15.0, FontWeight.w500, Colors.black),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<
                                                String>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical:
                                                          height(context) *
                                                              0.018),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFF006838))),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            style: fonts(
                                                20.0,
                                                FontWeight.w500,
                                                Colors.black),
                                            hint: TextWidget(
                                              text: 'Category',
                                              size: 20,
                                              color: Colors.grey.shade600,
                                            ),
                                            value: addProductController
                                                .selectedCategory,
                                            items: addProductController
                                                .categories.keys
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child:
                                                          TextWidget(text: e),
                                                    ))
                                                .toList(),
                                            onChanged: (_) {
                                              setState(() {
                                                addProductController
                                                    .selectedCategory = _;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: width(context) * 0.05,
                                      ),
                                      Expanded(
                                        child: DropdownButtonFormField<
                                                String>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical:
                                                          height(context) *
                                                              0.018),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFF006838))),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            style: fonts(
                                                20.0,
                                                FontWeight.w500,
                                                Colors.black),
                                            hint: TextWidget(
                                              text: 'Sub-Category',
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
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child:
                                                          TextWidget(text: e),
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
                                  SizedBox(
                                    height: height(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<
                                                String>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical:
                                                          height(context) *
                                                              0.02),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFF006838))),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            style: fonts(
                                                20.0,
                                                FontWeight.w500,
                                                Colors.black),
                                            hint: TextWidget(
                                              text: 'Units',
                                              size: 20,
                                              color: Colors.grey.shade600,
                                            ),
                                            value: addProductController
                                                .selectedUnits,
                                            items: up.units
                                                .map((key, value) => MapEntry(
                                                    key,
                                                    DropdownMenuItem<String>(
                                                      value: value,
                                                      child: TextWidget(
                                                          text:
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
                                      SizedBox(
                                        width: width(context) * 0.05,
                                      ),
                                      Expanded(
                                        child: TextFieldWidget(
                                          controller: addProductController
                                              .formControllers['quantity'],
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
                              controller: addProductController
                                  .formControllers['price'],
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
                                color: SpotmiesTheme.primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: height(context) * 0.16,
                              padding: const EdgeInsets.all(4),
                              child: FilledTextFieldWidget(
                                fillColor: Colors.transparent,
                                keyBoardType: TextInputType.text,
                                controller: addProductController
                                    .formControllers['description'],
                                hintSize: 16,
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
                    padding: EdgeInsets.only(bottom: height(context) * 0.025),
                    child: ElevatedButtonWidget(
                      onClick: () async {
                        List<String> urls = [];
                        await Future.forEach(
                            addProductController.productImage,
                            (element) async {
                          String urlData = await uploadFilesToCloud(element,
                              cloudLocation: "product_images",
                              fileType: ".png");
                          urls.add(urlData);
                        });
                        if (urls.isNotEmpty) {
                          addProductController.addProduct(
                              context, urls, up.units.values.toList());
                        } else {
                          snackbar(context,
                              "Please upload a picture of the product!");
                        }
                      },
                      minWidth: width(context) * 0.85,
                      height: height(context) * 0.06,
                      borderRadius: 8,
                      allRadius: true,
                      bgColor: SpotmiesTheme.primaryColor,
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
      ]),
    );
  }
}
 */