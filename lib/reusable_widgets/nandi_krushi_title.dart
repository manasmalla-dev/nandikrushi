import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';

class NandiKrushiTitle extends StatelessWidget {
  final Color? textColor;
  final double? textSize;
  const NandiKrushiTitle({Key? key, this.textColor, this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Nandikrushi",
      style: TextStyle(
          color: textColor ?? const Color(0xFF006838),
          fontFamily: 'Samarkan',
          fontSize: textSize ?? height(context) * 0.034),
    );
  }
}
