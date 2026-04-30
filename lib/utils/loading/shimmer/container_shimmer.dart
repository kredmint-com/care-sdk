import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/themes/app_colors.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({
    super.key,
    required this.containerHeight,
    required this.containerWidth,  this.borderRadius,
  });

  final double containerHeight;
  final double containerWidth;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.baseColor,
        highlightColor: AppColors.highLightColor,
        child: Container(
          clipBehavior: Clip.none,
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 0)
          ),
        ));
  }
}
