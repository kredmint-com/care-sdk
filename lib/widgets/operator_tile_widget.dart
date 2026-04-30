// import 'package:flutter/material.dart';
// import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
// import '../app/data/values/strings.dart';
// import '../app/themes/app_colors.dart';
// import '../app/themes/styles.dart';
// import '../utils/helper/cached_image.dart';
// import '../utils/helper/common_method.dart';
//
// class OperatorTileWidget extends StatelessWidget {
//   const OperatorTileWidget({
//     super.key,
//     required this.operatorImageUrl,
//     required this.title,
//     this.onRechargeTap,
//     this.showIconButton = false,
//     this.operatorName,
//     this.createdOn,
//     this.showBorder = false,
//     this.onManageTap,
//     this.nickName,
//   });
//
//   final String operatorImageUrl;
//   final String title;
//   final String? operatorName;
//   final String? createdOn;
//   final String? nickName;
//   final VoidCallback? onRechargeTap;
//   final bool showIconButton;
//   final bool showBorder;
//   final VoidCallback? onManageTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onRechargeTap?.call(),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.transparent,
//           border: showBorder
//               ? Border.all(
//                   width: 1,
//                   color: AppColors.whiteEA,
//                   style: BorderStyle.solid,
//                 )
//               : null,
//           borderRadius: BorderRadius.circular(11),
//         ),
//         padding: showBorder
//             ? const EdgeInsets.all(12)
//             : const EdgeInsets.symmetric(vertical: 16),
//         child: Row(
//           crossAxisAlignment:
//               showBorder ? CrossAxisAlignment.start : CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 40,
//               width: 40,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: CachedImage(
//                 imageUrl: CommonMethod.getCompressedUrl(
//                   originalImageUrl: operatorImageUrl,
//                   imageHeight: "40",
//                 ),
//                 radius: 30,
//               ),
//             ),
//             12.w,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if ((nickName?.isNotEmpty ?? false) ||
//                       operatorName != null) ...[
//                     Text(
//                       (nickName?.isNotEmpty ?? false)
//                           ? nickName!
//                           : operatorName!,
//                       style: Styles.tsBlack3BSemiBold12(),
//                     ),
//                     4.h,
//                   ],
//                   Text(
//                     title,
//                     style: Styles.tsBlack3BRegular14(),
//                   ),
//                   if (createdOn != null) ...[
//                     8.h,
//                     Text(
//                       "${Strings.createdOn} $createdOn",
//                       style: Styles.tsGrey70Regular11(),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             if (showIconButton) ...[
//               GestureDetector(
//                 onTap: onManageTap,
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Icon(
//                     Icons.more_vert,
//                     color: AppColors.black3B,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
