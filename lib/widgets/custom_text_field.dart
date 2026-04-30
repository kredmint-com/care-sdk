import 'package:flutter/material.dart';
import '../app/themes/app_colors.dart';
import '../app/themes/styles.dart';
import '../utils/helper/text_field_wrapper.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? maxLength;
  final TextInputType inputType;
  final TextEditingController wrapper;
  final bool isEnabled;
  final Color color;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final Function(String val)? onChanged;
  final bool autoFocus;
  final int maxLines;
  final int? minLines;
  final double textFieldRadius;
  final EdgeInsets? contentPadding;

  const CustomTextField(
      {super.key,
      required this.wrapper,
      required this.hintText,
      this.maxLength,
      this.inputType = TextInputType.text,
      this.isEnabled = true,
      this.color = AppColors.white,
      this.prefixWidget,
      this.suffixWidget,
      this.borderColor,
      this.hintStyle,
      this.onChanged,
      this.autoFocus = false,
      this.maxLines = 1,
      this.minLines,
      this.textFieldRadius = 15.0,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      maxLines: maxLines,
      minLines: minLines,
      controller: wrapper,
      maxLength: maxLength,
      keyboardType: inputType,
      enabled: isEnabled,
      onChanged: (val) {
        if (onChanged != null) {
          onChanged!(val);
        }
      },
      decoration: InputDecoration(
        // errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(15, 22, 12, 14),
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        counterText: '',
        fillColor: color,
        filled: true,
        hintText: hintText,
        hintStyle: hintStyle ?? Styles.tsBlack8CRegular12(),
        enabled: isEnabled,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor(),
          ),
          borderRadius: BorderRadius.circular(textFieldRadius),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? AppColors.primaryColor(), width: 0.5),
          borderRadius: BorderRadius.circular(textFieldRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? AppColors.primaryColor(), width: 0.5),
          borderRadius: BorderRadius.circular(textFieldRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? AppColors.primaryColor(), width: 0.5),
          borderRadius: BorderRadius.circular(textFieldRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor(), width: 0.7),
          borderRadius: BorderRadius.circular(textFieldRadius),
        ),
      ),
    );
  }
}
