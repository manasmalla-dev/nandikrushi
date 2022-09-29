import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_host.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

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
                  'Hi Rahul,',
                  weight: FontWeight.w800,
                  size: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  'Thank you for placing the order',
                  weight: FontWeight.w500,
                  size: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  flow: TextOverflow.visible,
                ),
                TextWidget(
                  'Your fresh produce will be harvested soon',
                  size: Theme.of(context).textTheme.titleMedium?.fontSize,
                  flow: TextOverflow.visible,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  'Order Details',
                  weight: FontWeight.w800,
                  size: Theme.of(context).textTheme.titleSmall?.fontSize,
                ),
                const Divider(),
                TextWidget(
                  'Order Number: xxxxxxxxxx\nDelivery Slot : Thu, 16 Sep(07:00AM - 11:00AM)',
                  size: Theme.of(context).textTheme.bodySmall?.fontSize,
                  flow: TextOverflow.visible,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  child: ElevatedButtonWidget(
                    borderRadius: 8,
                    onClick: () {
                      //TODO: Update later to use dynamic uid that is fetched from repository
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => NandikrushiNavHost(
                              userId: FirebaseAuth.instance.currentUser?.uid ??
                                  "")),
                        ),
                      );
                    },
                    height: 64,
                    textColor: Colors.white,
                    buttonName: "Home",
                    trailingIcon: Icons.arrow_forward,
                  ),
                ),
                const SizedBox(
                  height: 27,
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
