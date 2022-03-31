import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/view/basket/basket.dart';
import 'package:nandikrushi/view/dashboard/dashboard.dart';
import 'package:nandikrushi/view/my_account/my_account.dart';
import 'package:nandikrushi/view/search/search.dart';

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
    const Center(child: Dashboard()),
    const Center(child: Search()),
    const Center(
      child: MyAccount(),
    ),
    const Center(
      child: Basket(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
  }
}
