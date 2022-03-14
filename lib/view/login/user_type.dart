import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/login_bg.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return LoginBG(
      bottomWidget: Container(
        padding: EdgeInsets.only(
            top: width(context) * 0.04, bottom: width(context) * 0.06),
        height: height(context) * 0.5,
        width: width(context),
        decoration: const BoxDecoration(
            color: Color(0xffF2F5F4),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.0),
                topRight: Radius.circular(70.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextWidget(
                  text: "REGISTER AS",
                  size: width(context) * 0.04,
                  weight: FontWeight.w800,
                  color: Colors.green[900],
                  align: TextAlign.start,
                  lSpace: 2.5,
                )
              ],
            ),
            ElevatedButtonWidget(
              onClick: () {},
              minWidth: width(context) * 0.8,
              height: height(context) * 0.06,
              bgColor: Colors.green[900],
              textColor: Colors.white,
              buttonName: "NEXT",
              textSize: width(context) * 0.04,
              trailingIcon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: width(context) * 0.045,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
