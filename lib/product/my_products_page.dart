import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<ProductProvider>(builder: (context, productProvider, _) {
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
                              image:
                                  AssetImage('assets/images/empty_basket.png')),
                          const SizedBox(
                            height: 20,
                          ),
                          TextWidget(
                            'Oops!',
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
                            padding: const EdgeInsets.symmetric(horizontal: 42),
                            child: ElevatedButtonWidget(
                              trailingIcon: Icons.add_rounded,
                              buttonName: 'Add Product'.toUpperCase(),
                              textStyle: FontWeight.w800,
                              borderRadius: 8,
                              innerPadding: 0.03,
                              onClick: () {
                                productProvider.changeScreen(1);
                                Navigator.of(context).pop();
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
                  return ProductCard(
                    type: CardType.myProducts,
                    productId: product["product_id"] ?? "XYZ",
                    productName: product["product_name"] ?? "Name",
                    productDescription: product["description"] ?? "Description",
                    imageURL: product["image"] ??
                        "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                    price:
                        double.tryParse(product["price"] ?? "00.00") ?? 00.00,
                    units: product["quantity"] ?? "1 unit",
                    location: product["place"] ?? "Visakhapatnam",
                    additionalInformation: {
                      "date": DateFormat('dd-MM-yyyy, hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch((int.tryParse(
                                      product["date_added"] ?? "0") ??
                                  0) *
                              1000)), //productProvider.orders[itemIndex]["date"],
                      "in_stock": product["in_stock"],
                    },
                  );
                },
                separatorBuilder: (context, _) {
                  return const Divider();
                },
                itemCount: productProvider.myProducts.length);
      }),
    );
  }
}
