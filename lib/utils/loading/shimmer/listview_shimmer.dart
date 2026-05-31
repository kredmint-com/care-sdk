import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/themes/app_colors.dart';

class ListviewShimmer extends StatelessWidget {
  const ListviewShimmer(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      // required this.listViewHeight,
      // required this.listViewWidth,
      this.scrollDirection,
      required this.containerPadding,
      this.primaryBorderRadius,
      this.secondaryBorderRadius});

  final double containerHeight;
  final double containerWidth;
  // final double listViewHeight;
  // final double listViewWidth;
  final Axis? scrollDirection;
  final EdgeInsets containerPadding;
  final double? primaryBorderRadius;
  final double? secondaryBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(primaryBorderRadius ?? 0)),
      // width: listViewWidth,
      // height: listViewHeight,
      child: ListView.builder(
          itemCount: 20,
          scrollDirection: scrollDirection ?? Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (index, context) {
            return Padding(
              padding: containerPadding,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(secondaryBorderRadius ?? 0),
                child: Shimmer.fromColors(
                    baseColor: AppColors.baseColor,
                    highlightColor: AppColors.highLightColor,
                    child: Container(
                      height: containerHeight,
                      width: containerWidth,
                      color: AppColors.white,
                    )),
              ),
            );
          }),
    );
  }
}
