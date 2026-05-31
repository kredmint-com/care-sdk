import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

class ReviewDetailWidget extends StatelessWidget {
  const ReviewDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blueD3),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: AppColors.blueF0F,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.whatsNext,
              style: Styles.tsBlack3BMedium14(),
            ),
            16.h,
            detailTile(text: Strings.reviewDescription1),
            16.h,
            detailTile(text: Strings.reviewDescription2),
            16.h,
            detailTile(text: Strings.reviewDescription3),
          ],
        ),
      ),
    );
  }

  Widget detailTile({required String text}) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black3B,
          ),
        ),
        10.w,
        Expanded(
            child: Text(
          text,
          style: Styles.tsBlackRegular12(),
        ))
      ],
    );
  }
}
