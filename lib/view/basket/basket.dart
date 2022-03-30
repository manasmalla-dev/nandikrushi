import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/basket/confirm_order.dart';
import 'package:nandikrushifarmer/view/basket/delivery_address_bs.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context,
          title: 'Basket',
          prefix: Icons.shopping_basket_rounded,
          subtitle:
              '${items.map((e) => int.tryParse(e['quantity'] ?? "0") ?? 0).reduce((value, element) => value + element)} items'),
      body: Column(
        children: [
          Expanded(
            child: CartItems(
              items: items,
              onRemoveItem: (index) {
                setState(() {
                  items[index]['quantity'] =
                      ((int.tryParse(items[index]['quantity'] ?? "0") ?? 0) - 1)
                          .toString();
                });
              },
              onAddItem: (index) {
                setState(() {
                  items[index]['quantity'] =
                      ((int.tryParse(items[index]['quantity'] ?? "0") ?? 0) + 1)
                          .toString();
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: height(context) * 0.015,
                left: width(context) * 0.1,
                right: width(context) * 0.1),
            child: ElevatedButtonWidget(
              borderRadius: 8,
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const ConfirmOrderScreen()),
                  ),
                );
              },
              minWidth: width(context) * 0.9,
              height: height(context) * 0.06,
              // borderRadius: 16,
              bgColor: Colors.grey.shade200,
              textColor: Colors.grey.shade700,
              textStyle: FontWeight.bold,
              buttonName: "Confirm Order".toUpperCase(),
              textSize: width(context) * 0.04,
              trailingIcon: Icon(
                Icons.arrow_forward,
                color: Colors.grey.shade700,
                size: width(context) * 0.045,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
