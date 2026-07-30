import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_event.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/utils/helper/string_extension.dart';

class EmiPlanTile extends StatefulWidget {
  final bool isSelected;
  final String duration;
  final String amount;
  final String principalAmount;
  final String interest;
  final String total;
  final String rate;
  final bool showBreakdown;
  final int index;
  final Function({required int index}) onUpdateSelectedEmiIndex;
  final Function({required String planType}) onUpdateEmiPlanType;
  final String? selectedEmiPlanType;

  const EmiPlanTile({
    super.key,
    required this.isSelected,
    required this.duration,
    required this.amount,
    required this.principalAmount,
    required this.interest,
    required this.total,
    required this.rate,
    this.showBreakdown = true,
    required this.index,
    required this.onUpdateSelectedEmiIndex,
    required this.onUpdateEmiPlanType,
    required this.selectedEmiPlanType,
  });

  @override
  State<EmiPlanTile> createState() => _EmiPlanTileState();
}

class _EmiPlanTileState extends State<EmiPlanTile> {
  bool isMonthly = true; // 👈 state added

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onUpdateSelectedEmiIndex(index: widget.index);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:  AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected ? AppColors.primaryColor() : AppColors.greyE1,
            width: widget.isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.duration, style: Styles.tsBlack3BSemiBold18()),
                _radio(),
              ],
            ),

            10.h,

            /// Toggle only if selected
            if (widget.isSelected) _toggle(),

            if (widget.isSelected) 12.h,

            /// Amount Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${Strings.rupee}${widget.amount.formatData()}",
                        style: Styles.tsBlack3BBold26(),
                      ),
                      TextSpan(
                        text: widget.isSelected &&
                                widget.selectedEmiPlanType ==
                                    EmiPlanType.monthly.name
                            ? " /mo"
                            : " /wk",
                        style: Styles.tsGrey66Medium14(),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.rate, style: Styles.tsGrey4ARegular14()),
                    4.h,
                    Text(
                      "Interest: ${Strings.rupee}${widget.interest.formatData()}",
                      style: Styles.tsBlack3BMedium14(),
                    ),
                  ],
                ),
              ],
            ),

            if (widget.isSelected && widget.showBreakdown) ...[
              Divider(color: AppColors.greyE1,height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomItem("Principal",
                      "${Strings.rupee}${widget.principalAmount.formatData()}"),
                  const Text("+"),
                  _bottomItem(
                    "Interest",
                    "${Strings.rupee}${widget.interest.formatData()}",
                  ),
                  const Text("="),
                  _bottomItem(
                    "Total",
                    "${Strings.rupee}${widget.total.formatData()}",
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// ✅ Toggle (FIXED)
  Widget _toggle() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.greyE1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleItem(EmiPlanType.monthly.name, true),
          _toggleItem(EmiPlanType.weekly.name, false),
        ],
      ),
    );
  }

  Widget _toggleItem(String planType, bool value) {
    bool isSelected = widget.selectedEmiPlanType == planType;
    return GestureDetector(
      onTap: () {
        context.read<EmiBloc>().add(OnUpdateEmiPlanType(planType: planType));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor() : AppColors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          planType.capitalize(),
          style: isSelected
              ? Styles.tsWhiteSemiBold14()
              : Styles.tsBlack3BSemiBold14(),
        ),
      ),
    );
  }

  /// Radio UI
  Widget _radio() {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.isSelected ? AppColors.primaryColor() : AppColors.grey400,
          width: 2,
        ),
      ),
      child: widget.isSelected
          ? Center(
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor(),
                ),
              ),
            )
          : null,
    );
  }

  Widget _bottomItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: Styles.tsGrey4ARegular12()),
        2.h,
        Text(value, style: Styles.tsBlack3BBold14()),
      ],
    );
  }
}
