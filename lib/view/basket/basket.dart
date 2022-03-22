import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/view/basket/confirm_order.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context,
          title: 'Basket', prefix: Icons.shopping_basket_rounded),
      body: Center(
        child: Padding(
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
      ),
    );
  }
}
