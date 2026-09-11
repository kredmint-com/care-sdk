import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';

import '../app/themes/app_colors.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepperWidget({
    super.key,
    required this.currentStep,
    this.totalSteps = 10,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $currentStep',
              style: Styles.tsBlack3BSemiBold14(),
            ),
            Text(
              '$currentStep/$totalSteps',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.greyOpacity20,
            valueColor:  AlwaysStoppedAnimation<Color>(
              AppColors.headingColor,
            ),
          ),
        ),
      ],
    );
  }
}
