import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

appbar(
  BuildContext context,
) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    title: Image.asset(
      'assets/pngs/vihaan_app_logo.png',
      height: height(context) * 0.1,
      width: width(context) * 0.4,
    ),
  );
}

appBarWithTitle(BuildContext context,
    {String? title,
    String? subtitle,
    double? toolbarHeight,
    Color? color,
    Widget? suffix,
    IconData? prefix,
    Function? onPrefixClicked}) {
  return AppBar(
    toolbarHeight: toolbarHeight ?? kToolbarHeight,
    backgroundColor: color ?? Colors.white,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          onPrefixClicked != null ? onPrefixClicked() : Navigator.pop(context);
        },
        icon: Icon(
          prefix ?? Icons.arrow_back,
          color: Colors.grey[900],
        )),
    actions: [suffix ?? const SizedBox()],
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          size: width(context) * 0.045,
          color: Colors.grey[900],
          weight: FontWeight.w700,
        ),
        subtitle != null
            ? TextWidget(
                text: subtitle,
                size: width(context) * 0.04,
                color: Colors.grey[900],
                weight: FontWeight.w500,
              )
            : SizedBox(),
      ],
    ),
  );
}

profileAppBar(BuildContext context) {
  return Container(
    height: height(context) * 0.11,
    width: width(context),
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.only(
        left: width(context) * 0.1,
        right: width(context) * 0.1,
        bottom: width(context) * 0.04),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 9),
              color: Colors.grey[100]!,
              blurRadius: 3.0,
              spreadRadius: 0.1)
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: width(context) * 0.16,
          height: width(context) * 0.16,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/png/account_farmer.png'),
              )),
        ),
        SizedBox(
          width: width(context) * 0.6,
          height: width(context) * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width(context) * 0.6,
                child: TextWidget(
                  text: "Rahul",
                  color: Colors.grey[900],
                  weight: FontWeight.w800,
                  flow: TextOverflow.ellipsis,
                  size: width(context) * 0.06,
                  align: TextAlign.left,
                ),
              ),
              SizedBox(
                width: width(context) * 0.6,
                child: TextWidget(
                  text: "+91 7780356704",
                  color: Colors.grey[500],
                  weight: FontWeight.w600,
                  flow: TextOverflow.ellipsis,
                  size: width(context) * 0.04,
                  align: TextAlign.left,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
