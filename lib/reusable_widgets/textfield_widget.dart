import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class TextFieldWidget extends StatelessWidget {
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

  const TextFieldWidget(
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
      this.formatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter,
      controller: controller,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: bordercolor ?? Colors.white),
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        suffixIcon: IconButton(
          onPressed: () {
            controller!.clear();
          },
          icon: postIcon ?? const Icon(Icons.android),
          color: postIconColor ?? Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(focusBorderRadius ?? 0)),
            borderSide:
                BorderSide(width: 1, color: focusBorderColor ?? Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(enableBorderRadius ?? 0)),
            borderSide:
                BorderSide(width: 1, color: enableBorderColor ?? Colors.white)),
        errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(errorBorderRadius ?? 0)),
            borderSide: const BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(focusErrorRadius ?? 0)),
            borderSide: const BorderSide(width: 1, color: Colors.red)),
        hintStyle: fonts(hintSize ?? 15.0, hintWeight ?? FontWeight.w500,
            hintColor ?? Colors.grey),
        hintText: hint ?? '',
        labelText: label,
        labelStyle: fonts(hintSize ?? 15.0, hintWeight ?? FontWeight.w500,
            hintColor ?? Colors.grey),
      ),
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
