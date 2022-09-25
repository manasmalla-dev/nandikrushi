import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
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
                        alignment: Alignment.center,
                        child: Image.network(
                            'https://resources.commerceup.io/?key=https%3A%2F%2Fprod-admin-images.s3.ap-south-1.amazonaws.com%2FpWVdUiFHtKGqyJxESltt%2Fproduct%2F30571001191.jpg&width=800&resourceKey=pWVdUiFHtKGqyJxESltt'),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Brinjal',
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
                        'Vegetables',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const TextWidget(
                        '1 Kg',
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
                            "34",
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
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero, // Set this
                                          padding: const EdgeInsets.all(
                                              4), // and this
                                          side: const BorderSide(width: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {
                                        productProvider.removeProductFromCart(
                                            productID: widget.productDetails[
                                                    "product_id"] ??
                                                "",
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
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero, // Set this
                                          padding: const EdgeInsets.all(
                                              4), // and this
                                          side: const BorderSide(width: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {
                                        productProvider.addProductToCart(
                                            productID: widget.productDetails[
                                                    "product_id"] ??
                                                "",
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
                                        productID: widget
                                                .productDetails["product_id"] ??
                                            "",
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
                            width: 12,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero, // Set this
                                padding: const EdgeInsets.all(4), // and this
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
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
                      const TextWidget(
                          'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
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
                      const TextWidget(
                        'Location : Paravada, Visakhapatnam. ',
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
                                          .categorizedProducts["Fruits"]?[index]
                                      ["url"] ??
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
  }
}
