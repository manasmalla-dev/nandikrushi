import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/videos/videos.dart';
import 'package:nandikrushifarmer/view/order/orders.dart';
import 'package:nandikrushifarmer/view/order/purchases.dart';
import 'package:nandikrushifarmer/view/product/add_product.dart';
import 'package:nandikrushifarmer/view/product/my_products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List homeAseets = [
    {
      "title": "My Products",
      "sub_title": "View your Posted Products",
      "icon": "assets/png/myproduct_home.png",
    },
    {
      "title": "Add Product",
      "sub_title": "List your Product",
      "icon": "assets/png/addproduct_home.png",
    },
    {
      "title": "Orders",
      "sub_title": "View your order from Buyers",
      "icon": "assets/png/orders_home.png",
    },
    {
      "title": "My Purchases",
      "sub_title": "products from Farmer",
      "icon": "assets/png/wallet_home.png",
    },
    {
      "title": "Videos",
      "sub_title": "Restaurant Video request",
      "icon": "assets/png/videos_home.png",
    },
    {
      "title": "My Account",
      "sub_title": "Your Profile",
      "icon": "assets/png/account_home.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Nandikrushi",
            style: TextStyle(
                color: const Color(0xFF006838),
                fontFamily: 'Samarkan',
                fontSize: height(context) * 0.034),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            height: height(context) * 1.5,
            width: width(context),
            child: GridView.count(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              crossAxisCount: 2,
              childAspectRatio: (2.5 / 3),
              shrinkWrap: true,
              children: List.generate(6, (index) {
                return InkWell(
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
                              builder: (context) => const MyProductsScreen()));
                    } else if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrdersScreen()));
                    } else if (index == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PurchasesScreen()));
                    } else if (index == 4) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VideosScreen()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(homeAseets[index]['icon']),
                          SizedBox(
                            height: height(context) * 0.02,
                          ),
                          TextWidget(
                            text: homeAseets[index]['title'],
                            size: width(context) * 0.05,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: height(context) * 0.01,
                          ),
                          TextWidget(
                            text: homeAseets[index]['sub_title'],
                            size: width(context) * 0.025,
                            weight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )));
  }
}
