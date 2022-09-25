import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/product/product_page.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
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
      required this.location})
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      : SizedBox(),
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
                                ? TextWidget(widget.poster)
                                : SizedBox(),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded),
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
            Flexible(
              child: Column(
                children: widget.type == CardType.product
                    ? [
                        //A product card for search, and suggestions page and basket
                        Consumer<ProductProvider>(
                            builder: (context, productProvider, _) {
                          return productProvider.cart
                                  .where((e) =>
                                      e["product_id"] == widget.productId)
                                  .isNotEmpty
                              ? Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding:
                                                EdgeInsets.all(4), // and this
                                            side: const BorderSide(width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {
                                          productProvider.removeProductFromCart(
                                              productID: widget.productId,
                                              onSuccessful: () => null);
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
                                      Text(
                                        productProvider.cart
                                                .where((e) =>
                                                    e["product_id"] ==
                                                    widget.productId)
                                                .first["quantity"] ??
                                            "0",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding:
                                                EdgeInsets.all(4), // and this
                                            side: const BorderSide(width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {
                                          productProvider.addProductToCart(
                                              productID: widget.productId,
                                              onSuccessful: () => null);
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
                                ])
                              : IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding:
                                                EdgeInsets.all(4), // and this
                                            side: const BorderSide(width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {
                                          productProvider.addProductToCart(
                                              productID: widget.productId,
                                              onSuccessful: () => null);
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
                                        height: 12,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding:
                                                EdgeInsets.all(4), // and this
                                            side: BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {},
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                          ]
                        : widget.type == CardType.myPurchases
                            ? [
                                //A product card for my purchases page
                              ]
                            : [
                                //A product card for orders page
                              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
