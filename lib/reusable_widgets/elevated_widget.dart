import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final String? buttonName;
  final double? borderRadius;
  final double? minWidth;
  final double? height;
  final Color? borderSideColor;
  final TextStyle? style;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? textSize;
  final VoidCallback? onClick;
  final FontWeight? textStyle;
  final double? elevation;
  final bool? allRadius;
  final double? leftRadius;
  final double? rightRadius;
  final double? innerPadding;

  const ElevatedButtonWidget({
    Key? key,
    this.bgColor,
    this.textColor,
    this.buttonName,
    this.borderRadius,
    this.leftRadius,
    this.rightRadius,
    this.minWidth,
    this.height,
    this.allRadius,
    this.borderSideColor,
    this.style,
    this.leadingIcon,
    this.trailingIcon,
    this.textSize,
    this.textStyle,
    this.onClick,
    this.elevation,
    this.innerPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        width: minWidth ?? double.infinity,
        height: height ?? 50.0,
        child: ElevatedButton(
            onPressed: () {
              return onClick!();
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(elevation ?? 0),
              backgroundColor: MaterialStateProperty.all(
                bgColor ?? Colors.blue,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * (innerPadding ?? 0.01)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingIcon != null) buildLeadingIcon(leadingIcon),
                  Text(
                    buttonName ?? 'Button',
                    style: fonts(textSize ?? 10.0, textStyle ?? FontWeight.w500,
                        textColor ?? Colors.black),
                  ),
                  if (trailingIcon != null) buildTrailingIcon(trailingIcon),
                ],
              ),
            )),
      ),
    );
  }
}

Widget buildLeadingIcon(Widget? leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[leadingIcon, const SizedBox(width: 10)],
    );
  }
  return Container();
}

Widget buildTrailingIcon(Widget? trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        trailingIcon,
      ],
    );
  }
  return Container();
}
