// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi/nav_items/profile_provider.dart';
import 'package:nandikrushi/product/order_successful.dart';
import 'package:nandikrushi/product/product_provider.dart';
import 'package:nandikrushi/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final String addressID;
  const ConfirmOrderScreen({Key? key, required this.addressID})
      : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

coupons(BuildContext context) {
  return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
          return Dialog(
            backgroundColor: ElevationOverlay.colorWithOverlay(
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.primary,
                3.0),
            insetPadding: const EdgeInsets.symmetric(horizontal: 42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      "Coupons",
                      weight: FontWeight.w900,
                      size: Theme.of(context).textTheme.titleMedium?.fontSize,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: productProvider.coupons.length,
                        itemBuilder: (context, index) {
                          dynamic list = productProvider.coupons[index];
                          return ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                              productProvider.appliedCoupon.isEmpty
                                  ? 0
                                  : productProvider.appliedCoupon == list
                                      ? 12
                                      : 0,
                            )),
                            tileColor: productProvider.appliedCoupon.isEmpty
                                ? null
                                : productProvider.appliedCoupon == list
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : null,
                            onTap: () async {
                              if (productProvider.appliedCoupon.isEmpty) {
                                productProvider.updateCoupon(list);
                              } else if (productProvider.appliedCoupon ==
                                  list) {
                                productProvider.updateCoupon({});
                              } else {
                                snackbar(context,
                                    "Only one coupon can be applied per order!");
                              }
                              Navigator.maybeOf(context)?.maybePop();
                            },
                            title: Text(
                              list["code"].toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            subtitle: TextWidget(
                              list["name"].toString(),
                              size: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              align: TextAlign.start,
                            ),
                            trailing: productProvider.appliedCoupon.isEmpty
                                ? Text(
                                    "Apply",
                                    style: Theme.of(context).textTheme.button,
                                  )
                                : productProvider.appliedCoupon == list
                                    ? Icon(
                                        Icons.bookmark_remove_rounded,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      )
                                    : null,
                          );
                        })
                  ]),
            ),
          );
        });
      });
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  var radioState = false;

  var selected;
  int deliverySlot = 0;

  @override
  Widget build(BuildContext context) {
    _displayDialog(BuildContext context) async {
      selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          NavigatorState navigatorState = Navigator.of(context);
          return SizedBox(
            width: 428,
            height: 428,
            child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, _) {
              return Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                log(productProvider.cart.toString());
                return SizedBox(
                  width: 428,
                  child: AlertDialog(
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      Container(
                        alignment: Alignment.center,
                        width: 428,
                        margin: EdgeInsets.all(8),
                        child: ElevatedButtonWidget(
                          onClick: () {
                            Navigator.pop(context);
                          },
                          height: 56,
                          bgColor: Colors.white,
                          buttonName: "Cancel".toUpperCase(),
                          textColor: Colors.grey[900],
                          textStyle: FontWeight.w600,
                          borderRadius: 12,
                          borderSideColor:
                              Theme.of(context).colorScheme.primary,
                          center: true,
                        ),
                      ),
                      Container(
                        width: 428,
                        margin: EdgeInsets.all(8),
                        child: ElevatedButtonWidget(
                          onClick: () async {
                            var placeOrderBody = {
                              "user_id": profileProvider.userIdForAddress,
                              "payment_method":
                                  radioState ? "" : "Cash On Delivery",
                              "payment_type":
                                  radioState ? "" : "Cash On Delivery",
                              "address_id": widget.addressID,
                              "coupon_code": "2222",
                              "time_slot": "1",
                              "schedule": DateFormat("yyyy-MM-dd")
                                  .format(DateTime.now()),
                              "orders": productProvider.cart
                                  .map((e) => {"cart_id": e["cart_id"]})
                                  .toList()
                            };
                            log(placeOrderBody.toString());
                            Navigator.of(context).pop();
                            if (!profileProvider.shouldShowLoader) {
                              profileProvider.showLoader();
                              var response = await post(
                                Uri.parse(
                                    "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/placeorder"),
                                body: jsonEncode(placeOrderBody),
                                headers: {
                                  "Content-Type": "application/json",
                                  "Accept": "application/json",
                                },
                              );
                              if (response == null) {
                                profileProvider.hideLoader();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OrderSuccessfulScreen(
                                          name: profileProvider.firstName,
                                          deliverySlot:
                                              "${DateFormat('dd EEE, MMM').format(
                                                    DateTime.now().add(
                                                      Duration(
                                                        days: deliverySlot ~/ 2,
                                                      ),
                                                    ),
                                                  ).toUpperCase()} ${deliverySlot % 2 == 0 ? '7 AM - 11 AM' : '11 AM - 3 PM'}",
                                          orderNumber: "XXXXXXXXXXX",
                                        )));
                                return;
                              }
                              log(response.statusCode.toString());
                              if (response.statusCode == 200) {
                                log(response.body.toString());
                                if (jsonDecode(response.body)["status"] ||
                                    jsonDecode(response.body)["status"]
                                        .toString()
                                        .contains("true")) {
                                  log(response.body);

                                  navigatorState.push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderSuccessfulScreen(
                                              name: profileProvider.firstName,
                                              deliverySlot:
                                                  "${DateFormat('EEE, dd MMM').format(
                                                        DateTime.now().add(
                                                          Duration(
                                                            days:
                                                                deliverySlot ~/
                                                                    2,
                                                          ),
                                                        ),
                                                      ).toUpperCase()} (${deliverySlot % 2 == 0 ? '7 AM - 11 AM' : '11 AM - 3 PM'})",
                                              orderNumber: "XXXXXXXXXXX",
                                            )),
                                  );
                                  profileProvider.hideLoader();
                                }
                              } else if (response.statusCode == 400) {
                                snackbar(context,
                                    "Undefined parameter when calling API");
                                profileProvider.hideLoader();
                                Navigator.of(context).pop();
                              } else if (response.statusCode == 404) {
                                snackbar(context, "API not found");
                                profileProvider.hideLoader();
                                Navigator.of(context).pop();
                              } else {
                                log("Error: ${response.statusCode}");
                                snackbar(context, "Failed to get data!");
                                profileProvider.hideLoader();
                                Navigator.of(context).pop();
                              }
                            } else {
                              snackbar(
                                  context, "Your request is being processed",
                                  isError: false);
                            }
                          },
                          height: 56,
                          bgColor: Theme.of(context).colorScheme.primary,
                          buttonName: "Continue".toUpperCase(),
                          borderRadius: 8,
                          textColor: Colors.white,
                          textStyle: FontWeight.w600,
                          center: true,
                        ),
                      ),
                    ],
                    content: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            'Order Total',
                          ),
                          TextWidget(
                            'Rs. ${(productProvider.cart.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                  (value, element) => value + element,
                                ) + 100).toStringAsFixed(2)}',
                            size: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            color: Theme.of(context).colorScheme.primary,
                            weight: FontWeight.w700,
                          ),
                          TextWidget(
                            'You have chosen to pay for this order ${radioState ? 'online' : 'on delivery'}',
                            flow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const TextWidget(
                            'Please CONFIRM to place the order.',
                          ),
                        ],
                      ),
                    ),
                    elevation: 10,
                  ),
                );
              });
            }),
          );
        },
      );

      if (selected != null) {
        setState(() {
          selected = selected;
        });
      }
    }

    return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
      return Consumer<ProductProvider>(builder: (context, productProvider, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                toolbarHeight: kToolbarHeight,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.shopping_basket_rounded,
                    )),
                title: TextWidget(
                  'Confirm Order',
                  size: Theme.of(context).textTheme.titleMedium?.fontSize,
                  weight: FontWeight.w700,
                ),
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeliverySlotChooser(
                        deliverySlot: deliverySlot,
                        setDeliverySlot: (_) {
                          setState(() {
                            deliverySlot = _;
                          });
                        },
                      ),
                      ElevatedButtonWidget(
                        onClick: () {
                          coupons(context);
                        },
                        height: 56,
                        buttonName: "Apply Coupon",
                        textStyle: FontWeight.w600,
                        trailingIcon: Icons.chevron_right_rounded,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: TextWidget(
                          'Order Summary',
                          weight: FontWeight.w800,
                          size:
                              Theme.of(context).textTheme.titleSmall?.fontSize,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  'Item Total',
                                  weight: FontWeight.w500,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                                TextWidget(
                                  'Rs. ${productProvider.cart.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (int.tryParse(e['quantity'] ?? "0") ?? 0)).reduce((value, element) => value + element)}',
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextWidget(
                                  '${productProvider.cart.map((e) => int.tryParse(e['quantity'] ?? "0") ?? 0).reduce((value, element) => value + element)} items',
                                  size: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.fontSize,
                                ),
                                const Icon(Icons.expand_more_rounded)
                              ],
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: productProvider.cart.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            productProvider.cart[index]['name'],
                                            weight: FontWeight.w500,
                                            size: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.fontSize,
                                          ),
                                          Opacity(
                                            opacity: 0.7,
                                            child: TextWidget(
                                              productProvider.cart[index]
                                                  ['unit'],
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.fontSize,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextWidget(
                                        "Rs. ${(double.tryParse(productProvider.cart[index]["price"] ?? "") ?? 0) * (int.tryParse(productProvider.cart[index]["quantity"] ?? "") ?? 0)}",
                                        size: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.fontSize,
                                      ),
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  'Delivery Charge',
                                  weight: FontWeight.w700,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                                TextWidget(
                                  'Rs. 100.00',
                                  weight: FontWeight.w700,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextWidget(
                              '!  Add items for Rs.${(4000 - (productProvider.cart.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                    (value, element) => value + element,
                                  ) + 100.00)).toStringAsFixed(2)} or more to avoid Delivery Charges',
                              color: Theme.of(context).colorScheme.error,
                              size: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              weight: FontWeight.bold,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  'Total'.toUpperCase(),
                                  weight: FontWeight.w800,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                                TextWidget(
                                  'Rs. ${(productProvider.cart.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                        (value, element) => value + element,
                                      ) + 100.00).toStringAsFixed(2)}',
                                  weight: FontWeight.w700,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Divider(),
                            TextWidget(
                              'Payment Method',
                              weight: FontWeight.w800,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                            ),
                            ListTile(
                              title: const Text('Pay Online'),
                              leading: Radio(
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  value: true,
                                  groupValue: radioState,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      radioState = value ?? true;
                                    });
                                  }),
                            ),
                            ListTile(
                              title: const Text('Pay on Delivery'),
                              leading: Radio(
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  value: false,
                                  groupValue: radioState,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      radioState = value ?? false;
                                    });
                                  }),
                            ),
                            ElevatedButtonWidget(
                              leadingIcon: Icons.arrow_forward_rounded,
                              buttonName:
                                  'PAY Rs. ${(productProvider.cart.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                        (value, element) => value + element,
                                      ) + 100.00).toStringAsFixed(0)} ON DELIVERY',
                              textStyle: FontWeight.w800,
                              borderRadius: 12,
                              innerPadding: 0.03,
                              onClick: () {
                                _displayDialog(context);
                              },
                            ),
                            const SizedBox(
                              height: 27,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            profileProvider.shouldShowLoader
                ? const LoaderScreen()
                : const SizedBox()
          ],
        );
      });
    });
  }
}

class DeliverySlotChooser extends StatefulWidget {
  final int deliverySlot;
  final Function(int) setDeliverySlot;
  const DeliverySlotChooser(
      {Key? key, required this.deliverySlot, required this.setDeliverySlot})
      : super(key: key);

  @override
  State<DeliverySlotChooser> createState() => _DeliverySlotChooserState();
}

class _DeliverySlotChooserState extends State<DeliverySlotChooser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Delivery Slot',
            weight: FontWeight.w800,
            size: Theme.of(context).textTheme.titleMedium?.fontSize,
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 8,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.setDeliverySlot(index);
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(
                        left: index != 0 ? 8 : 0, right: index != 7 ? 8 : 0),
                    padding: const EdgeInsets.all(8),
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: index == widget.deliverySlot
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: index == widget.deliverySlot
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextWidget(
                            DateFormat('EEE, MMM')
                                .format(
                                  DateTime.now().add(
                                    Duration(
                                      days: index ~/ 2,
                                    ),
                                  ),
                                )
                                .toUpperCase(),
                            color: index == widget.deliverySlot
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7)),
                        TextWidget(
                          DateTime.now()
                              .add(Duration(days: index ~/ 2))
                              .day
                              .toString(),
                          color: index == widget.deliverySlot
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                          size:
                              Theme.of(context).textTheme.titleSmall?.fontSize,
                          weight: FontWeight.w800,
                        ),
                        TextWidget(
                            index % 2 == 0 ? '7 AM - 11 AM' : '11 AM - 3 PM',
                            color: index == widget.deliverySlot
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7)),
                      ],
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
