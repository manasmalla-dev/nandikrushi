import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nandikrushi/reusable_widgets/app_bar.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/view/my_account/order_detail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var orders = [
    {
      'id': 'XXXXXXXXXXXX',
      'date': '15 Sep 2021 10:55 AM',
      'amount': 'Rs.108.00',
      'status': 'Order Placed',
      'substatus': 'Approval pending from Farmer',
      'items': [
        {'name': 'Tomato', 'unit': '1 kg', 'price': '50', 'quantity': '10'},
        {
          'name': 'Foxtail Millet',
          'unit': '1 kg',
          'price': '140',
          'quantity': '25'
        }
      ]
    },
    {
      'id': 'XXXXXXXXXXXX',
      'date': '15 Sep 2021 04:15 PM',
      'amount': 'Rs.108.00',
      'status': 'Order Placed',
      'substatus': 'Approval pending from Farmer',
      'items': [
        {'name': 'Tomato', 'unit': '1 kg', 'price': '50', 'quantity': '10'},
        {
          'name': 'Foxtail Millet',
          'unit': '1 kg',
          'price': '140',
          'quantity': '25'
        }
      ]
    },
    {
      'id': 'XXXXXXXXXXXX',
      'date': '14 Sep 2021 10:55 AM',
      'amount': 'Rs.108.00',
      'status': 'Order Cancelled',
      'items': [
        {'name': 'Tomato', 'unit': '1 kg', 'price': '50', 'quantity': '10'},
        {
          'name': 'Foxtail Millet',
          'unit': '1 kg',
          'price': '140',
          'quantity': '25'
        }
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  var simpleDateFormatter = DateFormat('dd MMM yyyy hh:mm a');
  var dateFormatter = DateFormat('dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    var dates = orders.map((e) {
      var date = e['date'];
      var dt = simpleDateFormatter.parse((date as String?)!);
      return dt;
    });
    var uniqueDates =
        Set.from(dates.map((e) => dateFormatter.format(e))).toList();
    return Scaffold(
      appBar: appBarWithTitle(context, title: 'Orders'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              var uniqueOrders = orders
                  .where((element) =>
                      dateFormatter.format(simpleDateFormatter
                          .parse((element['date'] as String?)!)) ==
                      uniqueDates[index])
                  .toList();
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: TextWidget(text: uniqueDates[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return SizedBox(
                            height: height(context) * 0.12,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text:
                                          'Order# ${uniqueOrders[index]['id']}',
                                      weight: FontWeight.w800,
                                      size: height(context) * 0.02,
                                    ),
                                    TextWidget(
                                      text: (uniqueOrders[index]['date']
                                              as String?) ??
                                          '',
                                      weight: FontWeight.w500,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text: (uniqueOrders[index]['amount']
                                              as String?) ??
                                          '',
                                      weight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Icons.rotate_right_rounded,
                                          color: Colors.red,
                                        ),
                                        TextWidget(
                                          text: 'Repeat Order',
                                          color: Colors.red,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.chevron_right_rounded),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetails(
                                                      order:
                                                          uniqueOrders[index],
                                                    )));
                                      },
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextWidget(
                                          text: (uniqueOrders[index]['status']
                                                      as String?)
                                                  ?.toUpperCase() ??
                                              '',
                                          size: 13,
                                          weight: FontWeight.bold,
                                          color: ((uniqueOrders[index]['status']
                                                          as String?) ??
                                                      '')
                                                  .toLowerCase()
                                                  .contains('cancelled')
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Icon(
                                          Icons.check_box_rounded,
                                          color: ((uniqueOrders[index]['status']
                                                          as String?) ??
                                                      '')
                                                  .toLowerCase()
                                                  .contains('cancelled')
                                              ? Colors.red
                                              : Colors.green,
                                        )
                                      ],
                                    ),
                                    uniqueOrders[index]['substatus'] != null
                                        ? TextWidget(
                                            text: (uniqueOrders[index]
                                                ['substatus'] as String?),
                                            size: 8,
                                          )
                                        : const SizedBox(),
                                    const Spacer()
                                  ],
                                ))
                              ],
                            ),
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: uniqueOrders.length),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: Set.from(orders.map((e) => dateFormatter.format(
                simpleDateFormatter.parse((e['date'] as String?) ??
                    simpleDateFormatter.format(DateTime.now()))))).length),
      ),
    );
  }
}
