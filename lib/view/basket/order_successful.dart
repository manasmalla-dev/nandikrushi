import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';

class OrderSuccessfulScreen extends StatefulWidget {
  const OrderSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<OrderSuccessfulScreen> createState() => _OrderSuccessfulScreenState();
}

class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Image(
              image: AssetImage('assets/png/order_success.png'),
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFEFE8CC),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Hi Rahul,',
                  weight: FontWeight.w800,
                  size: height(context) * 0.025,
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                TextWidget(
                  text: 'Thank you for placing the order',
                  weight: FontWeight.w500,
                  size: height(context) * 0.028,
                  flow: TextOverflow.visible,
                ),
                TextWidget(
                  text: 'Your fresh produce will be harvested soon',
                  size: height(context) * 0.022,
                  flow: TextOverflow.visible,
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                TextWidget(
                  text: 'Order Details',
                  weight: FontWeight.w800,
                  size: height(context) * 0.02,
                ),
                const Divider(),
                TextWidget(
                  text:
                      'Order Number: xxxxxxxxxx\nDelivery Slot : Thu, 16 Sep(07:00AM - 11:00AM)',
                  size: height(context) * 0.02,
                  flow: TextOverflow.visible,
                ),
                SizedBox(
                  height: height(context) * 0.035,
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
                          builder: ((context) => const NavBar()),
                        ),
                      );
                    },
                    minWidth: width(context) * 0.9,
                    height: height(context) * 0.06,
                    // borderRadius: 16,
                    bgColor: SpotmiesTheme.primaryColor,
                    textColor: Colors.white,
                    buttonName: "Home",
                    textSize: width(context) * 0.04,
                    trailingIcon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: width(context) * 0.045,
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.03,
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
