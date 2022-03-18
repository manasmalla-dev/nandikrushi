import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextWidget(
          text: "Basket",
          color: Colors.grey[900],
          size: width(context) * 0.065,
          weight: FontWeight.w600,
        ),
        leading: Icon(
          Icons.shopping_basket,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}
