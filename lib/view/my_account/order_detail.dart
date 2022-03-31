import 'package:flutter/material.dart';
import 'package:nandikrushi/reusable_widgets/app_bar.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';

class OrderDetails extends StatefulWidget {
  final Map<String, dynamic> order;
  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var currentStep = 1;
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> items = widget.order['items'];
    return Scaffold(
      appBar: appBarWithTitle(
        context,
        title: 'Order# ${widget.order['id']}',
        subtitle: widget.order['date'],
        suffix: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.download_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: Colors.grey.shade800)),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFFEFE8CC),
              child: Stepper(
                steps: [
                  Step(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            text: 'Order Placed',
                            weight: FontWeight.bold,
                          ),
                          TextWidget(text: widget.order['date']),
                        ],
                      ),
                      content: const SizedBox(),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const TextWidget(
                        text: 'Order In Preparation',
                        weight: FontWeight.bold,
                      ),
                      content: const SizedBox(),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const TextWidget(
                        text: 'Order Shipped',
                        weight: FontWeight.bold,
                      ),
                      content: const SizedBox(),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const TextWidget(
                        text: 'Order Delivered',
                        weight: FontWeight.bold,
                      ),
                      content: const SizedBox(),
                      isActive: currentStep > 3,
                      state: currentStep > 3
                          ? StepState.complete
                          : StepState.indexed),
                ],
                controlsBuilder: (context, _) {
                  return const SizedBox();
                },
                currentStep: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Order Information'.toUpperCase(),
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    text: 'Order'.toUpperCase(),
                    weight: FontWeight.bold,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    height: height(context) * 0.06 * items.length,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        '${items[index]['name']} x ${items[index]['quantity']}',
                                    weight: FontWeight.w500,
                                    size: height(context) * 0.02,
                                  ),
                                  TextWidget(
                                    text: items[index]['unit'],
                                    size: height(context) * 0.017,
                                  ),
                                ],
                              ),
                              TextWidget(
                                text:
                                    "Rs. ${((int.tryParse(items[index]['price'] ?? "0") ?? 0) * (int.tryParse(items[index]['quantity'] ?? "0") ?? 0)).toStringAsFixed(2)}",
                                size: height(context) * 0.022,
                                weight: FontWeight.bold,
                              ),
                            ],
                          );
                        }),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Item Total',
                        color: Colors.grey.shade700,
                        weight: FontWeight.w700,
                        size: height(context) * 0.022,
                      ),
                      TextWidget(
                        text:
                            'Rs. ${(items.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                  (value, element) => value + element,
                                )).toStringAsFixed(2)}',
                        weight: FontWeight.w700,
                        size: height(context) * 0.022,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Delivery Charge',
                        size: height(context) * 0.022,
                      ),
                      TextWidget(
                        text: 'Rs. 100.00',
                        weight: FontWeight.w700,
                        size: height(context) * 0.022,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Grand Total',
                        weight: FontWeight.w700,
                        size: height(context) * 0.022,
                      ),
                      TextWidget(
                        text:
                            'Rs. ${(items.map((e) => (double.tryParse(e['price'] ?? "0") ?? 0) * (double.tryParse(e['quantity'] ?? "0") ?? 0)).reduce(
                                  (value, element) => value + element,
                                ) + 100).toStringAsFixed(2)}',
                        weight: FontWeight.w700,
                        size: height(context) * 0.022,
                      ),
                    ],
                  ),
                  const Divider(),
                  TextWidget(
                    text: 'Payment Information'.toUpperCase(),
                    color: Colors.grey.shade800,
                    weight: FontWeight.w700,
                    size: height(context) * 0.022,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    text: 'Payment Method',
                    color: Colors.grey.shade700,
                    weight: FontWeight.w700,
                    size: height(context) * 0.02,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Pay On Delivery',
                        color: Colors.grey.shade700,
                        weight: FontWeight.w700,
                        size: height(context) * 0.02,
                      ),
                      TextWidget(
                        text: 'To Be Paid',
                        color: Colors.grey.shade700,
                        weight: FontWeight.w700,
                        size: height(context) * 0.02,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(),
                  TextWidget(
                    text: 'Deliver to',
                    color: Colors.grey.shade800,
                    weight: FontWeight.w700,
                    size: height(context) * 0.02,
                  ),
                  TextWidget(
                    text: 'Rahul V',
                    color: Colors.grey.shade800,
                    weight: FontWeight.bold,
                    size: height(context) * 0.017,
                  ),
                  TextWidget(
                    text:
                        'House/Flat No: 6-86\nLandmark: Hanuman Temple\nAddress: P.Bonangi, Paravada,Visakhapatnam\n531021\nContact:  9059688373, A\'Contact:  7780356704',
                    color: Colors.grey.shade600,
                    size: height(context) * 0.017,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Chosen Delivery Slot',
                        color: Colors.grey.shade800,
                        weight: FontWeight.w700,
                        size: height(context) * 0.02,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          text: 'Change',
                          color: Colors.red,
                          weight: FontWeight.w700,
                          size: height(context) * 0.02,
                        ),
                      )
                    ],
                  ),
                  TextWidget(
                    text: '16 Feb 2021 10:55 AM',
                    color: Colors.grey,
                    size: height(context) * 0.02,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: TextWidget(
                      text: 'Cancel Order'.toUpperCase(),
                      color: Colors.red,
                      weight: FontWeight.w700,
                      size: height(context) * 0.02,
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
