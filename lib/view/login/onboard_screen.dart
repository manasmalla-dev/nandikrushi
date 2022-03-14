import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/onboard_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
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
    return Consumer<OnboardProvider>(
      builder: (context, value, child) {
        var data = value.data;
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
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
                      child: Image.network(
                        data['imageLink'],
                        fit: BoxFit.fill,
                        height: height(context) * 0.25,
                        width: width(context) * 0.95,
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: width(context) * 0.03),
                      width: width(context),
                      child: TextWidget(
                        text: data["title"],
                        size: width(context) * 0.10,
                        align: TextAlign.start,
                        color: Colors.green[900],
                        weight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height(context),
                      width: width(context),
                      child: ListView.builder(
                          itemCount: data['content'].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Divider(
                                  thickness: 1.5,
                                  color: Colors.green[900],
                                  indent: width(context) * 0.04,
                                  endIndent: width(context) * 0.04,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width(context) * 0.05),
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
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButtonWidget(
            onClick: () {
              onboardProvider?.increseStep(1);
            },
            minWidth: width(context) * 0.9,
            height: height(context) * 0.06,
            bgColor: Colors.green[900],
            textColor: Colors.white,
            buttonName: data["button_name"],
            textSize: width(context) * 0.04,
            trailingIcon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: width(context) * 0.045,
            ),
          ),
        );
      },
    );
  }
}
