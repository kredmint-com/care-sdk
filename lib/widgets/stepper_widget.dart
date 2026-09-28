import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';

import '../app/themes/app_colors.dart';
import '../utils/helper/sizedbox_extension.dart';

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

    List<String> stepsList = [
      "Personal details",
      "Emi Plan",
      "Down Payment",
      "Kfs & Sign",
      "Kyc",
      "Bank Detail",
      "Mandate",
      "Success",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text(
            //   'Step $currentStep',
            //   style: Styles.tsBlack3BSemiBold14(),
            // ),
            Text(
              '$currentStep/$totalSteps',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        8.h,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(stepsList.length, (index) {
              return Padding(
                  padding: EdgeInsetsGeometry.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (index + 1) == currentStep
                              ? AppColors.buttonBgColor
                              : AppColors.greyOpacity20,
                        ),
                        padding: EdgeInsetsGeometry.all(12),
                        child: Text((index + 1).toString(),
                            style: Styles.tsBlack3BSemiBold12()),
                      ),
                      4.w,
                      Text(
                        stepsList[index],
                        style: Styles.tsBlack3BRegular12(),
                      ),
                      if (index != (stepsList.length - 1)) ...[
                        4.w,
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            top: 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 1.3,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-4, 0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.grey,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ));
            }),
          ),
        ),
      ],
    );
  }
}
