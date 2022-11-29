import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/product/add_product.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/server.dart';
import 'package:provider/provider.dart';

import '../reusable_widgets/loader_screen.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.sort_rounded,
              ))
        ],
        title: TextWidget(
          'My Products',
          size: Theme.of(context).textTheme.titleMedium?.fontSize,
          weight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          Consumer<ProductProvider>(builder: (context, productProvider, _) {
            return productProvider.myProducts.isEmpty
                ? Column(children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Image(
                                  image: AssetImage(
                                      'assets/images/empty_basket.png')),
                              const SizedBox(
                                height: 20,
                              ),
                              TextWidget(
                                productProvider.myProductsMessage,
                                weight: FontWeight.w800,
                                size: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.fontSize,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Opacity(
                                opacity: 0.5,
                                child: TextWidget(
                                  'Looks like you have not added any of your item to our huge database of products',
                                  flow: TextOverflow.visible,
                                  align: TextAlign.center,
                                  size: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.fontSize,
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 42),
                                child: ElevatedButtonWidget(
                                  trailingIcon: Icons.add_rounded,
                                  buttonName: 'Add Product'.toUpperCase(),
                                  textStyle: FontWeight.w800,
                                  borderRadius: 8,
                                  innerPadding: 0.03,
                                  onClick: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddProductScreen()));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ])
                : ListView.separated(
                    itemBuilder: (context, itemIndex) {
                      var product = productProvider.myProducts[itemIndex];
                      return InkWell(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32),
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            color: Colors.red.shade200,
                                            child: const Icon(Icons.delete),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Text(
                                          "Delete Product",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        const Text(
                                          "Confirm to delete the product. \nNote, this change can't be reverted.",
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        ElevatedButtonWidget(
                                          buttonName: "Cancel",
                                          trailingIcon: Icons.delete,
                                          bgColor: Colors.transparent,
                                          textColor: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          borderSideColor: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          borderRadius: 12,
                                          onClick: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Consumer<ProfileProvider>(builder:
                                            (context, profileProvider, _) {
                                          return ElevatedButtonWidget(
                                            borderRadius: 12,
                                            buttonName: "Delete",
                                            trailingIcon: Icons.delete,
                                            bgColor: Colors.red.shade400,
                                            onClick: () async {
                                              // Navigator.of(context).pop();
                                              // snackbar(context,
                                              //     "Feature coming soon!");
                                              profileProvider.showLoader();
                                              var response = await Server()
                                                  .postFormData(
                                                      url:
                                                          "http://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/deletesellerproduct",
                                                      body: {
                                                    "user_id": profileProvider
                                                        .userIdForAddress,
                                                    "product_id":
                                                        product["product_id"]
                                                            .toString()
                                                  });
                                              if (response == null) {
                                                snackbar(context,
                                                    "Failed to get a response from the server!");
                                                profileProvider.hideLoader();
                                                //hideLoader();
                                                if (Platform.isAndroid) {
                                                  SystemNavigator.pop();
                                                } else if (Platform.isIOS) {
                                                  exit(0);
                                                }
                                                return;
                                              }
                                              if (response.statusCode == 200) {
                                                if (!response.body.contains(
                                                    '"status":false')) {
                                                  productProvider.getData(
                                                      showMessage: (_) {
                                                        snackbar(context, _);
                                                      },
                                                      profileProvider:
                                                          profileProvider);
                                                } else if (response
                                                        .statusCode ==
                                                    400) {
                                                  snackbar(context,
                                                      "Undefined parameter when calling API");
                                                  profileProvider.hideLoader();
                                                  if (Platform.isAndroid) {
                                                    SystemNavigator.pop();
                                                  } else if (Platform.isIOS) {
                                                    exit(0);
                                                  }
                                                } else if (response
                                                        .statusCode ==
                                                    404) {
                                                  snackbar(
                                                      context, "API not found");
                                                  profileProvider.hideLoader();
                                                  if (Platform.isAndroid) {
                                                    SystemNavigator.pop();
                                                  } else if (Platform.isIOS) {
                                                    exit(0);
                                                  }
                                                } else {
                                                  snackbar(context,
                                                      "Failed to get data!");
                                                  profileProvider.hideLoader();
                                                  if (Platform.isAndroid) {
                                                    SystemNavigator.pop();
                                                  } else if (Platform.isIOS) {
                                                    exit(0);
                                                  }
                                                }
                                              }
                                            },
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: ProductCard(
                          type: CardType.myProducts,
                          productId: product["product_id"] ?? "XYZ",
                          productName: product["product_name"] ?? "Name",
                          productDescription:
                              product["description"] ?? "Description",
                          imageURL: (Uri.tryParse(product["image"] ?? "")
                                      ?.host
                                      .isNotEmpty ??
                                  false)
                              ? (product["image"] ??
                                  "http://images.jdmagicbox.com/comp/visakhapatnam/q2/0891px891.x891.180329082226.k1q2/catalogue/nandi-krushi-visakhapatnam-e-commerce-service-providers-aomg9cai5i-250.jpg")
                              : "http://images.jdmagicbox.com/comp/visakhapatnam/q2/0891px891.x891.180329082226.k1q2/catalogue/nandi-krushi-visakhapatnam-e-commerce-service-providers-aomg9cai5i-250.jpg",
                          price: double.tryParse(product["price"] ?? "00.00") ??
                              00.00,
                          units:
                              "${product["quantity"] ?? "1"} ${product["units"] ?? "unit"}",
                          location: product["place"] ?? "Visakhapatnam",
                          additionalInformation: {
                            "date": DateFormat('dd-MM-yyyy, hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch((int
                                            .tryParse(
                                                product["date_added"] ?? "0") ??
                                        0) *
                                    1000)), //productProvider.orders[itemIndex]["date"],
                            "in_stock": product["in_stock"],
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, _) {
                      return const Divider();
                    },
                    itemCount: productProvider.myProducts.length);
          }),
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
            return profileProvider.shouldShowLoader
                ? const LoaderScreen()
                : const SizedBox();
          })
        ],
      ),
    );
  }
}
