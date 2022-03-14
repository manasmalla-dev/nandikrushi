import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final double? lSpace;
  final TextOverflow? flow;
  final TextAlign? align;

  const TextWidget(
      {Key? key,
      this.text,
      this.size,
      this.color,
      this.weight,
      this.align,
      this.flow,
      this.lSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        overflow: flow ?? TextOverflow.ellipsis,
        textAlign: align ?? TextAlign.start,
        style: GoogleFonts.quicksand(
          letterSpacing: lSpace ?? 0,
          fontSize: size ?? 14,
          color: color ?? Colors.grey[900],
          fontWeight: weight ?? FontWeight.normal,
        ));
  }
}

fonts(size, bold, color) {
  return GoogleFonts.quicksand(
      color: color, fontSize: size, fontWeight: bold, letterSpacing: 1.0);
}
