import 'package:flutter/material.dart';
import '../app/themes/app_colors.dart';
import '../app/themes/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.buttonText,
    required this.onTap,
    this.buttonColor,
    // this.height = 50,
    this.width,
    this.buttonTextStyle,
    this.icon,
    this.buttonRadius,
    this.buttonPadding,
    this.suffixWidget,
    this.borderColor,
    this.prefixWidget,
    this.textPadding = 0.0,
    this.borderWidth = 1.5,
    this.disabled = false,
    this.suffixPadding = 21,
    this.mainAxisSize,
    this.prefixWidgetPadding = 5,
    this.loading = false,
  });

  final String? buttonText;
  final VoidCallback onTap;
  final Color? buttonColor;

  // final double height;
  final double? width;
  final TextStyle? buttonTextStyle;
  final Widget? icon;
  final BorderRadius? buttonRadius;
  final EdgeInsets? buttonPadding;
  final Widget? suffixWidget;
  final Color? borderColor;
  final Widget? prefixWidget;
  final double textPadding;
  final double borderWidth;
  final bool disabled;
  final double suffixPadding;
  final MainAxisSize? mainAxisSize;
  final double prefixWidgetPadding;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (loading || disabled) ? () {} : onTap,
      child: Container(
          width: width,
          // height: height,
          padding: (buttonPadding == null && icon == null)
              ? const EdgeInsets.all(12)
              : buttonPadding,
          decoration: BoxDecoration(
            borderRadius: buttonRadius ?? BorderRadius.circular(10),
            border: borderColor == null
                ? null
                : Border.all(
                    color: borderColor!,
                    width: borderWidth,
                  ),
            color: disabled
                ? AppColors.greyE6
                : buttonColor ?? AppColors.primaryColor(),
          ),
          // alignment: Alignment.center,
          child: loading
              ? Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      )))
              : Row(
                  mainAxisSize: mainAxisSize ?? MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      if (prefixWidget != null) ...[
                        prefixWidget!,
                        SizedBox(
                          width: prefixWidgetPadding,
                        )
                      ],
                      (buttonText != null)
                          ? Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: textPadding),
                              child: Text(
                                buttonText ?? "",
                                style: disabled
                                    ? Styles.tsGrey62Medium12()
                                    : (buttonTextStyle ??
                                        Styles.tsWhiteMedium14()),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          : icon ?? const SizedBox(),
                      if (suffixWidget != null) ...[
                        SizedBox(
                          width: suffixPadding,
                        ),
                        suffixWidget!
                      ]
                    ])),
    );
  }
}
