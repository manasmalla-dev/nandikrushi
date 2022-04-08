import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/model/onnboard_model.dart';
import 'package:nandikrushifarmer/provider/onboard_provider.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/user_type.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String? title;
  const MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OnboardProvider? onboardProvider;

  @override
  void initState() {
    onboardProvider = Provider.of<OnboardProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(
      initialPage: 0,
    );
    return Consumer<OnboardProvider>(
      builder: (context, value, child) {
        var data = value.data;
        return PageView.builder(
            controller: _pageController,
            itemCount: onboardData.length,
            onPageChanged: (number) {
              onboardProvider?.setPageNumber(number);
            },
            itemBuilder: (context, index) {
              return Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    width: width(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage(data['imageLink']),
                            fit: BoxFit.fill,
                            height: height(context) * 0.25,
                            width: width(context) * 0.9,
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.04,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: width(context) * 0.03),
                          width: width(context),
                          child: TextWidget(
                            text: data["title"],
                            size: width(context) * 0.10,
                            align: TextAlign.start,
                            color: SpotmiesTheme.primaryColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height(context) * 0.01),
                            child: SizedBox(
                              width: width(context),
                              child: ListView.builder(
                                  itemCount: data['content'].length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Divider(
                                          thickness: index == 0 ? 2 : 1,
                                          color: SpotmiesTheme.primaryColor,
                                          indent: width(context) * 0.04,
                                          endIndent: width(context) * 0.04,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width(context) * 0.05,
                                              right: width(context) * 0.05,
                                              top: height(context) * 0.01,
                                              bottom: height(context) * 0.01),
                                          child: TextWidget(
                                            text: data['content'][index],
                                            size: width(context) * 0.04,
                                            align: TextAlign.start,
                                            color: Colors.grey[900],
                                            weight: FontWeight.w400,
                                            flow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom: height(context) * 0.015),
                  child: ElevatedButtonWidget(
                    onClick: () {
                      log('message');
                      if (onboardProvider?.step == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const UserType()),
                          ),
                        );
                      } else {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      }
                    },
                    minWidth: width(context) * 0.9,
                    height: height(context) * 0.06,
                    // borderRadius: 16,
                    bgColor: SpotmiesTheme.primaryColor,
                    textColor: Colors.white,
                    buttonName: data["button_name"],
                    textSize: width(context) * 0.04,
                    trailingIcon: Icon(
                      onboardProvider?.step == 0
                          ? Icons.arrow_forward
                          : Icons.check_rounded,
                      color: Colors.white,
                      size: width(context) * 0.045,
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
