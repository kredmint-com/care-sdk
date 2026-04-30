// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../app/themes/app_colors.dart';
//
// class CachedSvgImage extends StatelessWidget {
//   final String url;
//
//   const CachedSvgImage({
//     super.key,
//     required this.url,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<File>(
//       future: DefaultCacheManager().getSingleFile(url),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             snapshot.hasData) {
//           return SvgPicture.file(snapshot.data!);
//         } else if (snapshot.hasError) {
//           return const Icon(Icons.error);
//         } else {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: Shimmer.fromColors(
//               baseColor: AppColors.baseColor,
//               highlightColor: AppColors.highLightColor,
//               child: Container(
//                 color: Colors.white,
//               ),
//             ),
//           );
//         }
//       },
//
//     );
//   }
// }
