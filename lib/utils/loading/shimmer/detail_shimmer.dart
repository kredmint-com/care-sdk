import 'package:flutter/material.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app/themes/app_colors.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highLightColor,
          child: Container(
            height: 10,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
          ),
        ),
        12.h,
        Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.highLightColor,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailWidget(),
                    detailWidget(
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
                24.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailWidget(),
                    detailWidget(
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }

  Widget detailWidget({
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    bool showCopyIcon = false,
  }) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highLightColor,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Container(
            height: 15,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
          ),
          8.h,
          Container(
            height: 15,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
