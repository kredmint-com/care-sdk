// import 'package:flutter/material.dart';
//
// import '../../../../../../utils/helper/enums.dart';
// import 'contact_support_bottom_sheet_widget.dart';
// import 'pan_bottom_sheet_widget.dart';
//
// class OnboardingBottomsheetWidget {
//   static Widget widgetForBottomSheet({
//     required BottomSheetType type,
//   }) {
//     Widget widget = const SizedBox();
//
//     switch (type) {
//       case BottomSheetType.CONTACT_SUPPORT:
//         widget = const ContactSupportBottomSheetWidget();
//         break;
//       case BottomSheetType.EXIT:
//         widget = const PanBottomSheetWidget();
//         break;
//     }
//
//     return widget;
//   }
//
//   static Future<void> showBottomSheetWidget({
//     required BuildContext context,
//     required BottomSheetType type,
//   }) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) => widgetForBottomSheet(type: type),
//     );
//   }
// }
//
