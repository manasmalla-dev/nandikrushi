import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_host.dart';
import 'package:nandikrushi_farmer/product/add_product.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessScreen extends StatefulWidget {
  final Map<String, String> body;
  final bool isSuccess;
  const SuccessScreen({Key? key, required this.body, required this.isSuccess})
      : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    // int providingIndex = 0;

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
              height: 650,
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
              const Icon(
                Icons.check_circle_rounded,
                size: 140,
                color: Color(0xFF009906),
              ),
              const SizedBox(
                height: 9,
              ),
              TextWidget(
                widget.isSuccess ? "SUCCESS" : "Failure",
                size: 48,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              TextWidget(
                "${widget.isSuccess ? 'Added' : 'Failed adding'} your product: ${widget.body["name"]}",
                size: 20,
                weight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                height: 140,
              ),
              ElevatedButtonWidget(
                onClick: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProductScreen()),
                      (route) => false);
                },

                height: 56,
                borderRadius: 0,
                bgColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                buttonName: widget.isSuccess
                    ? "Sell Another Product".toUpperCase()
                    : "Try Again".toUpperCase(),
                innerPadding: 0.02,
                // textStyle: FontWeight.bold,
                leadingIcon: Icons.arrow_back_rounded,
              ),
              ElevatedButtonWidget(
                onClick: () async {
                  var navigator = Navigator.of(context);
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  var uID = sharedPreferences.getString('userID')!;
                  navigator.pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              NandikrushiNavHost(userId: uID)),
                      (route) => false);
                },
                height: 56,
                borderRadius: 0,
                bgColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                buttonName: "Home".toUpperCase(),
                innerPadding: 0.02,
                // textStyle: FontWeight.bold,
                leadingIcon: Icons.arrow_back_rounded,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
