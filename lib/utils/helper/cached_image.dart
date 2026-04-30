// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../app/route/app_pages.dart';
// import '../../app/themes/app_colors.dart';
//
// class CachedImage extends StatelessWidget {
//   const CachedImage({
//     super.key,
//     required this.imageUrl,
//     this.height,
//     this.width,
//     this.radius = 10,
//     this.boxFit,
//     this.errorImage,
//   });
//
//   final String imageUrl;
//   final double? height;
//   final double? width;
//   final double radius;
//   final BoxFit? boxFit;
//   final String? errorImage;
//
//   static ImageProvider provider(String url) {
//     return CachedNetworkImageProvider(url);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return CachedNetworkImage(
//         imageUrl: imageUrl,
//         imageBuilder: (context, imageProvider) => Container(
//               height: height,
//               width: width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(radius),
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: boxFit ?? BoxFit.cover,
//                 ),
//               ),
//             ),
//         placeholder: (context, url) => SizedBox(
//               height: height,
//               width: width ?? size.width,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(radius),
//                 child: Shimmer.fromColors(
//                   baseColor: AppColors.baseColor,
//                   highlightColor: AppColors.highLightColor,
//                   child: Container(
//                     width: size.width,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//         errorWidget: (context, url, error) {
//             if (errorImage != null) {
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(radius),
//                 child: Image.asset(
//                   errorImage!,
//                   height: height,
//                   width: double.infinity,
//                   fit: boxFit ?? BoxFit.cover,
//                 ),
//               );
//             }
//             debugPrint(
//                 "Cached error url : $url $error... ${AppPages.router.routerDelegate.state.path}");
//             return Icon(
//               Icons.image_outlined,
//               size: height,
//             );
//         });
//   }
// }
