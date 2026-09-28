import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';

import '../app/themes/app_colors.dart';
import '../utils/helper/sizedbox_extension.dart';

class StepperWidget extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const StepperWidget({
    super.key,
    required this.currentStep,
    this.totalSteps = 10,
  });

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  final ScrollController _scrollController = ScrollController();

  final List<String> stepsList = [
    "Personal details",
    "Emi Plan",
    "Down Payment",
    "Kfs & Sign",
    "Kyc",
    "Bank Detail",
    "Mandate",
    "Success",
  ];

  late final List<GlobalKey> _stepKeys;

  @override
  void initState() {
    super.initState();

    _stepKeys = List.generate(
      stepsList.length,
      (_) => GlobalKey(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentStep();
    });
  }

  @override
  void didUpdateWidget(covariant StepperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentStep != widget.currentStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentStep();
      });
    }
  }

  void _scrollToCurrentStep() {
    final int currentIndex = widget.currentStep - 1;

    if (currentIndex < 0 || currentIndex >= _stepKeys.length) {
      return;
    }

    final BuildContext? stepContext = _stepKeys[currentIndex].currentContext;

    if (stepContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      stepContext,
      duration: Duration.zero,
      alignment: 0.0,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text("Step ${widget.currentStep}", style: Styles.tsBlack3BSemiBold14()),),
            Text(
              '${widget.currentStep}/${widget.totalSteps}',
              style: Styles.tsBlack3BSemiBold14()
            ),
          ],
        ),
        8.h,
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: List.generate(
              stepsList.length,
              (index) {
                final int stepNumber = index + 1;

                final bool isCompleted = stepNumber < widget.currentStep;

                final bool isCurrent = stepNumber == widget.currentStep;

                final bool isActive = isCompleted || isCurrent;

                return Padding(
                  key: _stepKeys[index],
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppColors.buttonBgColor
                              : AppColors.greyOpacity20,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          stepNumber.toString(),
                          style: Styles.tsBlack3BSemiBold12(),
                        ),
                      ),
                      4.w,
                      Text(
                        stepsList[index],
                        style: Styles.tsBlack3BRegular12(),
                      ),
                      if (index != stepsList.length - 1) ...[
                        4.w,
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
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
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
