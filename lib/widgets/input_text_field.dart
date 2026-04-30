import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app/themes/app_colors.dart';
import '../app/themes/styles.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.textFieldWrapper,
    this.labelText,
    this.hintText,
    this.prefix,
    this.readOnly = false,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.hintStyle,
    this.capitalize = false,
    this.maxLines = 1,
    this.focusNode,
    this.borderColor,
    this.contentPadding,
    this.textAlign,
    this.borderRadius = 10,
    this.autoFocus = false,
    this.onSubmitted,
    this.obscureText = false,
    this.errorText = "",
    this.maxLength,
    this.validator,
    this.focusBorderColor,
    this.isDense,
    this.onTap,
    this.formFieldKey,
    this.labelStyle,
    this.textStyle,
  });

  final TextEditingController textFieldWrapper;
  final Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final bool capitalize;
  final int maxLines;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? focusBorderColor;
  final EdgeInsets? contentPadding;
  final TextAlign? textAlign;
  final double borderRadius;
  final bool autoFocus;
  final Function(String)? onSubmitted;
  final bool obscureText;
  final String errorText;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool? isDense;
  final VoidCallback? onTap;
  final GlobalKey<FormFieldState>? formFieldKey;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formFieldKey,
      onTap: onTap,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      focusNode: focusNode,
      autofocus: autoFocus,
      obscureText: obscureText,
      textCapitalization:
          capitalize ? TextCapitalization.characters : TextCapitalization.none,
      readOnly: readOnly,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: textFieldWrapper,
      maxLength: maxLength,
      validator: validator,
      //     (value) {
      //   if (value == null || value.trim().isEmpty) {
      //     return 'This field is required';
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        // contentPadding:  EdgeInsets.only(left: 16.0),
        isDense: isDense,
        filled: true,
        fillColor: AppColors.white,
        errorText: errorText.isEmpty ? null : errorText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor ?? AppColors.greyDA)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor ?? AppColors.greyDA)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor ?? AppColors.greyDA)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: focusBorderColor ?? AppColors.greyDA)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: AppColors.redC7, width: 1.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: AppColors.redC7, width: 1.0)),
        labelStyle: labelStyle ?? Styles.tsGrey69Regular12(),
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle ?? Styles.tsBlack8CRegular12(),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      style: textStyle ?? Styles.tsBlack22Regular14(),
      cursorColor: AppColors.black,
    );
  }
}
