// import 'package:flutter/material.dart';
// import '../utils/helper/cached_image.dart';
// import '../app/data/values/urls.dart';
//
// class PreviousRechargeWidget extends StatelessWidget {
//   const PreviousRechargeWidget({
//     super.key,
//     required this.account,
//     required this.onPayNowTap,
//     this.onManageTap,
//   });
//
//   final BillPayload? account;
//   final VoidCallback onPayNowTap;
//   final VoidCallback? onManageTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onPayNowTap();
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(11),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.greyF2,
//                 offset: const Offset(0, 1),
//                 blurRadius: 5.4,
//                 spreadRadius: 0,
//               )
//             ]
//             // border: Border.all(color: AppColors.whiteED),
//             ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image
//             Container(
//               height: 33,
//               width: 33,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: CachedImage(
//                 imageUrl: CommonMethod.getCompressedUrl(
//                   originalImageUrl: Urls.mobileOperator(
//                     opId: account?.opId?.toString() ?? "",
//                   ),
//                   imageHeight: "33",
//                 ),
//                 radius: 30,
//               ),
//             ),
//             16.w,
//
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     (account?.nickName?.isNotEmpty ?? false)
//                         ? (account?.nickName ?? "")
//                         : (account?.opName ?? ""),
//                     style: Styles.tsBlack3BSemiBold12(),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   4.h,
//                   Text(
//                     account?.number ?? "",
//                     style: Styles.tsBlack3BRegular12(),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   8.h,
//                   Text(
//                     (account?.paid ?? false)
//                         ? (account?.billAmount == null ||
//                                 (account?.billAmount ?? 0) < 1)
//                             ? Strings.billAlreadyPaid
//                             : "${Strings.paidTheBillOfAmount} ${Strings.rupee}${account?.billAmount}"
//                         : "₹${account?.billAmount ?? '0'} - ${Strings.pendingPayment}",
//                     style: (account?.paid ?? false)
//                         ? Styles.tsGrey70Medium11()
//                         : Styles.tsRedCCSemiBold11(),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   )
//                 ],
//               ),
//             ),
//
//             GestureDetector(
//               onTap: onManageTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Icon(
//                   Icons.more_vert,
//                   color: AppColors.black3B,
//                   size: 24,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
