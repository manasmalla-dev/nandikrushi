import 'package:flutter/material.dart';
import 'package:nandikrushi/onboarding/login_provider.dart';
import 'package:nandikrushi/utils/size_config.dart';
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
      // List destinations = [
      //   {
      //     "title": "My Products",
      //     "sub_title": "View your Posted Products",
      //     "icon": "assets/images/myproduct_home.png",
      //   },
      //   {
      //     "title": loginProvider.isFarmer
      //         ? "Add Product"
      //         : loginProvider.userAppTheme.key.contains("Store")
      //             ? "Sell Grocery"
      //             : "Sell Food",
      //     "sub_title": "List your Product",
      //     "icon": "assets/images/addproduct_home.png",
      //   },
      //   {
      //     "title": "Orders",
      //     "sub_title": "View your Order from Buyers",
      //     "icon": "assets/images/orders_home.png",
      //   },
      // ];
      // destinations.add(
      //   {
      //     "title": "My Purchases",
      //     "sub_title": "Products from Farmer",
      //     "icon": "assets/images/wallet_home.png",
      //   },
      // );

      // destinations.add(
      //   {
      //     "title": "Videos",
      //     "sub_title": loginProvider.isFarmer
      //         ? "Recommendations for Farmers"
      //         : "Request Restaurant Video",
      //     "icon": "assets/images/videos_home.png",
      //   },
      // );
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
          body: Container());
    });
  }
}
