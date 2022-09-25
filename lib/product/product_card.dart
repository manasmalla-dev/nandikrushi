import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

enum CardType {
  myProducts,
  orders,
  myPurchases,
  product,
}

class ProductCard extends StatefulWidget {
  final CardType type;
  final String productName;
  final String? productDescription;
  final String imageURL;
  final double price;
  final String units;
  final String? poster;
  final String location;
  //final bool? isStockAvailable;
  const ProductCard(
      {Key? key,
      required this.type,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                widget.productDescription != null
                    ? TextWidget(widget.productDescription)
                    : SizedBox(),
                Row(
                  children: [
                    Image.network(
                      widget.imageURL,
                      height: 64,
                      width: 64,
                    ),
                    Column(
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
                            TextWidget(widget.location),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
