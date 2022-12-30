import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi/nav_items/profile_provider.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';

import 'package:provider/provider.dart';

import '../product/product_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var carouselController = CarouselController();
  var currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height(context) {
        return constraints.maxHeight;
      }

      width(context) {
        return constraints.maxWidth;
      }

      appbar(BuildContext context, {List<Widget>? actions}) {
        return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: actions == null,
          iconTheme: IconThemeData(color: Colors.grey[900]),
          title: Image.asset(
            'assets/images/logo.png',
            height: height(context) * 0.06,
          ),
          actions: actions,
        );
      }

      return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
        return Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appbar(context, actions: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on_rounded),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget(
                                profileProvider.city,
                                size: 14,
                                isUnderlined: true,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.language_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_rounded),
                    )
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: profileProvider.carousel.length,
                      itemBuilder: (context, index, _) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  width: width(context) * 0.9,
                                  child: Image.asset(
                                    'assets/images/green_fresh.png',
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: width(context) * 0.9,
                                  height: double.infinity,
                                  color: Colors.black.withOpacity(0.47),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    TextWidget(
                                      profileProvider.carousel[index]["name"],
                                      weight: FontWeight.w500,
                                      color: Colors.white,
                                      size: height(context) * 0.03,
                                    ),
                                    TextWidget(
                                      profileProvider.carousel[index]
                                          ["description"],
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: height(context) * 0.02,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          height: height(context) * 0.2,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPos = index;
                            });
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3, 4, 5].map((url) {
                      int index = [1, 2, 3, 4, 5].indexOf(url);
                      return Container(
                        width: 5.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          'Cataloge',
                          weight: FontWeight.bold,
                          size: height(context) * 0.03,
                        ),
                        const TextWidget(
                          'Our handpicked finest category to your choice',
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: height(context) * 0.36,
                          child: ListView.separated(
                            separatorBuilder: (_, __) {
                              return SizedBox(
                                width: width(context) * 0.04,
                              );
                            },
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: width(context) * 0.35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        index % 3 == 0
                                            ? 'assets/images/vegetables.webp'
                                            : index % 3 == 1
                                                ? 'assets/images/fruit.png'
                                                : 'assets/images/green_fresh.png',
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF434343)
                                                  .withOpacity(0.39),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(16))),
                                          height: height(context) * 0.1,
                                          child: Center(
                                              child: TextWidget(
                                            (index % 3 == 0
                                                    ? 'Vegetables'
                                                    : index % 3 == 1
                                                        ? 'Fruits'
                                                        : 'Leafy Vegetables')
                                                .toUpperCase(),
                                            weight: FontWeight.bold,
                                            color: Colors.white,
                                            align: TextAlign.center,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.arrow_forward_rounded),
                            const SizedBox(
                              width: 12,
                            ),
                            TextWidget(
                              'View All'.toUpperCase(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xFFE2F2D5),
                    width: double.infinity,
                    height: height(context) * 0.3,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: width(context) *
                            0.3 *
                            (productProvider.freshFarms.length + 2),
                        height: height(context) * 0.3,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, top: 4, bottom: 4),
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        'Fresh from\nour farms',
                                        size: height(context) * 0.03,
                                        height: 1.2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: TextWidget(
                                          'Verified by Nandikrushi',
                                          size: height(context) * 0.015,
                                          height: 2,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_forward_rounded),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          TextWidget(
                                            'View All'.toUpperCase(),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider()
                              ],
                            ),
                            profileProvider.shouldShowLoader ||
                                    productProvider.freshFarms.isEmpty
                                ? SizedBox()
                                : Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children:
                                          productProvider.freshFarms.map((e1) {
                                        var e = productProvider.products
                                            .where(
                                              (element) =>
                                                  element["product_id"] ==
                                                  e1.toString(),
                                            )
                                            .first;
                                        return Row(
                                          children: [
                                            Column(
                                              children: [
                                                Image.network(
                                                  e['url']!,
                                                  height: 48,
                                                  width: 48,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextWidget(
                                                  e['name'],
                                                  weight: FontWeight.bold,
                                                  size: 18,
                                                ),
                                                const Spacer(),
                                                TextWidget(
                                                  e['units'],
                                                  weight: FontWeight.bold,
                                                  size: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextWidget(
                                                  'Rs. ${e['price']}',
                                                  weight: FontWeight.bold,
                                                  size: 18,
                                                ),
                                                const Spacer(),
                                                OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize: Size
                                                              .zero, // Set this
                                                          padding: EdgeInsets
                                                              .zero, // and this
                                                          side:
                                                              const BorderSide(
                                                                  width: 1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100))),
                                                  onPressed: () {
                                                    print("Add");

                                                    //TODO ADD
                                                    /*setState(() {
                                                      cartController
                                                              .addedDashboardProductQuantity[
                                                          index] = (cartController
                                                                      .addedDashboardProductQuantity[
                                                                  index] ??
                                                              0) +
                                                          1;
                                                      if (cartController.items
                                                              .where((element) =>
                                                                  element["name"] ==
                                                                  "Brinjal")
                                                              .length >
                                                          0) {
                                                        cartController.items.firstWhere(
                                                                (element) =>
                                                                    element["name"] ==
                                                                    "Brinjal")["quantity"] =
                                                            "${cartController.addedDashboardProductQuantity[index]}";

                                                        cartController.updateCart();
                                                      } else {
                                                        cartController.items.add({
                                                          'name': 'Brinjal',
                                                          'unit': '1 kg',
                                                          'price': '34',
                                                          'quantity':
                                                              '${cartController.addedDashboardProductQuantity[index]}',
                                                          'place':
                                                              'Paravada, Visakhapatnam.',
                                                          'url':
                                                              'https://resources.commerceup.io/?key=https%3A%2F%2Fprod-admin-images.s3.ap-south-1.amazonaws.com%2FpWVdUiFHtKGqyJxESltt%2Fproduct%2F30571001191.jpg&width=800&resourceKey=pWVdUiFHtKGqyJxESltt'
                                                        });

                                                        cartController.updateCart();
                                                      }
                                                    });*/
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 2),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.add,
                                                          size: 14,
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        TextWidget(
                                                            /* ((cartController.addedDashboardProductQuantity[
                                                                                    index] ??
                                                                                0) ==
                                                                            0
                                                                        ? "Add"
                                                                        : "Added")*/
                                                            "Add".toUpperCase(),
                                                            weight:
                                                                FontWeight.bold,
                                                            size: height(
                                                                    context) *
                                                                0.014),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                            const VerticalDivider(),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: const [
                        TextWidget(
                          'Do You Know?',
                          weight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        TextWidget(
                          'A2 Milk got its name from the rich amount of A2 beta-casein protein present in the milk. It is one of the most nutritional form of milk available today. The Gir Cow breed from India is specifically known for producing high quality A2 Milk.',
                          color: Colors.white,
                          flow: TextOverflow.visible,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: height(context) * 0.3,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: width(context) *
                            0.4 *
                            (productProvider.naturalFarms.length + 1.2),
                        height: height(context) * 0.3,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        'Natural Store',
                                        size: height(context) * 0.03,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextWidget(
                                        'Subscribe for daily needs\nat your door step',
                                        size: height(context) * 0.015,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextWidget(
                                        'Daily | Weekly | Monthly',
                                        size: height(context) * 0.015,
                                        color: Colors.grey.shade600,
                                      ),
                                      const Spacer(),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.arrow_forward_rounded),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            TextWidget(
                                              'View All'.toUpperCase(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider()
                              ],
                            ),
                            profileProvider.shouldShowLoader ||
                                    productProvider.freshFarms.isEmpty
                                ? SizedBox()
                                : Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: productProvider.naturalFarms
                                          .map((e1) {
                                        var e = productProvider.products
                                            .where(
                                              (element) =>
                                                  element["product_id"] ==
                                                  e1.toString(),
                                            )
                                            .first;
                                        return Row(
                                          children: [
                                            Column(
                                              children: [
                                                Image.network(
                                                  e['url']!,
                                                  height: 48,
                                                  width: 48,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextWidget(
                                                  e['name'],
                                                  weight: FontWeight.bold,
                                                  size: 18,
                                                ),
                                                TextWidget(
                                                  'Nandikrushi Organic Store',
                                                  size: height(context) * 0.012,
                                                  color: Colors.grey.shade600,
                                                ),
                                                const Spacer(),
                                                TextWidget(
                                                  e['units'],
                                                  weight: FontWeight.bold,
                                                  size: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextWidget(
                                                  'Rs. ${e['price']}',
                                                  weight: FontWeight.bold,
                                                  size: 18,
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                              tapTargetSize:
                                                                  MaterialTapTargetSize
                                                                      .shrinkWrap,
                                                              minimumSize: Size
                                                                  .zero, // Set this
                                                              padding: EdgeInsets
                                                                  .zero, // and this
                                                              side:
                                                                  const BorderSide(
                                                                      width: 1),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100))),
                                                      onPressed: () {
                                                        print("Add");
                                                        //productProvider.addToCart(e);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 2),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.add,
                                                              size: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            TextWidget(
                                                                "Add"
                                                                    .toUpperCase(),
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                size: height(
                                                                        context) *
                                                                    0.014),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    MaterialButton(
                                                      color: Colors.tealAccent,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minWidth: 0, // Set this
                                                      height: 16,
                                                      padding: EdgeInsets
                                                          .zero, // and this

                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      onPressed: () {},
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 2),
                                                        child: Icon(
                                                          Icons.cached_rounded,
                                                          size: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                            const VerticalDivider(),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: const Color(0xFFE2F2D5),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        SizedBox(
                            height: height(context) * 0.06,
                            child: Image.asset('assets/images/logo.png')),
                        SizedBox(
                          width: width(context),
                          child: Text(
                            'Nandikrushi',
                            style: TextStyle(
                              fontFamily: 'Samarkan',
                              fontSize: width(context) * 0.08,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[900],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: width(context),
                          child: TextWidget(
                            "an aggregator of natural farmers",
                            size: width(context) * 0.024,
                            weight: FontWeight.w600,
                            color: Colors.grey.shade800,
                            align: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: width(context),
                          child: TextWidget(
                            "v1.2.0+60",
                            size: width(context) * 0.024,
                            weight: FontWeight.w600,
                            color: Colors.grey.shade800,
                            align: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
    });
  }
}
