import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';

class TextFieldWidget extends StatelessWidget {
  final String? text;
  final String? hint;
  final String? validateMsg;
  final bool showCounter;
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
  final Function(String)? onEdit;
  final Function? onSubmitField;
  final Function? functionValidate;
  final String? parametersValidate;
  final int? maxLength;
  final int maxLines;
  final String? label;
  final bool? focus;
  final bool readOnly;
  final List<TextInputFormatter>? formatter;
  final TextStyle? style;
  final TextInputAction textInputAction;
  final bool shouldShowCurreny;
  final bool obscureText;

  const TextFieldWidget(
      {Key? key,
      this.text,
      this.validateMsg,
      this.hint,
      this.keyBoardType,
      this.borderRadius,
      this.bordercolor,
      this.postIcon,
      this.obscureText = false,
      this.postIconColor,
      this.readOnly = false,
      this.focus,
      this.showCounter = false,
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
      this.textInputAction = TextInputAction.next,
      this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter,
      controller: controller,
      cursorColor: const Color(0xFF006838),
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        suffixIcon: suffix,
        prefixIcon: shouldShowCurreny
            ? SizedBox(
                height: hintSize,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("₹"),
                    SizedBox(
                      height: height(context) * 0.005,
                    )
                  ],
                ),
              )
            : prefix,
        contentPadding: EdgeInsets.symmetric(vertical: height(context) * 0.01),
        counterText: showCounter ? null : '',
        isDense: true,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF006838))),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: bordercolor ?? Colors.grey.shade500,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        hintStyle: fonts(hintSize ?? 15.0, hintWeight ?? FontWeight.w500,
            hintColor ?? Colors.grey),
        hintText: hint ?? '',
        labelText: label,
        labelStyle: fonts(hintSize ?? 15.0, FontWeight.normal, Colors.grey),
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
      onChanged: onEdit ?? (_) {},
      onFieldSubmitted: (value) {
        if (onSubmitField != null) {
          onSubmitField!();
        }
      },
      keyboardType: keyBoardType,
    );
  }
}
