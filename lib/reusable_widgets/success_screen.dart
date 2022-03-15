import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';
import 'package:nandikrushifarmer/view/product/add_product.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    int providingIndex = 0;

    return Scaffold(
      body: Stack(children: [
        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: 0.2,
            child: Image.network(
              "https://www.bigbasket.com/media/uploads/p/l/10000053_18-fresho-brinjal-bottle-shape.jpg",
              fit: BoxFit.fitHeight,
              height: height(context) * 0.7,
              alignment: Alignment.center,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: height(context) * 0.15,
                color: Color(0xFF009906),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              TextWidget(
                text: "SUCCESS",
                size: height(context) * 0.05,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              TextWidget(
                text: "Added your product: Brinjal",
                size: height(context) * 0.02,
                weight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: height(context) * 0.15,
              ),
              ElevatedButtonWidget(
                onClick: () {
                  Navigator.pop(context);
                },
                minWidth: width(context) * 0.85,
                height: height(context) * 0.06,
                borderRadius: 0,
                allRadius: true,
                bgColor: Colors.green[900],
                textColor: Colors.white,
                buttonName: "Sell Another Product".toUpperCase(),
                innerPadding: 0.02,
                textSize: width(context) * 0.045,
                // textStyle: FontWeight.bold,
                leadingIcon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: width(context) * 0.045,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
