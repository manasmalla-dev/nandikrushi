import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/model/purchases.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/rating_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  
  List list = [];
  @override
  Widget build(BuildContext context) {
    list = products['vegetables']!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(context, title: "My Purchases".toUpperCase()),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.sort_rounded),
              onPressed: () {},
              splashRadius: 12,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(height(context) * 0.01),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 6),
                      child: SizedBox(
                        height: height(context) * 0.19,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  text: "${list[index]['name']} seeds",
                                  weight: FontWeight.w800,
                                  size: height(context) * 0.024,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextWidget(
                                      text:
                                          "Order placed on: ${list[index]['date']}",
                                      weight: FontWeight.w500,
                                      size: height(context) * 0.0085,
                                      color: Colors.blue,
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(
                                          height(context) * 0.005),
                                      splashRadius: height(context) * 0.01,
                                      iconSize: height(context) * 0.02,
                                      onPressed: () {
                                        log("SHOW MENU");
                                      },
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            TextWidget(
                              text: list[index]['description'],
                            ),
                            SizedBox(
                              height: height(context) * 0.018,
                            ),
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height(context) * 0.08,
                                    width: height(context) * 0.08,
                                    child: Image.network(
                                      list[index]['url'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextWidget(
                                                text: "Rs.",
                                                size: height(context) * 0.019,
                                                weight: FontWeight.bold,
                                              ),
                                              TextWidget(
                                                text: "${list[index]['price']}",
                                                size: height(context) * 0.024,
                                                weight: FontWeight.w800,
                                              ),
                                            ],
                                          ),
                                          TextWidget(
                                            text: list[index]['units'],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 8,
                                              ),
                                              TextWidget(
                                                flow: TextOverflow.clip,
                                                text: list[index]['place'],
                                                size: height(context) * 0.01,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: "Your Rating".toUpperCase(),
                                        size: height(context) * 0.014,
                                        weight: FontWeight.bold,
                                      ),
                                      const RatingWidget(),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize: Size.zero, // Set this
                                            padding:
                                                EdgeInsets.zero, // and this

                                            primary:
                                                Theme.of(context).primaryColor,
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100))),
                                        onPressed: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2),
                                          child: TextWidget(
                                            text: "Buy Again".toUpperCase(),
                                            size: height(context) * 0.012,
                                            weight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 1.5,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
