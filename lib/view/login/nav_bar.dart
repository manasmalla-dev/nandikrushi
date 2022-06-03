import 'dart:convert';
import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/data_provider.dart';
import 'package:nandikrushifarmer/repo/api_methods.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/basket/basket.dart';
import 'package:nandikrushifarmer/view/home/home.dart';
import 'package:nandikrushifarmer/view/my_account/my_account.dart';
import 'package:nandikrushifarmer/view/search/search.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  List icons = [
    Icons.home_outlined,
    Icons.search_outlined,
    Icons.person_outline,
    Icons.shopping_basket_outlined,
  ];
  List filledIcons = [
    Icons.home,
    Icons.search,
    Icons.person,
    Icons.shopping_basket,
  ];

  List text = ['Home', 'Search', 'My account', 'Basket'];

  static List<Widget> widgetOptions = <Widget>[
    const Center(
      child: Home(),
    ),
    const Center(child: Search()),
    const Center(
      child: MyAccount(),
    ),
    const Center(
      child: Basket(),
    ),
  ];

  fetchData(context, DataProvider provider) async {
    var response = await Server().getMethodParams(
        "http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/sellerproduct/GetSellerproductdata");
    if (response.statusCode == 200) {
      var listItems = jsonDecode(response.body)["message"];
      print(listItems);
      provider.addOrders(listItems);
    } else if (response.statusCode == 400) {
      snackbar(context, "Undefined Parameter when calling API");
      log("Undefined Parameter");
    } else if (response.statusCode == 404) {
      snackbar(context, "API Not found");
      log("Not found");
    } else {
      snackbar(context, "Failed to get data!");
      log("failure");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, provider, _) {
      if (!provider.gotOrders) {
        fetchData(context, provider);
      }
      return Scaffold(
        body: Container(child: widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: SizedBox(
          height: width(context) * 0.163,
          child: AnimatedBottomNavigationBar.builder(
            elevation: 0,
            itemCount: icons.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? Colors.grey[900] : Colors.grey;

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Icon(
                            isActive ? filledIcons[index] : icons[index],
                            size: width(context) * 0.05,
                            color: color,
                          ),
                          SizedBox(
                            height: height(context) * 0.006,
                          ),
                          TextWidget(
                            text: text[index],
                            color: color,
                            size: width(context) * 0.03,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
            backgroundColor: Colors.white,
            activeIndex: _selectedIndex,
            splashColor: const Color.fromARGB(255, 255, 255, 255),
            splashSpeedInMilliseconds: 50,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            gapLocation: GapLocation.none,
            // leftCornerRadius: 32,
            // rightCornerRadius: 32,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      );
    });
  }
}
