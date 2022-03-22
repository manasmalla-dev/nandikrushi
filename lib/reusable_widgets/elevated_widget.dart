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
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final bool? center;

  const ElevatedButtonWidget(
      {Key? key,
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
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: SizedBox(
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
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: allRadius == true
                            ? BorderRadius.circular(borderRadius ?? 0)
                            : BorderRadius.only(
                                topLeft: Radius.circular(leftRadius ?? 0),
                                topRight: Radius.circular(rightRadius ?? 0),
                                bottomLeft:
                                    Radius.circular(bottomLeftRadius ?? 0),
                                bottomRight:
                                    Radius.circular(bottomRightRadius ?? 0)),
                        side: BorderSide(
                            color: borderSideColor ?? Colors.white)))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * (innerPadding ?? 0.01)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingIcon != null) buildLeadingIcon(leadingIcon),
                  if (center == true) buildLeadingIcon(leadingIcon),
                  TextWidget(
                    text: buttonName ?? 'Button',
                    size: textSize ?? 10.0,
                    weight: textStyle ?? FontWeight.w600,
                    color: textColor ?? Colors.black,
                  ),
                  if (trailingIcon != null) buildTrailingIcon(trailingIcon),
                  if (center == true) buildLeadingIcon(leadingIcon),
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
