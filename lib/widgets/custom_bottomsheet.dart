// import 'package:flutter/material.dart';
//
// import '../app/data/models/dto/bottomsheet_data_dto.dart';
// import '../app/themes/app_colors.dart';
// import '../app/themes/styles.dart';
// import '../utils/helper/cached_image.dart';
// import '../utils/helper/common_method.dart';
//
// class CustomBottomsheet extends StatelessWidget {
//   const CustomBottomsheet({
//     super.key,
//     required this.heading,
//     required this.dataList,
//     required this.onTileTap,
//     required this.onCrossTap,
//     this.selectedValue,
//   });
//
//   final String heading;
//   final List<BottomSheetDataDto>? dataList;
//   final Function({
//     required String data,
//     String? data2,
//     String? data3,
//   }) onTileTap;
//   final VoidCallback onCrossTap;
//   final String? selectedValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 14.0,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   heading,
//                   style: Styles.tsBlack3BSemiBold16(),
//                 ),
//                 IconButton(
//                     onPressed: onCrossTap,
//                     icon: Icon(
//                       Icons.clear,
//                       size: 30,
//                       color: AppColors.greyB5,
//                     ))
//               ],
//             ),
//           ),
//           ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: MediaQuery.of(context).size.height * 0.5,
//             ),
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               shrinkWrap: true,
//               itemCount: (dataList?.length) ?? 0,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   tileColor: ((selectedValue?.isNotEmpty ?? false) &&
//                           (selectedValue == dataList?[index].data))
//                       ? AppColors.primaryColor().withOpacity(0.3)
//                       : null,
//                   onTap: () {
//                     onTileTap(
//                       data: dataList?[index].data ?? "",
//                       data2: dataList?[index].data2 ?? "",
//                       data3: dataList?[index].text ?? "",
//                     );
//                   },
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                   leading: (dataList?[index].icon?.isEmpty ?? true)
//                       ? null
//                       : Container(
//                           height: 36,
//                           width: 36,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: CachedImage(
//                             imageUrl: CommonMethod.getCompressedUrl(
//                               originalImageUrl: dataList?[index].icon ?? "",
//                               imageHeight: "36",
//                             ),
//                             radius: 30,
//                           ),
//                         ),
//                   title: Text(
//                     dataList?[index].text ?? "",
//                     style: Styles.tsBlack3BRegular14(),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
