import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/basket.dart';
import 'package:nandikrushi_farmer/nav_items/home.dart';
import 'package:nandikrushi_farmer/nav_items/my_account.dart';
import 'package:nandikrushi_farmer/nav_items/search.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

class NandikrushiNavHost extends StatefulWidget {
  final String userId;
  final String customerId;
  const NandikrushiNavHost(
      {Key? key, required this.userId, required this.customerId})
      : super(key: key);

  @override
  State<NandikrushiNavHost> createState() => _NandikrushiNavHostState();
}

class _NandikrushiNavHostState extends State<NandikrushiNavHost> {
  static List<Widget> widgetOptions = <Widget>[
    const Center(
      child: HomeScreen(),
    ),
    const Center(child: SearchScreen()),
    const Center(
      child: MyAccountScreen(),
    ),
    const Center(
      child: BasketScreen(),
    ),
  ];
  Map<String, List<IconData>> navItems = {
    'Home': [
      Icons.home_outlined,
      Icons.home,
    ],
    'Search': [
      Icons.search_outlined,
      Icons.search,
    ],
    'My account': [
      Icons.person_outline,
      Icons.person,
    ],
    'Basket': [
      Icons.shopping_basket_outlined,
      Icons.shopping_basket,
    ]
  };
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: navItems.entries
            .map((e) => BottomNavigationBarItem(
                icon: Icon(e.value[0]),
                activeIcon: Icon(e.value[1]),
                label: e.key))
            .toList(),
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
