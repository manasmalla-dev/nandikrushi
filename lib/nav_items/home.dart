import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:provider/provider.dart';

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
      List homeAseets = [
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
        {
          "title": "My Purchases",
          "sub_title": "Products from Farmer",
          "icon": "assets/images/wallet_home.png",
        },
        {
          "title": "Videos",
          "sub_title": "Request Restaurant Video",
          "icon": "assets/images/videos_home.png",
        },
      ];
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 32),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Nandikrushi",
                  style: TextStyle(
                      color: const Color(0xFF006838),
                      fontFamily: 'Samarkan',
                      fontSize: getProportionateHeight(32, widget.constraints)),
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
            children: List.generate(homeAseets.length, (index) {
              return InkWell(
                onTap: () {
                  // if (index == 1) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const AddProductScreen()));
                  // } else if (index == 0) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const MyProductsScreen()));
                  // } else if (index == 2) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const OrdersScreen()));
                  // } else if (index == 3) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const PurchasesScreen()));
                  // } else if (index == 4) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const VideosScreen()));
                  // }
                },
                child: Padding(
                  padding: EdgeInsets.all(
                      widget.constraints.maxWidth > 800 ? 18.0 : 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(0, 3),
                              blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Flexible(
                            child: Center(
                                child: Image.asset(homeAseets[index]['icon']))),
                        const SizedBox(
                          height: 24,
                        ),
                        TextWidget(
                          homeAseets[index]['title'],
                          size:
                              Theme.of(context).textTheme.titleLarge?.fontSize,
                          weight: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.fontWeight,
                        ),
                        TextWidget(
                          homeAseets[index]['sub_title'],
                          size: Theme.of(context).textTheme.bodySmall?.fontSize,
                          weight:
                              Theme.of(context).textTheme.bodySmall?.fontWeight,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ));
    });
  }
}
