import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/basket.dart';
import 'package:nandikrushi_farmer/nav_items/my_account.dart';
import 'package:nandikrushi_farmer/nav_items/notification_screen.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/nav_items/videos_screen.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/product/add_product.dart';
import 'package:nandikrushi_farmer/product/my_products_page.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/material_you_clipper.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:nandikrushi_farmer/utils/youtube_util.dart';
import 'package:provider/provider.dart';

import '../product/orders_page.dart';

class HomeScreen extends StatefulWidget {
  final BoxConstraints constraints;

  const HomeScreen({Key? key, required this.constraints}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      var videoID = [
        "qOVebetilXY",
        "NGvwKanKdL8",
        "lwnO0yfHmNA",
        "EPP4G4B3Dkc",
        "5ONx1qQgIM4",
        "XUZ1CLIigN4",
        "HztmSwvBu2U",
        "fXEkPeSBr-Q",
        "Hp-lGxwPUnI",
        "gKqSayojRkg",
        "6CiQEfiZv9s",
        "h7rUI6NWtgk",
        "8FHgrv68cwY",
        "ItyAEbCIjCU",
        "oB70suAIF6A",
        "A_OAyYiya40",
        "6aZ3sV7a1Lo",
        "40hITd7mvXY",
        "jxfrZV1kkhM",
        "0RFumQ8Q8f8",
        "3RyjUwzXWTs",
        "-TfASLwVlUs",
      ];
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
      //
      // destinations.add(
      //   {
      //     "title": "Videos",
      //     "sub_title": loginProvider.isFarmer
      //         ? "Recommendations for Farmers"
      //         : "Request Restaurant Video",
      //     "icon": "assets/images/videos_home.png",
      //   },
      // );

      return SafeArea(
        bottom: false,
        top: false,
        child:
            Consumer<ProductProvider>(builder: (context, productProvider, _) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.only(top: 16.0),
            child: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddProductScreen()));
                },
                label: const Text("Add Product"),
                icon: const Icon(Icons.add_rounded),
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                surfaceTintColor: Theme.of(context).colorScheme.background,
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Column(
                  children: [
                    Text(
                      "Nandikrushi",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: "Samarkan",
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? 0.5
                                        : 1),
                              ),
                    ),
                    Text(
                      "truly food is medicine",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? 0.1
                                  : 0.55),
                          fontSize:
                              getProportionateHeight(11, widget.constraints), letterSpacing: 2.4),

                    ),
                  ],
                ),
                actions: [
                  Consumer<ProfileProvider>(
                      builder: (context, profileProvider, _) {
                    return IconButton(
                      iconSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                      },
                      icon: const Icon(Icons.notifications_on_outlined),
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                          Theme.of(context).brightness == Brightness.dark
                              ? 0.5
                              : 1 *
                                  (profileProvider.notifications.isNotEmpty
                                      ? 1
                                      : 0.5)),
                    );
                  }),
                  IconButton(
                    iconSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BasketScreen()));
                    },
                    icon: const Icon(Icons.shopping_basket_outlined),
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                        Theme.of(context).brightness == Brightness.dark
                            ? 0.5
                            : 1),
                  ),
                  SizedBox(width: 8,),
                  Consumer<ProfileProvider>(
                      builder: (context, profileProvider, _) {
                    return profileProvider.sellerImage.isNotEmpty
                        ? InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            const MyAccountScreen()));
                      },
                          child: Center(
                            child: ClipPath(
                              clipper: MaterialClipper(),
                      child: Image.network(
                                  profileProvider.sellerImage,
                                  height: (Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.fontSize ?? 20) + 16,
                                  width: (Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.fontSize ?? 20) + 16,
                            fit: BoxFit.cover,
                                ),
                            ),
                          ),
                        )
                        : IconButton(
                            iconSize: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontSize,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const MyAccountScreen()));
                            },
                            icon: const Icon(Icons.account_circle_outlined),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? 0.5
                                    : 1),
                          );
                  }),
                  SizedBox(width: 16,),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFieldWidget(
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                    onSubmitField: () {
                                      setState(() {});
                                    },
                                    textInputAction: TextInputAction.search,
                                    hint: "Search",
                                    controller: searchController,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.7)),
                                    shouldShowBorder: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    print(await FirebaseMessaging.instance
                                        .getToken());
                                    if (searchController
                                        .value.text.isNotEmpty) {
                                      setState(() {
                                        searchController.value =
                                            const TextEditingValue();
                                      });
                                    }
                                  },
                                  child: Icon(
                                      searchController.value.text.isNotEmpty
                                          ? Icons.highlight_remove_rounded
                                          : Icons.search_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      searchController.value.text.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Latest Around You",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const VideosScreen()));
                                        },
                                        child: const Text("View More")),
                                  ],
                                ),
                                const Opacity(
                                  opacity: 0.6,
                                  child: Text(
                                      "Catch up on the latest going around you"),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                    height: 110,
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: InkWell(
                                            onTap: () {
                                              var url =
                                                  "https://www.youtube.com/watch?v=${videoID[index]}";
                                              YoutubeUtil()
                                                  .launchYoutubeVideo(url);
                                            },
                                            child: SizedBox(
                                              width: 200,
                                              child: Stack(children: [
                                                Image.network(
                                                  "https://img.youtube.com/vi/${videoID[index]}/hqdefault.jpg",
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                ),
                                                Container(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.2),
                                                ),
                                                Center(
                                                  child: Icon(
                                                    Icons
                                                        .play_circle_outline_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.3),
                                                    size: 36,
                                                  ),
                                                ),
                                                const Center(
                                                  child: Icon(
                                                    Icons
                                                        .play_circle_fill_rounded,
                                                    color: Colors.white,
                                                    size: 32,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, _) {
                                        return const SizedBox(
                                          width: 8,
                                        );
                                      },
                                      itemCount: videoID.length,
                                      scrollDirection: Axis.horizontal,
                                    )),
                                productProvider.orders.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Upcoming Orders",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const Spacer(),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    OrdersPage(
                                                                      onBack:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    )));
                                                  },
                                                  child:
                                                      const Text("View More")),
                                            ],
                                          ),
                                          const Opacity(
                                            opacity: 0.6,
                                            child: Text(
                                                "Prepare the orders you need to deliver"),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ListView.separated(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (context, itemIndex) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: productProvider
                                                                          .orders[
                                                                      itemIndex]
                                                                  [
                                                                  "order_status"] ==
                                                              "1"
                                                          ? Colors
                                                              .amber.shade100
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .surfaceVariant,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            ListView.separated(
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                separatorBuilder:
                                                                    (_, __) {
                                                                  return const Divider();
                                                                },
                                                                itemCount: productProvider
                                                                    .orders[
                                                                        itemIndex]
                                                                        [
                                                                        "products"]
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        productOrderIndex) {
                                                                  var product =
                                                                      productProvider.orders[itemIndex]
                                                                              [
                                                                              "products"]
                                                                          [
                                                                          productOrderIndex];
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        ClipOval(
                                                                          child:
                                                                              Image.network(
                                                                            product["url"] ??
                                                                                "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                                                                            height:
                                                                                48,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              16,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              product["product_name"] ?? "Name",
                                                                              style: Theme.of(context).textTheme.titleMedium,
                                                                            ),
                                                                            Text(
                                                                              "${product["quantity"]} ${product["units"]?.toString().replaceFirst("1", "") ?? " unit"}${(int.tryParse(product["quantity"]) ?? 1) > 1 ? "s" : ""}",
                                                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: productProvider.orders[itemIndex]["order_status"] == "1" ? Colors.orange.shade900.withOpacity(0.6) : Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                      ),
                                                      Transform.rotate(
                                                        angle: pi / 2,
                                                        child: Text(
                                                          productProvider.orders[
                                                                          itemIndex]
                                                                      [
                                                                      "order_status"] ==
                                                                  "1"
                                                              ? "Pending"
                                                                  .toUpperCase()
                                                              : productProvider
                                                                  .orders[
                                                                      itemIndex]
                                                                      [
                                                                      "order_status"]
                                                                  .toString()
                                                                  .toUpperCase(),
                                                          style: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: productProvider.orders[itemIndex]
                                                                              [
                                                                              "order_status"] ==
                                                                          "1"
                                                                      ? Colors
                                                                          .amber
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.6)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (context, _) {
                                                return const SizedBox(
                                                  height: 16,
                                                );
                                              },
                                              itemCount: productProvider
                                                          .orders.length >
                                                      2
                                                  ? 2
                                                  : productProvider
                                                      .orders.length),
                                        ],
                                      )
                                    : const SizedBox(),
                                productProvider.myProducts.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "My Products",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const Spacer(),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const MyProductsPage()));
                                                  },
                                                  child:
                                                      const Text("View More")),
                                            ],
                                          ),
                                          const Opacity(
                                            opacity: 0.6,
                                            child: Text(
                                                "A wide range of the products you're selling"),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          SizedBox(
                                            height: 80,
                                            child: ListView.separated(
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, itemIndex) {
                                                  var product = productProvider
                                                      .myProducts[itemIndex];
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.green.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Image.network(
                                                          product["image"] ??
                                                              "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                                                          height: 48,
                                                          width: 48,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              product["product_name"] ??
                                                                  "Name",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                            ),
                                                            Text(
                                                                "Rs. ${double.tryParse(product["price"] ?? "00.00")?.toStringAsFixed(2) ?? 00.00}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall
                                                                    ?.copyWith(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade900)),
                                                            Opacity(
                                                              opacity: 0.5,
                                                              child: Text(
                                                                "${product["quantity"]} ${product["units"]?.toString().replaceFirst("1", "") ?? " unit"}${(int.tryParse(product["quantity"] ?? "") ?? 1) > 1 ? "s" : ""}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall
                                                                    ?.copyWith(
                                                                        color: (double.tryParse(product["quantity"] ?? "") ?? 0.0) <
                                                                                2.0
                                                                            ? Theme.of(context).colorScheme.error
                                                                            : null),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (context, _) {
                                                  return SizedBox(
                                                    width: 12,
                                                  );
                                                },
                                                itemCount: productProvider
                                                    .myProducts.length),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                productProvider.myPurchases.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Recent Purchases",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const Spacer(),
                                              TextButton(
                                                  onPressed: () {},
                                                  child:
                                                      const Text("View More")),
                                            ],
                                          ),
                                          const Opacity(
                                            opacity: 0.6,
                                            child: Text(
                                                "Hope you loved the products you bought"),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ListView.separated(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (context, itemIndex) {
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surfaceVariant,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: ListView.separated(
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      separatorBuilder:
                                                          (_, __) {
                                                        return const Divider();
                                                      },
                                                      itemCount: productProvider
                                                          .myPurchases[
                                                              itemIndex]
                                                              ["products"]
                                                          .length,
                                                      itemBuilder: (context,
                                                          productOrderIndex) {
                                                        var product = productProvider
                                                                        .myPurchases[
                                                                    itemIndex]
                                                                ["products"]
                                                            [productOrderIndex];
                                                        return Row(
                                                          children: [
                                                            Image.network(
                                                              product["url"] ??
                                                                  "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                                                              height: 48,
                                                              width: 48,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  product["product_name"] ??
                                                                      "Name",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleMedium,
                                                                ),
                                                                Text(
                                                                  "${product["quantity"]} ${product["units"]?.toString().replaceFirst("1", "") ?? " unit"}${(int.tryParse(product["quantity"]) ?? 1) > 1 ? "s" : ""}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                );
                                              },
                                              separatorBuilder: (context, _) {
                                                return const Divider();
                                              },
                                              itemCount: productProvider
                                                          .myPurchases.length >
                                                      2
                                                  ? 2
                                                  : productProvider
                                                      .myPurchases.length),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          //TODO: Implement the search functionality
                          : Column(
                              children: [
                                Image.asset("assets/images/ic_searching.png"),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "Searching",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text(
                                  "Looking over our humongous database\nof products and orders...",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              // body: GridView.count(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: widget.constraints.maxWidth > 600 ? 32 : 10,
              //       vertical: 20),
              //   crossAxisCount: widget.constraints.maxWidth > 600 ? 3 : 2,
              //   childAspectRatio: widget.constraints.maxWidth > 600 ? 1 : (2.5 / 3),
              //   shrinkWrap: true,
              //   children: List.generate(destinations.length, (index) {
              //     return ClipRRect(
              //       borderRadius: BorderRadius.circular(15),
              //       child: InkWell(
              //         onTap: () {
              //           if (index == 1) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const AddProductScreen()));
              //           } else if (index == 0) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const MyProductsPage()));
              //           } else if (index == 2) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const OrdersPage()));
              //           } else if (index == 3) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const MyPurchasesScreen()));
              //           } else if (index == 4) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const VideosScreen()));
              //           }
              //         },
              //         child: Padding(
              //           padding: EdgeInsets.all(
              //               widget.constraints.maxWidth > 800 ? 18.0 : 10),
              //           child: Container(
              //             decoration: BoxDecoration(
              //                 color: Theme.of(context).colorScheme.surfaceVariant,
              //                 borderRadius: BorderRadius.circular(15)),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 const SizedBox(
              //                   height: 32,
              //                 ),
              //                 Flexible(
              //                     child: Center(
              //                         child: Image.asset(
              //                             destinations[index]['icon']))),
              //                 const SizedBox(
              //                   height: 24,
              //                 ),
              //                 TextWidget(
              //                   destinations[index]['title'],
              //                   size: Theme.of(context)
              //                       .textTheme
              //                       .titleLarge
              //                       ?.fontSize,
              //                   weight: Theme.of(context)
              //                       .textTheme
              //                       .titleLarge
              //                       ?.fontWeight,
              //                 ),
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(horizontal: 16.0),
              //                   child: Text(
              //                     destinations[index]['sub_title'],
              //                     style: Theme.of(context).textTheme.bodySmall,
              //                     textAlign: TextAlign.center,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 32,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   }),
              // ));
            ),
          );
        }),
      );
    });
  }
}
