import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final double? lSpace;
  final TextOverflow? flow;
  final TextAlign? align;
  final double? height;

  const TextWidget(
      {Key? key,
      this.text,
      this.size,
      this.color,
      this.weight,
      this.align,
      this.flow,
      this.height,
      this.lSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        overflow: flow ?? TextOverflow.ellipsis,
        textAlign: align ?? TextAlign.start,
        style: TextStyle(
            fontFamily: 'Product Sans',
            letterSpacing: lSpace ?? 0,
            fontSize: size ?? 14,
            color: color ?? Colors.grey[900],
            fontWeight: weight ?? FontWeight.normal,
            height: height));
  }
}

fonts(size, bold, color) {
  return TextStyle(
      fontFamily: 'Product Sans',
      color: color,
      fontSize: size,
      fontWeight: bold,
      letterSpacing: 1.0);
}
