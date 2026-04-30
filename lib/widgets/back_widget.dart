import 'package:flutter/material.dart';
import '../app/themes/app_colors.dart';

class BackWidget extends StatelessWidget {
  const BackWidget(
      {super.key,
      this.color = AppColors.grey,
      this.addHorizontalPadding = true,
      this.onBackPressed,
      this.backButtonSize = 16,
      this.borderRadius = 2,
      this.clearPadding = false});

  final Color color;
  final bool addHorizontalPadding;
  final VoidCallback? onBackPressed;
  final double backButtonSize;
  final double borderRadius;
  final bool clearPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed,
      child: Padding(
        padding: clearPadding
            ? EdgeInsets.zero
            : addHorizontalPadding
                ? const EdgeInsets.all(15)
                : const EdgeInsets.symmetric(vertical: 15),
        child: Container(
            height: backButtonSize,
            width: backButtonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: color),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 12,
              color: color,
            )),
      ),
    );
  }
}
