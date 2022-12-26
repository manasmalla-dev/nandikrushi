import 'package:flutter/material.dart';
import 'package:nandikrushi/nav_items/my_account.dart';
import 'package:nandikrushi/nav_items/profile_provider.dart';
import 'package:nandikrushi/product/product_page.dart';
import 'package:nandikrushi/product/product_provider.dart';
import 'package:nandikrushi/reusable_widgets/rating_widget.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';
import 'package:nandikrushi/utils/login_utils.dart';

import 'package:provider/provider.dart';

enum CardType {
  myProducts,
  orders,
  myPurchases,
  product,
}

class ProductCard extends StatefulWidget {
  final CardType type;
  final String productId;
  final String productName;
  final String? productDescription;
  final String imageURL;
  final double price;
  final String units;
  final String? poster;
  final String location;
  final bool includeHorizontalPadding;
  final Map<String, dynamic> additionalInformation;
  //final bool? isStockAvailable;
  ///[poster] - If its is product posted by farmer, then his details, or else the details of the person who gave order
  const ProductCard(
      {Key? key,
      required this.type,
      required this.productId,
      required this.productName,
      this.productDescription,
      required this.imageURL,
      required this.price,
      required this.units,
      this.poster,
      required this.location,
      this.includeHorizontalPadding = true,
      this.additionalInformation = const {}})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ProductProvider productProvider = Provider.of(context, listen: false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  productDetails: productProvider.products
                      .where((e) => e["product_id"] == widget.productId)
                      .first,
                )));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.includeHorizontalPadding ? 16 : 0, vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  widget.productDescription != null
                      ? SizedBox(
                          width: double.infinity,
                          child: TextWidget(
                            widget.productDescription,
                            flow: TextOverflow.ellipsis,
                          ),
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      Image.network(
                        widget.imageURL,
                        height: 64,
                        width: 64,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget("Rs. ${widget.price}"),
                            TextWidget(widget.units),
                            widget.poster != null
                                ? TextWidget(capitalize(
                                    widget.poster?.toLowerCase() ?? "User"))
                                : const SizedBox(),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded),
                                Expanded(
                                  child: TextWidget(
                                    widget.location,
                                    size: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
              return Flexible(
                child: Column(
                  children: widget.type == CardType.product
                      ? [
                          //A product card for search, and suggestions page and basket
                          Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            return IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  productProvider.cart
                                          .where((e) =>
                                              e["product_id"] ==
                                              widget.productId)
                                          .isNotEmpty
                                      ? OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              minimumSize:
                                                  Size.zero, // Set this
                                              padding: const EdgeInsets.all(
                                                  4), // and this
                                              side: BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          onPressed: () {
                                            productProvider.modifyProductToCart(
                                                context: context,
                                                productID: widget.productId,
                                                onSuccessful: () => null,
                                                showMessage: (_) {
                                                  snackbar(context, _);
                                                },
                                                profileProvider:
                                                    profileProvider);
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
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                TextWidget(
                                                    "Modify".toUpperCase(),
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
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              minimumSize:
                                                  Size.zero, // Set this
                                              padding: const EdgeInsets.all(
                                                  4), // and this
                                              side: BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          onPressed: () {
                                            productProvider.addProductToCart(
                                                context: context,
                                                productID: widget.productId,
                                                onSuccessful: () => null,
                                                showMessage: (_) {
                                                  snackbar(context, _);
                                                },
                                                profileProvider:
                                                    profileProvider);
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
                                    height: 12,
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: Size.zero, // Set this
                                        padding:
                                            const EdgeInsets.all(4), // and this
                                        side: BorderSide(
                                          width: 1,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
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
                                                  Text(
                                                    "Contact Us",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
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
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                          ),
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
                                                              primary: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              onPrimary: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary),
                                                          onPressed: () async {
                                                            dialCall();
                                                          },
                                                          child: const Text(
                                                              "Phone"),
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ]
                      : widget.type == CardType.myProducts
                          ? [
                              //A product card for my products page
                              Text(
                                  'Posted on: ${widget.additionalInformation["date"]}'),
                              const SizedBox(height: 8),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: Size.zero, // Set this
                                    padding:
                                        const EdgeInsets.all(4), // and this
                                    side: BorderSide(
                                      width: 1,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: TextWidget(
                                    (widget.additionalInformation["in_stock"]
                                                    .toString() ==
                                                "1"
                                            ? "In Stock"
                                            : "Out of Stock")
                                        .toUpperCase(),
                                    size: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.fontSize,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]
                          : widget.type == CardType.myPurchases
                              ? [
                                  Text(
                                      'Order placed on: ${widget.additionalInformation["date"]}'),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: FixedRatingStar(
                                            value: widget.additionalInformation[
                                                        "rating"] <
                                                    0.5
                                                ? 0
                                                : widget.additionalInformation[
                                                            "rating"] ==
                                                        0.5
                                                    ? 0.5
                                                    : 1),
                                      ),
                                      Flexible(
                                        child: FixedRatingStar(
                                            value: widget.additionalInformation[
                                                        "rating"] <
                                                    1.5
                                                ? 0
                                                : widget.additionalInformation[
                                                            "rating"] ==
                                                        1.5
                                                    ? 0.5
                                                    : 1),
                                      ),
                                      Flexible(
                                        child: FixedRatingStar(
                                            value: widget.additionalInformation[
                                                        "rating"] <
                                                    2.5
                                                ? 0
                                                : widget.additionalInformation[
                                                            "rating"] ==
                                                        2.5
                                                    ? 0.5
                                                    : 1),
                                      ),
                                      Flexible(
                                        child: FixedRatingStar(
                                            value: widget.additionalInformation[
                                                        "rating"] <
                                                    3.5
                                                ? 0
                                                : widget.additionalInformation[
                                                            "rating"] ==
                                                        3.5
                                                    ? 0.5
                                                    : 1),
                                      ),
                                      Flexible(
                                        child: FixedRatingStar(
                                            value: widget.additionalInformation[
                                                        "rating"] <
                                                    4.5
                                                ? 0
                                                : widget.additionalInformation[
                                                            "rating"] ==
                                                        4.5
                                                    ? 0.5
                                                    : 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  TextWidget(
                                    "Buy Again".toString().toUpperCase(),
                                    size: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.fontSize,
                                    weight: FontWeight.bold,
                                  ),
                                  //A product card for my purchases page
                                ]
                              : [
                                  Text(
                                      'Delivery order by: ${widget.additionalInformation["date"]}'),
                                  const SizedBox(height: 8),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: Size.zero, // Set this
                                        padding:
                                            const EdgeInsets.all(4), // and this
                                        side: BorderSide(
                                          width: 1,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
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
                                                  Text(
                                                    "Contact Us",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
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
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                          ),
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
                                                              primary: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              onPrimary: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary),
                                                          onPressed: () async {
                                                            dialCall();
                                                          },
                                                          child: const Text(
                                                              "Phone"),
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
                                      ),
                                    ),
                                  ),
                                  TextWidget(
                                    widget.additionalInformation["status"] == 0
                                        ? "Order Accepted".toUpperCase()
                                        : "Order Cancelled".toUpperCase(),
                                    size: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.fontSize,
                                    weight: FontWeight.bold,
                                  ),
                                  //A product card for orders page
                                ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
