import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
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
  final Widget? suffix;
  final Color? prefixColor;
  final TextEditingController? controller;
  final Function? onSubmitField;
  final Function? functionValidate;
  final String? parametersValidate;
  final int? maxLength;
  final int maxLines;
  final String? label;
  final bool? focus;
  final List<TextInputFormatter>? formatter;
  final TextStyle? style;
  final TextInputAction textInputAction;
  final bool shouldShowCurreny;

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
      this.maxLines = 1,
      this.suffix,
      this.errorBorderRadius,
      this.focusErrorRadius,
      this.prefixColor,
      this.prefix,
      this.label,
      this.formatter,
      this.style,
      this.shouldShowCurreny = false,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter,
      controller: controller,
      cursorColor: Color(0xFF006838),
      decoration: InputDecoration(
        suffixIcon: suffix,
        prefixIcon: shouldShowCurreny
            ? SizedBox(
                height: hintSize,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("₹"),
                    SizedBox(
                      height: height(context) * 0.005,
                    )
                  ],
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: height(context) * 0.01),
        counterText: '',
        isDense: true,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF006838))),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: bordercolor ?? Colors.grey.shade500,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        hintStyle: fonts(hintSize ?? 15.0, hintWeight ?? FontWeight.w500,
            hintColor ?? Colors.grey),
        hintText: hint ?? '',
        labelText: label != null ? "$label*" : "",
        labelStyle: fonts(hintSize ?? 15.0, hintWeight ?? FontWeight.w500,
            hintColor ?? Colors.grey),
      ),
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
      style: style,
      autofocus: focus ?? false,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      onFieldSubmitted: (value) {
        if (onSubmitField != null) {
          onSubmitField!();
        }
      },
      keyboardType: keyBoardType,
    );
  }
}
