
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/my_account.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/product/address_bottom_sheet.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
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
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (context, setSheetState) {
                          return Container(
                            height: 600,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: productProvider.cart.isNotEmpty
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        'Basket',
                                        size: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.fontSize,
                                        color: Colors.grey[900],
                                        weight: FontWeight.w700,
                                      ),
                                      productProvider.cart.isNotEmpty
                                          ? TextWidget(
                                              '${productProvider.cart.length} items',
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.fontSize,
                                              color: Colors.grey[700],
                                              weight: FontWeight.w500,
                                            )
                                          : const SizedBox(),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListView.separated(
                                                separatorBuilder:
                                                    ((context, index) {
                                                  return const Divider();
                                                }),
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount:
                                                    productProvider.cart.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: ((context, index) {
                                                  return ProductCard(
                                                      type: CardType.product,
                                                      productId: productProvider
                                                                  .cart[index]
                                                              ["product_id"] ??
                                                          "",
                                                      productName:
                                                          productProvider.cart[index]
                                                                  ["name"] ??
                                                              "",
                                                      productDescription: "",
                                                      imageURL: productProvider
                                                                  .cart[index]
                                                              ["url"] ??
                                                          "",
                                                      price: double.tryParse(productProvider.cart[index]["price"] ?? "") ??
                                                          0.0,
                                                      units: productProvider
                                                                  .cart[index]
                                                              ["unit"] ??
                                                          "",
                                                      location: productProvider.cart[index]["place"] ?? "");
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                'Total'.toUpperCase(),
                                                weight: FontWeight.w600,
                                                size: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontSize,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              TextWidget(
                                                'Rs. ${(productProvider.cart.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                                      (value, element) =>
                                                          value + element,
                                                    ) + 100.00).toStringAsFixed(2)}',
                                                weight: FontWeight.w700,
                                                size: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.fontSize,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16,
                                                  left: 24,
                                                  right: 24),
                                              child: ElevatedButtonWidget(
                                                iconColor: Colors.grey.shade700,
                                                borderRadius: 8,
                                                onClick: () {
                                                  showAddressesBottomSheet(
                                                      context,
                                                      profileProvider,
                                                      Theme.of(context));
                                                },
                                                height: 54,
                                                // borderRadius: 16,
                                                bgColor: Colors.grey.shade200,
                                                textColor: Colors.grey.shade700,
                                                textStyle: FontWeight.bold,
                                                buttonName: "Select Address"
                                                    .toUpperCase(),
                                                trailingIcon:
                                                    Icons.arrow_forward,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
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
                                            'Basket Is Empty',
                                            weight: FontWeight.w800,
                                            size: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.fontSize,
                                            color: Colors.grey.shade800,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextWidget(
                                            'Looks like you have no items in your shopping basket',
                                            weight: FontWeight.w600,
                                            color: Colors.grey,
                                            flow: TextOverflow.visible,
                                            align: TextAlign.center,
                                            size: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.fontSize,
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 42),
                                            child: ElevatedButtonWidget(
                                              bgColor: Theme.of(context)
                                                  .primaryColor,
                                              trailingIcon: Icons.add_rounded,
                                              buttonName:
                                                  'Shop Items'.toUpperCase(),
                                              textColor: Colors.white,
                                              textStyle: FontWeight.w800,
                                              borderRadius: 8,
                                              innerPadding: 0.03,
                                              onClick: () {
                                                productProvider.changeScreen(1);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          );
                        });
                      });
                },
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
                                ? OutlinedButton(
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
                                      productProvider.modifyProductToCart(
                                          context: context,
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
                                            Icons.edit,
                                            size: 14,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          TextWidget("Modify".toUpperCase(),
                                              weight: FontWeight.bold,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  ?.fontSize),
                                        ],
                                      ),
                                    ),
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
                                          context: context,
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
