import 'package:flutter/material.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app/themes/app_colors.dart';

class RechargeStatusShimmer extends StatelessWidget {
  const RechargeStatusShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.highLightColor,
      ),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highLightColor,
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
          14.h,
          Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highLightColor,
            child: Container(
              height: 15,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
              ),
            ),
          ),
          10.h,
          Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highLightColor,
            child: Container(
              height: 30,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
              ),
            ),
          ),
          14.h,
          Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highLightColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                8.w,
                Container(
                  height: 15,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
