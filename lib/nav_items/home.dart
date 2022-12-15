import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/videos_screen.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/product/add_product.dart';
import 'package:nandikrushi_farmer/product/my_products_page.dart';
import 'package:nandikrushi_farmer/product/orders_page.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'my_purchases.dart';

class HomeScreen extends StatefulWidget {
  final BoxConstraints constraints;
  const HomeScreen({Key? key, required this.constraints}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      List destinations = [
        {
          "title": "My Products",
          "sub_title": "View your Posted Products",
          "icon": "assets/images/myproduct_home.png",
        },
        {
          "title": loginProvider.isFarmer
              ? "Add Product"
              : loginProvider.userAppTheme.key.contains("Store")
                  ? "Sell Grocery"
                  : "Sell Food",
          "sub_title": "List your Product",
          "icon": "assets/images/addproduct_home.png",
        },
        {
          "title": "Orders",
          "sub_title": "View your Order from Buyers",
          "icon": "assets/images/orders_home.png",
        },
      ];
      destinations.add(
        {
          "title": "My Purchases",
          "sub_title": "Products from Farmer",
          "icon": "assets/images/wallet_home.png",
        },
      );

      destinations.add(
        {
          "title": "Videos",
          "sub_title": loginProvider.isFarmer
              ? "Recommendations for Farmers"
              : "Request Restaurant Video",
          "icon": "assets/images/videos_home.png",
        },
      );
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 32),
              child: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Nandikrushi",
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 0.5
                                    : 1),
                        fontFamily: 'Samarkan',
                        fontSize:
                            getProportionateHeight(32, widget.constraints)),
                  ),
                ),
              ),
            ),
          ),
          body: GridView.count(
            padding: EdgeInsets.symmetric(
                horizontal: widget.constraints.maxWidth > 600 ? 32 : 10,
                vertical: 20),
            crossAxisCount: widget.constraints.maxWidth > 600 ? 3 : 2,
            childAspectRatio: widget.constraints.maxWidth > 600 ? 1 : (2.5 / 3),
            shrinkWrap: true,
            children: List.generate(destinations.length, (index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {
                    if (index == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddProductScreen()));
                    } else if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProductsPage()));
                    } else if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrdersPage()));
                    } else if (index == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyPurchasesScreen()));
                    } else if (index == 4) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VideosScreen()));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(
                        widget.constraints.maxWidth > 800 ? 18.0 : 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Flexible(
                              child: Center(
                                  child: Image.asset(
                                      destinations[index]['icon']))),
                          const SizedBox(
                            height: 24,
                          ),
                          TextWidget(
                            destinations[index]['title'],
                            size: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                            weight: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontWeight,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              destinations[index]['sub_title'],
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ));
    });
  }
}
