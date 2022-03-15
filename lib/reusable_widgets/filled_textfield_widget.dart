import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class FilledTextFieldWidget extends StatelessWidget {
  final String? text;
  final String? hint;
  final String? validateMsg;
  final TextInputType? keyBoardType;
  final double? borderRadius;
  final Color? bordercolor;
  final double? focusBorderRadius;
  final double? enableBorderRadius;
  final Color? focusBorderColor;
  final Color? enableBorderColor;
  final double? errorBorderRadius;
  final double? focusErrorRadius;
  final Icon? postIcon;
  final Color? postIconColor;
  final Color? hintColor;
  final double? hintSize;
  final FontWeight? hintWeight;
  final Icon? prefix;
  final Color? prefixColor;
  final TextEditingController? controller;
  final Function? onSubmitField;
  final Function? functionValidate;
  final String? parametersValidate;
  final int? maxLength;
  final int? maxLines;
  final String? label;
  final bool? focus;
  final List<TextInputFormatter>? formatter;
  final TextStyle? style;

  const FilledTextFieldWidget(
      {Key? key,
      this.text,
      this.validateMsg,
      this.hint,
      this.keyBoardType,
      this.borderRadius,
      this.bordercolor,
      this.postIcon,
      this.postIconColor,
      this.focus,
      this.focusBorderColor,
      this.focusBorderRadius,
      this.enableBorderColor,
      this.enableBorderRadius,
      this.hintColor,
      this.hintSize,
      this.hintWeight,
      this.controller,
      this.onSubmitField,
      this.functionValidate,
      this.parametersValidate,
      this.maxLength,
      this.maxLines,
      this.errorBorderRadius,
      this.focusErrorRadius,
      this.prefixColor,
      this.prefix,
      this.label,
      this.formatter,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(height(context) * 0.01),
        counterText: '',
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintStyle: fonts(hintSize ?? 15.0, hintWeight ?? FontWeight.w500,
            hintColor ?? Colors.grey),
        hintText: hint ?? '',
      ),
      style: style?.copyWith(fontFamily: 'Quicksand') ??
          const TextStyle(fontFamily: 'Quicksand'),
      autofocus: focus ?? false,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: (value) {
        if (label == "Alternative Number") {
          if (value!.length == 10 && int.parse(value) < 5000000000) {
            return 'Please Enter Valid Mobile Number';
          } else if (value.isNotEmpty && value.length < 10) {
            return 'Please Enter Valid Mobile Number';
          }
          return null;
        } else if (label == "Aadhar Number") {
          if (value!.length != 12) {
            return 'Please enter valid Number';
          }
        } else {
          if (value!.isEmpty) {
            return validateMsg ?? '';
          }
          return null;
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (onSubmitField != null) onSubmitField!();
      },
      keyboardType: keyBoardType,
    );
  }
}
