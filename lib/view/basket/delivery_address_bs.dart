import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/basket/add_address.dart';
import 'package:nandikrushifarmer/view/basket/address_search.dart';
import 'package:nandikrushifarmer/view/basket/confirm_order.dart';
import 'package:nandikrushifarmer/view/product/product_details.dart';

Future orderPlacementFlowBS(BuildContext context, {int userInitialPage = 0}) {
  return showModalBottomSheet(
    context: context,
    elevation: 22,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      var pageController = PageController(
        initialPage: userInitialPage,
      );
      var items = [
        {
          'name': 'Tomato',
          'unit': '1 kg',
          'price': '50',
          'quantity': '10',
          'place': 'Paravada, Visakhapatnam.',
          'url':
              'https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg'
        },
        {
          'name': 'Foxtail Millet',
          'unit': '1 kg',
          'price': '140',
          'quantity': '25',
          'place': 'Paravada, Visakhapatnam.',
          'url':
              'https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg'
        }
      ];
      List<List<String>> addresses = [];

      return StatefulBuilder(
        builder: (context, setState) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: SizedBox(
              height: height(context) * 0.7,
              child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, pageIndex) {
                    return Column(
                      children: [
                        appBarWithTitle(context,
                            title: pageIndex == 0
                                ? 'Shopping Cart'
                                : 'Delivery Address',
                            prefix: pageIndex == 0
                                ? Icons.close_rounded
                                : Icons.arrow_back_rounded,
                            onPrefixClicked: () {
                          pageIndex == 0
                              ? Navigator.of(context).pop()
                              : userInitialPage == 1
                                  ? Navigator.of(context).pop()
                                  : pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                        },
                            subtitle: pageIndex == 0
                                ? '${items.map((e) => int.tryParse(e['quantity'] ?? "0") ?? 0).reduce((value, element) => value + element)} items'
                                : null,
                            toolbarHeight: kToolbarHeight +
                                (pageIndex == 0 ? height(context) * 0.03 : 0),
                            suffix: pageIndex == 1
                                ? InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddressSearchScreen(
                                            onSaveAddress: (list) {
                                              setState(() {
                                                log('Helo');
                                                addresses.add(list);
                                                Navigator.of(context).pop();
                                                log(addresses.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      margin: EdgeInsets.only(
                                          right: width(context) * 0.05,
                                          top: height(context) * 0.005),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_rounded,
                                            color: Colors.blue.shade700,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          TextWidget(
                                            text: 'Add',
                                            size: width(context) * 0.045,
                                            color: Colors.blue.shade700,
                                            weight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : null),
                        const Divider(),
                        Expanded(
                          child: pageIndex == 0
                              ? CartItems(
                                  items: items,
                                  onRemoveItem: (index) {
                                    setState(() {
                                      items[index]['quantity'] = ((int.tryParse(
                                                      items[index]
                                                              ['quantity'] ??
                                                          "0") ??
                                                  0) -
                                              1)
                                          .toString();
                                    });
                                  },
                                  onAddItem: (index) {
                                    setState(() {
                                      items[index]['quantity'] = ((int.tryParse(
                                                      items[index]
                                                              ['quantity'] ??
                                                          "0") ??
                                                  0) +
                                              1)
                                          .toString();
                                    });
                                  },
                                )
                              : DeliveryAddressesList(
                                  addresses: addresses,
                                  onAddAddress: (list) {
                                    setState(() {
                                      log('Helo');
                                      addresses.add(list);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  onDeleteAddress: (index) {
                                    setState(() {
                                      addresses.removeAt(index);
                                    });
                                  },
                                ),
                        ),
                        ElevatedButtonWidget(
                          borderRadius: 8,
                          onClick: () {
                            if (pageIndex == 0) {
                              pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      const ConfirmOrderScreen()),
                                ),
                              );
                            }
                          },
                          minWidth: width(context),
                          height: height(context) * 0.06,
                          // borderRadius: 16,
                          bgColor: Colors.grey.shade200,
                          textColor: Colors.grey.shade700,
                          textStyle: FontWeight.bold,
                          buttonName: pageIndex == 0
                              ? "Total: Rs. ${(items.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                    (value, element) => value + element,
                                  )).toStringAsFixed(2)}"
                              : " ",
                          textSize: width(context) * 0.04,
                          trailingIcon: Row(
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.grey.shade700,
                                size: width(context) * 0.045,
                              ),
                              SizedBox(
                                width: width(context) * 0.03,
                              ),
                              TextWidget(
                                text: (pageIndex == 0
                                        ? 'Select Address'
                                        : 'Confirm Order')
                                    .toUpperCase(),
                                size: width(context) * 0.04,
                                weight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          );
        },
      );
    },
  );
}

class CartItems extends StatelessWidget {
  const CartItems({
    Key? key,
    required this.items,
    required this.onRemoveItem,
    required this.onAddItem,
  }) : super(key: key);

  final List<Map<String, String>> items;
  final Function(int) onRemoveItem;
  final Function(int) onAddItem;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) {
        return const Divider();
      }),
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductDetails()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: SizedBox(
              height: height(context) * 0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: items[index]['name'],
                    weight: FontWeight.w800,
                    size: height(context) * 0.024,
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height(context) * 0.08,
                          width: height(context) * 0.08,
                          child: Image.network(
                            items[index]['url']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextWidget(
                                        text: "Rs.",
                                        size: height(context) * 0.019,
                                        weight: FontWeight.bold,
                                      ),
                                      TextWidget(
                                        text: "${items[index]['price']}",
                                        size: height(context) * 0.024,
                                        weight: FontWeight.w800,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                    text: items[index]['unit'],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 8,
                                      ),
                                      TextWidget(
                                        text: items[index]['place'],
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          padding:
                              EdgeInsets.only(bottom: height(context) * 0.012),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  side: const BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {
                                  onRemoveItem(index);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width(context) * 0.05,
                              ),
                              TextWidget(
                                  text: items[index]['quantity'],
                                  weight: FontWeight.bold,
                                  size: height(context) * 0.02),
                              SizedBox(
                                width: width(context) * 0.05,
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  side: const BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {
                                  onAddItem(index);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class DeliveryAddressesList extends StatelessWidget {
  const DeliveryAddressesList(
      {Key? key,
      required this.addresses,
      required this.onAddAddress,
      required this.onDeleteAddress})
      : super(key: key);
  final List<List<String>> addresses;
  final Function(int item) onDeleteAddress;
  final Function(List<String>) onAddAddress;
  @override
  Widget build(BuildContext context) {
    log('redrawn');
    log(addresses.toString());
    return Container(
      child: addresses.isEmpty
          ? Column(
              children: [
                const Image(
                    image: AssetImage('assets/png/delivery_address.png')),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                TextWidget(
                  text: 'No Addresses Available',
                  weight: FontWeight.w800,
                  size: height(context) * 0.024,
                  color: Colors.grey.shade800,
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),
                TextWidget(
                  text:
                      'Your selected city is Hyderabad. Please add an address by tapping below.',
                  weight: FontWeight.w600,
                  color: Colors.grey,
                  flow: TextOverflow.visible,
                  align: TextAlign.center,
                  size: height(context) * 0.02,
                ),
                SizedBox(
                  height: height(context) * 0.04,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: width(context) * 0.1),
                  child: ElevatedButtonWidget(
                    bgColor: SpotmiesTheme.primaryColor,
                    allRadius: true,
                    trailingIcon: const Icon(Icons.add_rounded),
                    buttonName: 'Add Address'.toUpperCase(),
                    textColor: Colors.white,
                    textSize: height(context) * 0.02,
                    textStyle: FontWeight.w800,
                    borderRadius: 8,
                    innerPadding: 0.03,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddressSearchScreen(
                            onSaveAddress: onAddAddress,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          : ListView.separated(
              separatorBuilder: (context, _) {
                return const Divider();
              },
              itemCount: addresses.length,
              itemBuilder: (context, item) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: width(context) * 0.06),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return index == 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height(context) * 0.01),
                                    child: TextWidget(
                                      text: addresses[item][index],
                                      weight: FontWeight.w800,
                                      size: height(context) * 0.03,
                                    ),
                                  )
                                : addressRow(index - 1, addresses[item][index],
                                    height(context) * 0.017);
                          }),
                          itemCount: addresses[item].length,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height(context) * 0.01),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_rounded),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height(context) * 0.01),
                        child: IconButton(
                          onPressed: () {
                            onDeleteAddress(item);
                          },
                          color: Colors.red.shade300,
                          icon: const Icon(Icons.delete_rounded),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

Widget addressRow(int index, String addres, double size) {
  var title = '';
  switch (index) {
    case 0:
      title = 'House/Flat No.';
      break;
    case 1:
      title = 'Landmark';
      break;
    case 2:
      title = 'Address';
      break;
    case 3:
      title = 'Pincode';
      break;
    case 4:
      title = 'Contact';
      break;
    case 5:
      title = 'A. Contact';
      break;
    default:
  }
  return Row(
    children: [
      TextWidget(
        text: '$title:',
        weight: FontWeight.bold,
        size: size,
      ),
      TextWidget(
        text: addres,
        size: size,
      )
    ],
  );
}
