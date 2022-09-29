import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi_farmer/product/order_successful.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

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
            backgroundColor: const Color(0xFF07263A),
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
                      color: const Color(0xFFDCB666),
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
                            onTap: () async {
                              var body = {
                                "_id": list["coupon_id"].toString(),
                                "code": list["code"].toString(),
                                "name": list["name"].toString(),
                                "discount": list["discount"].toString(),
                              };
                              /* await productProvider.updateCoupon(body, () {
                                Navigator.maybeOf(context)?.maybePop();
                              }, () {
                                snackbar(context, "Something went wrong");*/

                              Navigator.maybeOf(context)?.maybePop();
                              //});
                              // cart.calculateTotal();
                              // list["discountType"] == "percentage"
                              //     ? cart.applyPerDiscount(
                              //         list["discount"], cartStatus)
                              //     : cart.applyAmtDiscount(
                              //         list["discount"], cartStatus);
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
                            trailing: Text(
                              "Apply",
                              style: Theme.of(context).textTheme.button,
                            ),
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

  // ignore: prefer_typing_uninitialized_variables
  var selected;

  @override
  Widget build(BuildContext context) {
    _displayDialog(BuildContext context) async {
      selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
            return SizedBox(
              width: 428,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  ElevatedButtonWidget(
                    onClick: () {
                      Navigator.pop(context);
                    },
                    height: 56,
                    bgColor: Colors.white,
                    buttonName: "Cancel".toUpperCase(),
                    textColor: Colors.grey[900],
                    textStyle: FontWeight.w600,
                    center: true,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OrderSuccessfulScreen()));
                    },
                    height: 56,
                    bgColor: Theme.of(context).primaryColor,
                    buttonName: "Continue".toUpperCase(),
                    borderRadius: 8,
                    textColor: Colors.white,
                    textStyle: FontWeight.w600,
                    center: true,
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
                        size: Theme.of(context).textTheme.titleMedium?.fontSize,
                        color: Theme.of(context).primaryColor,
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
        },
      );

      if (selected != null) {
        setState(() {
          selected = selected;
        });
      }
    }

    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.shopping_basket_rounded,
                color: Colors.grey[900],
              )),
          title: TextWidget(
            'Confirm Order',
            size: Theme.of(context).textTheme.titleMedium?.fontSize,
            color: Colors.grey[900],
            weight: FontWeight.w700,
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DeliverySlotChooser(),
                ElevatedButtonWidget(
                  onClick: () {
                    coupons(context);
                  },
                  height: 56,
                  bgColor: Theme.of(context).primaryColor,
                  buttonName: "Apply Coupon",
                  textColor: Colors.white,
                  textStyle: FontWeight.w600,
                  trailingIcon: Icons.chevron_right_rounded,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: TextWidget(
                    'Order Summary',
                    weight: FontWeight.w800,
                    size: Theme.of(context).textTheme.titleSmall?.fontSize,
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
                            'Rs. ${productProvider.cart.map((e) => (int.tryParse(e['price'] ?? "0") ?? 0) * (int.tryParse(e['quantity'] ?? "0") ?? 0)).reduce((value, element) => value + element)}',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      productProvider.cart[index]['name'],
                                      weight: FontWeight.w500,
                                      size: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.fontSize,
                                    ),
                                    TextWidget(
                                      productProvider.cart[index]['unit'],
                                      size: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.fontSize,
                                    ),
                                  ],
                                ),
                                TextWidget(
                                  "Rs. ${((int.tryParse(productProvider.cart[index]['price'] ?? "0") ?? 0) * (int.tryParse(productProvider.cart[index]['quantity'] ?? "0") ?? 0)).toStringAsFixed(2)}",
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                ),
                              ],
                            );
                          }),
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
                      TextWidget(
                        '!  Add items for Rs.300.00 or more to avoid Delivery Charges',
                        color: Colors.red,
                        size: Theme.of(context).textTheme.bodyMedium?.fontSize,
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
                        size: Theme.of(context).textTheme.titleMedium?.fontSize,
                      ),
                      ListTile(
                        title: const Text('Pay Online'),
                        leading: Radio(
                            activeColor: Theme.of(context).primaryColor,
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
                            activeColor: Theme.of(context).primaryColor,
                            value: false,
                            groupValue: radioState,
                            onChanged: (bool? value) {
                              setState(() {
                                radioState = value ?? false;
                              });
                            }),
                      ),
                      ElevatedButtonWidget(
                        bgColor: Theme.of(context).primaryColor,
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
      );
    });
  }
}

class DeliverySlotChooser extends StatefulWidget {
  const DeliverySlotChooser({Key? key}) : super(key: key);

  @override
  State<DeliverySlotChooser> createState() => _DeliverySlotChooserState();
}

class _DeliverySlotChooserState extends State<DeliverySlotChooser> {
  var selectedIndex = 0;
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
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(
                        left: index != 0 ? 8 : 0, right: index != 7 ? 8 : 0),
                    padding: const EdgeInsets.all(8),
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: index == selectedIndex
                              ? Colors.transparent
                              : Theme.of(context).primaryColor,
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
                            color: index == selectedIndex
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7)),
                        TextWidget(
                          DateTime.now()
                              .add(Duration(days: index ~/ 2))
                              .day
                              .toString(),
                          color: index == selectedIndex
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).primaryColor.withOpacity(0.7),
                          size:
                              Theme.of(context).textTheme.titleSmall?.fontSize,
                          weight: FontWeight.w800,
                        ),
                        TextWidget(
                            index % 2 == 0 ? '7 AM - 11 AM' : '11 AM - 3 PM',
                            color: index == selectedIndex
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .primaryColor
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
