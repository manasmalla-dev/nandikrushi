import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi/nav_items/order_details_screen.dart';
import 'package:nandikrushi/product/product_card.dart';
import 'package:nandikrushi/product/product_provider.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class MyPurchasesScreen extends StatefulWidget {
  const MyPurchasesScreen({super.key});

  @override
  State<MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
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
          'Orders',
          size: Theme.of(context).textTheme.titleMedium?.fontSize,
          weight: FontWeight.w700,
        ),
      ),
      body: Consumer<ProductProvider>(builder: (context, productProvider, _) {
        return productProvider.myPurchases.isEmpty
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
                            opacity: 0.7,
                            child: TextWidget(
                              'Looks like you have not ordered anything yet',
                              flow: TextOverflow.visible,
                              align: TextAlign.center,
                              size: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 40,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 42),
                          //   child: ElevatedButtonWidget(
                          //     trailingIcon: Icons.add_rounded,
                          //     buttonName: 'Order Now'.toUpperCase(),
                          //     textStyle: FontWeight.w800,
                          //     borderRadius: 8,
                          //     innerPadding: 0.03,
                          //     onClick: () {
                          //       productProvider.changeScreen(1);
                          //       Navigator.of(context).pop();
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ])
            : ListView.separated(
                itemBuilder: (context, itemIndex) {
                  return InkWell(
                    onTap: () {
                      print("Hello");

                      print(productProvider.myPurchases[itemIndex]);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(
                                order: productProvider.myPurchases[itemIndex],
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(12)),
                      child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) {
                            return Divider();
                          },
                          itemCount: productProvider
                              .myPurchases[itemIndex]["products"].length,
                          itemBuilder: (context, productOrderIndex) {
                            var product = productProvider.myPurchases[itemIndex]
                                ["products"][productOrderIndex];
                            return ProductCard(
                              canTap: false,
                              type: CardType.myPurchases,
                              productId: product["product_id"] ?? "XYZ",
                              productName: product["product_name"] ?? "Name",
                              productDescription:
                                  product["description"] ?? "Description",
                              imageURL: product["url"] ??
                                  "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                              price: double.tryParse(
                                      product["price"] ?? "00.00") ??
                                  00.00,
                              units:
                                  "${product["quantity"]} ${product["units"]?.toString().replaceFirst("1", "") ?? " unit"}${(int.tryParse(product["quantity"]) ?? 1) > 1 ? "s" : ""}",
                              location: product["place"] ?? "Visakhapatnam",
                              poster: productProvider.myPurchases[itemIndex]
                                  ["store_name"],
                              additionalInformation: {
                                "date": DateFormat("EEE, MMM dd").format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        (int.tryParse(productProvider
                                                        .myPurchases[itemIndex]
                                                    ["date"]) ??
                                                0000000000) *
                                            1000)),
                                "status": 0,
                                "rating": (double.tryParse(
                                        product["rating"] ?? "0.0") ??
                                    0),
                              },
                            );
                          }),
                    ),
                  );
                },
                separatorBuilder: (context, _) {
                  return const Divider();
                },
                itemCount: productProvider.myPurchases.length);
      }),
    );
  }
}
