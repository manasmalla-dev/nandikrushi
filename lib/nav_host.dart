import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/basket.dart';
import 'package:nandikrushi_farmer/nav_items/home.dart';
import 'package:nandikrushi_farmer/nav_items/my_account.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/nav_items/search.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi_farmer/reusable_widgets/snackbar.dart';
import 'package:provider/provider.dart';

class NandikrushiNavHost extends StatefulWidget {
  final String userId;

  const NandikrushiNavHost({Key? key, required this.userId}) : super(key: key);

  @override
  State<NandikrushiNavHost> createState() => _NandikrushiNavHostState();
}

class _NandikrushiNavHostState extends State<NandikrushiNavHost> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileProvider profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      ProductProvider productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      profileProvider.showLoader();
      profileProvider
          .getProfile(
              userID: widget.userId,
              showMessage: (_) {
                snackbar(context, _);
              })
          .then((value) {
        print("Getting next data");
        productProvider.getData(
            profileProvider: profileProvider,
            showMessage: (_) {
              snackbar(context, _);
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      return LayoutBuilder(builder: (context, constraints) {
        List<Widget> widgetOptions = <Widget>[
          Center(
            child: HomeScreen(
              constraints: constraints,
            ),
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
        return Stack(
          children: [
            constraints.maxWidth < 600
                ? Scaffold(
                    body: widgetOptions[productProvider.selectedIndex],
                    bottomNavigationBar: NavigationBar(
                      destinations: navItems.entries
                          .map((e) => NavigationDestination(
                              icon: Icon(
                                e.value[0],
                              ),
                              selectedIcon: Icon(
                                e.value[1],
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                              label: e.key))
                          .toList(),
                      selectedIndex: productProvider.selectedIndex,
                      onDestinationSelected: (index) {
                        productProvider.changeScreen(index);
                      },
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: NavigationRail(
                            groupAlignment: 0,
                            extended: constraints.maxWidth > 1200,
                            onDestinationSelected: (value) {
                              productProvider.changeScreen(value);
                            },
                            destinations: navItems.entries
                                .map((e) => NavigationRailDestination(
                                    icon: Icon(e.value[0]),
                                    selectedIcon: Icon(e.value[1]),
                                    label: Text(e.key)))
                                .toList(),
                            selectedIndex: productProvider.selectedIndex),
                      ),
                      Expanded(
                          child: widgetOptions[productProvider.selectedIndex])
                    ],
                  ),
            Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
              return profileProvider.shouldShowLoader
                  ? const LoaderScreen()
                  : const SizedBox();
            }),
          ],
        );
      });
    });
  }
}
