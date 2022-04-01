import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/basket/order_successful.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  var items = [
    {'name': 'Tomato', 'unit': '1 kg', 'price': '50', 'quantity': '10'},
    {'name': 'Foxtail Millet', 'unit': '1 kg', 'price': '140', 'quantity': '25'}
  ];

  var radioState = false;

  // ignore: prefer_typing_uninitialized_variables
  var selected;

  @override
  Widget build(BuildContext context) {
    _displayDialog(BuildContext context) async {
      selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: width(context),
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                ElevatedButtonWidget(
                  onClick: () {
                    Navigator.pop(context);
                  },
                  height: height(context) * 0.05,
                  minWidth: width(context) * 0.35,
                  bgColor: Colors.white,
                  buttonName: "Cancel".toUpperCase(),
                  textSize: width(context) * 0.04,
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
                  height: height(context) * 0.05,
                  minWidth: width(context) * 0.35,
                  bgColor: Colors.green[900],
                  buttonName: "Continue".toUpperCase(),
                  allRadius: true,
                  borderRadius: 10,
                  textSize: width(context) * 0.04,
                  textColor: Colors.white,
                  textStyle: FontWeight.w600,
                  center: true,
                ),
              ],
              content: SizedBox(
                width: width(context) * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'Order Total',
                    ),
                    TextWidget(
                      text:
                          'Rs. ${(items.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                (value, element) => value + element,
                              ) + 100).toStringAsFixed(2)}',
                      size: height(context) * 0.035,
                      color: Theme.of(context).primaryColor,
                      weight: FontWeight.w700,
                    ),
                    TextWidget(
                      text:
                          'You have chosen to pay for this order ${radioState ? 'online' : 'on delivery'}',
                      flow: TextOverflow.visible,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const TextWidget(
                      text: 'Please CONFIRM to place the order.',
                    ),
                  ],
                ),
              ),
              elevation: 10,
            ),
          );
        },
      );

      if (selected != null) {
        setState(() {
          selected = selected;
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(context, title: 'Confirm Order'),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height(context) * 0.23,
                child: const DeliverySlotChooser(),
              ),
              ElevatedButtonWidget(
                onClick: () {},
                height: height(context) * 0.06,
                minWidth: width(context),
                bgColor: Theme.of(context).primaryColor,
                buttonName: "Apply Coupon",
                textSize: height(context) * 0.022,
                textColor: Colors.white,
                textStyle: FontWeight.w600,
                trailingIcon: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: TextWidget(
                  text: 'Order Summary',
                  weight: FontWeight.w800,
                  size: height(context) * 0.022,
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
                          text: 'Item Total',
                          weight: FontWeight.w500,
                          size: height(context) * 0.022,
                        ),
                        TextWidget(
                          text:
                              'Rs. ${items.map((e) => (int.tryParse(e['price'] ?? "0") ?? 0) * (int.tryParse(e['quantity'] ?? "0") ?? 0)).reduce((value, element) => value + element)}',
                          size: height(context) * 0.022,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text:
                              '${items.map((e) => int.tryParse(e['quantity'] ?? "0") ?? 0).reduce((value, element) => value + element)} items',
                          size: height(context) * 0.017,
                        ),
                        const Icon(Icons.expand_more_rounded)
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.06 * items.length,
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: items[index]['name'],
                                      weight: FontWeight.w500,
                                      size: height(context) * 0.022,
                                    ),
                                    TextWidget(
                                      text: items[index]['unit'],
                                      size: height(context) * 0.017,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.all(5),
                                        side: const BorderSide(width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          items[index]['quantity'] =
                                              ((int.tryParse(items[index][
                                                                  'quantity'] ??
                                                              "0") ??
                                                          0) -
                                                      1)
                                                  .toString();
                                        });
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          items[index]['quantity'] =
                                              ((int.tryParse(items[index][
                                                                  'quantity'] ??
                                                              "0") ??
                                                          0) +
                                                      1)
                                                  .toString();
                                        });
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
                                TextWidget(
                                  text:
                                      "Rs. ${((int.tryParse(items[index]['price'] ?? "0") ?? 0) * (int.tryParse(items[index]['quantity'] ?? "0") ?? 0)).toStringAsFixed(2)}",
                                  size: height(context) * 0.022,
                                ),
                              ],
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'Delivery Charge',
                          weight: FontWeight.w700,
                          size: height(context) * 0.022,
                        ),
                        TextWidget(
                          text: 'Rs. 100.00',
                          weight: FontWeight.w700,
                          size: height(context) * 0.022,
                        ),
                      ],
                    ),
                    TextWidget(
                      text:
                          '!  Add items for Rs.300.00 or more to avoid Delivery Charges',
                      color: Colors.red,
                      size: height(context) * 0.012,
                      weight: FontWeight.bold,
                    ),
                    const Divider(),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'Total'.toUpperCase(),
                          weight: FontWeight.w800,
                          size: height(context) * 0.022,
                        ),
                        TextWidget(
                          text:
                              'Rs. ${(items.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                    (value, element) => value + element,
                                  ) + 100.00).toStringAsFixed(2)}',
                          weight: FontWeight.w700,
                          size: height(context) * 0.022,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    const Divider(),
                    TextWidget(
                      text: 'Payment Method',
                      weight: FontWeight.w800,
                      size: height(context) * 0.022,
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
                      allRadius: true,
                      leadingIcon: const Icon(Icons.arrow_forward_rounded),
                      buttonName:
                          'PAY Rs. ${(items.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                (value, element) => value + element,
                              ) + 100.00).toStringAsFixed(0)} ON DELIVERY',
                      textColor: Colors.white,
                      textSize: height(context) * 0.02,
                      textStyle: FontWeight.w800,
                      borderRadius: 12,
                      innerPadding: 0.03,
                      onClick: () {
                        _displayDialog(context);
                      },
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'Delivery Slot',
            weight: FontWeight.w800,
            size: height(context) * 0.025,
          ),
          SizedBox(
            height: height(context) * 0.015,
          ),
          Expanded(
            child: ListView.builder(
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
                            text: DateFormat('EEE, MMM')
                                .format(
                                  DateTime.now().add(
                                    Duration(
                                      days: index ~/ 2,
                                    ),
                                  ),
                                )
                                .toUpperCase(),
                            color: index == selectedIndex
                                ? Colors.white
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7)),
                        TextWidget(
                          text: DateTime.now()
                              .add(Duration(days: index ~/ 2))
                              .day
                              .toString(),
                          color: index == selectedIndex
                              ? Colors.white
                              : Theme.of(context).primaryColor.withOpacity(0.7),
                          size: height(context) * 0.05,
                          weight: FontWeight.w800,
                        ),
                        TextWidget(
                            text: index % 2 == 0
                                ? '7 AM - 11 AM'
                                : '11 AM - 3 PM',
                            color: index == selectedIndex
                                ? Colors.white
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
