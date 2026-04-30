import 'package:flutter/material.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/themes/app_colors.dart';

class PaymentStatusTrackShimmer extends StatelessWidget {
  const PaymentStatusTrackShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.highLightColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: List.generate(
              3,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(top: (index == 0) ? 0.0 : 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.baseColor,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: AppColors.baseColor,
                              highlightColor: AppColors.highLightColor,
                              child: Icon(
                                Icons.check,
                                size: 15,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (index < 2),
                            child: Positioned(
                              bottom: -27,
                              child: Shimmer.fromColors(
                                baseColor: AppColors.baseColor,
                                highlightColor: AppColors.highLightColor,
                                child: Container(
                                  height: 28,
                                  width: 1,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      12.w,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColors.baseColor,
                            highlightColor: AppColors.highLightColor,
                            child: Container(
                              height: 15,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          5.h,
                          Shimmer.fromColors(
                            baseColor: AppColors.baseColor,
                            highlightColor: AppColors.highLightColor,
                            child: Container(
                              height: 15,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
