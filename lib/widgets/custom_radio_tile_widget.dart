import 'package:flutter/material.dart';
import '../app/themes/app_colors.dart';
import '../app/themes/styles.dart';

class CustomRadioTileWidget<T> extends StatelessWidget {
  const CustomRadioTileWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
    this.activeColor,
    this.showDivider = true,
  });

  final T value;
  final T? groupValue;
  final String title;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<T>(
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.zero,
          value: value,
          groupValue: groupValue,
          activeColor: activeColor ?? AppColors.primaryColor(),
          title: Text(
            title,
            style: Styles.tsBlack3BRegular14(),
          ),
          onChanged: onChanged,
        ),
        if (showDivider)
          const Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColors.greyE4,
          ),
      ],
    );
  }
}
