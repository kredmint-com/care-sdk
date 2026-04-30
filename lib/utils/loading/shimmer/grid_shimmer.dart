// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../app/themes/app_colors.dart';
//
// class GridviewShimmer extends StatelessWidget {
//   const GridviewShimmer(
//       {super.key, this.mainAxisSpacing = 20.0, this.crossAxisSpacing = 20.0});
//
//   final double mainAxisSpacing;
//   final double crossAxisSpacing;
//
//   @override
//   Widget build(BuildContext context) {
//     return StaggeredGrid.count(
//         crossAxisCount: 2,
//         crossAxisSpacing: crossAxisSpacing,
//         mainAxisSpacing: mainAxisSpacing,
//         children: List.generate(20, (index) {
//           return  Shimmer.fromColors(
//             baseColor: AppColors.baseColor,
//             highlightColor: AppColors.highLightColor,
//             child: Container(
//               height: 150,
//               // width: 100,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 10,
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     offset: const Offset(0, 3),
//                   )
//                 ],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//         }));
//   }
// }
