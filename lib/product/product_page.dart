import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/my_account.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Map<String, String> productDetails;
  const ProductPage({Key? key, required this.productDetails}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: kToolbarHeight,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 50,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 12,
                        child: Icon(
                          Icons.shopping_basket_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                      productProvider.cart.isNotEmpty
                          ? Positioned(
                              top: 4,
                              right: 12,
                              child: ClipOval(
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  color: Colors.red,
                                  child: Center(
                                    child: TextWidget(
                                      productProvider.cart.length.toString(),
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
            title: const SizedBox(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 185,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Image.network(
                            widget.productDetails["url"] ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          widget.productDetails["name"] ?? "Product Name",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.fontSize),
                        ),
                        Text(
                          widget.productDetails["category_id"] ?? "Category",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextWidget(
                          widget.productDetails["units"] ?? "1 unit",
                          weight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWidget(
                              "Rs.",
                              size: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.fontSize,
                              weight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            TextWidget(
                              double.tryParse(
                                          widget.productDetails["price"] ?? "")
                                      ?.toStringAsFixed(2) ??
                                  "",
                              size: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.fontSize,
                              weight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Row(
                        //   children: const [
                        //     FixedRatingStar(),
                        //     FixedRatingStar(),
                        //     FixedRatingStar(),
                        //     FixedRatingStar(
                        //       value: 0.5,
                        //     ),
                        //     FixedRatingStar(
                        //       value: 0,
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            productProvider.cart
                                    .where((e) =>
                                        e["product_id"] ==
                                        widget.productDetails["product_id"])
                                    .isNotEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding: const EdgeInsets.all(
                                                4), // and this
                                            side: const BorderSide(width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {
                                          productProvider.removeProductFromCart(
                                              productID: widget.productDetails[
                                                      "product_id"] ??
                                                  "",
                                              onSuccessful: () => null,
                                              showMessage: (_) {
                                                snackbar(context, _);
                                              },
                                              profileProvider: profileProvider);
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
                                        width: 8,
                                      ),
                                      Text(
                                        productProvider.cart
                                                .where((e) =>
                                                    e["product_id"] ==
                                                    widget.productDetails[
                                                        "product_id"])
                                                .first["quantity"] ??
                                            "0",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding: const EdgeInsets.all(
                                                4), // and this
                                            side: const BorderSide(width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {
                                          productProvider.addProductToCart(
                                              productID: widget.productDetails[
                                                      "product_id"] ??
                                                  "",
                                              onSuccessful: () => null,
                                              showMessage: (_) {
                                                snackbar(context, _);
                                              },
                                              profileProvider: profileProvider);
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
                                  )
                                : OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: Size.zero, // Set this
                                        padding:
                                            const EdgeInsets.all(4), // and this
                                        side: const BorderSide(width: 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100))),
                                    onPressed: () {
                                      productProvider.addProductToCart(
                                          productID: widget.productDetails[
                                                  "product_id"] ??
                                              "",
                                          onSuccessful: () => null,
                                          showMessage: (_) {
                                            snackbar(context, _);
                                          },
                                          profileProvider: profileProvider);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            size: 14,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          TextWidget("Add".toUpperCase(),
                                              weight: FontWeight.bold,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  ?.fontSize),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              width: 12,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.all(4), // and this
                                  side: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).primaryColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    builder: (context) {
                                      return Container(
                                        height: 250,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              "Contact Us",
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.fontSize,
                                              weight: FontWeight.bold,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextWidget(
                                              "Choose one of the following sources to get support",
                                              flow: TextOverflow.visible,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.fontSize,
                                              weight: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.fontWeight,
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: const [
                                                Expanded(
                                                  flex: 3,
                                                  child: Icon(
                                                      Icons.email_rounded,
                                                      size: 48),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 3,
                                                  child: Icon(
                                                      Icons.phone_rounded,
                                                      size: 48),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        onPrimary:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onPrimary),
                                                    onPressed: () async {
                                                      launchEmail();
                                                    },
                                                    child: const Text(
                                                      "Email",
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Expanded(
                                                  flex: 3,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        onPrimary:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onPrimary),
                                                    onPressed: () async {
                                                      dialCall();
                                                    },
                                                    child: const Text("Phone"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: TextWidget(
                                  "Contact".toUpperCase(),
                                  size: Theme.of(context)
                                      .textTheme
                                      .button
                                      ?.fontSize,
                                  weight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const TextWidget(
                          'Product Description',
                          weight: FontWeight.w800,
                        ),
                        TextWidget(widget.productDetails["description"] ?? "",
                            flow: TextOverflow.visible),
                        const SizedBox(
                          height: 12,
                        ),
                        const TextWidget(
                          'Farmer Details',
                          weight: FontWeight.w800,
                          size: 18,
                        ),
                        const TextWidget(
                          'Farmer Name: Rahul Varma',
                          weight: FontWeight.w500,
                        ),
                        TextWidget(
                          'Location : ${widget.productDetails["place"] ?? "Visakhapatnam"}',
                          weight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            const TextWidget(
                              'Certification : ',
                              weight: FontWeight.w500,
                            ),
                            TextWidget(
                              'Self Declared National Farmer.',
                              weight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        TextWidget(
                          'More Farmer Products'.toUpperCase(),
                          weight: FontWeight.w800,
                          size: 16,
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return ProductCard(
                                includeHorizontalPadding: false,
                                type: CardType.product,
                                productId:
                                    productProvider.categorizedProducts["Fruits"]
                                            ?[index]["product_id"] ??
                                        "XYZ",
                                productName:
                                    productProvider.categorizedProducts["Fruits"]
                                            ?[index]["name"] ??
                                        "Name",
                                productDescription:
                                    productProvider.categorizedProducts["Fruits"]
                                            ?[index]["description"] ??
                                        "Description",
                                imageURL: productProvider
                                            .categorizedProducts["Fruits"]
                                        ?[index]["url"] ??
                                    "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                                price: double.tryParse(productProvider.categorizedProducts["Fruits"]?[index]["price"] ?? "00.00") ?? 00.00,
                                units: productProvider.categorizedProducts["Fruits"]?[index]["units"] ?? "1 unit",
                                location: productProvider.categorizedProducts["Fruits"]?[index]["place"] ?? "Visakhapatnam");
                          },
                          itemCount: 3,
                          primary: false,
                          shrinkWrap: true,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
