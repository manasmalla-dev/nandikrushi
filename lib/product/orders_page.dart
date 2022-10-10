import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

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
              icon: Icon(
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
        return productProvider.orders.isEmpty
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
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 42),
                            child: ElevatedButtonWidget(
                              trailingIcon: Icons.add_rounded,
                              buttonName: 'Order Now'.toUpperCase(),
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
                  var product =
                      productProvider.orders[itemIndex]["products"][0];
                  return ProductCard(
                    type: CardType.orders,
                    productId: product["product_id"] ?? "XYZ",
                    productName: product["product_name"] ?? "Name",
                    productDescription: product["description"] ?? "Description",
                    imageURL: product["url"] ??
                        "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                    price:
                        double.tryParse(product["price"] ?? "00.00") ?? 00.00,
                    units:
                        "${product["quantity"]} ${product["units"]?.toString().replaceFirst("1", "") ?? " unit"}${(int.tryParse(product["quantity"]) ?? 1) > 1 ? "s" : ""}",
                    location: product["place"] ?? "Visakhapatnam",
                    poster: productProvider.orders[itemIndex]["customer_name"],
                    additionalInformation: {
                      "date": productProvider.orders[itemIndex]["date"],
                      "status": 0
                    },
                  );
                },
                separatorBuilder: (context, _) {
                  return Divider();
                },
                itemCount: productProvider.orders.length);
      }),
    );
  }
}
