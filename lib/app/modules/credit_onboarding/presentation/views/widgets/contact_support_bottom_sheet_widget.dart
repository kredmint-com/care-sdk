// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
// // import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../../data/values/images.dart';
// import '../../../../../data/values/strings.dart';
// import '../../../../../themes/app_colors.dart';
// import '../../../../../themes/styles.dart';
//
// class ContactSupportBottomSheetWidget extends StatelessWidget {
//   const ContactSupportBottomSheetWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 20),
//             child: Image.asset(Images.panExit),
//           ),
//
//           Text(
//             Strings.forAnySupportContact,
//             style: Styles.tsBlack3BSemiBold16(),
//             textAlign: TextAlign.center,
//           ),
//           8.h,
//
//           Text(
//             Strings.needHelpWeAreHereToAssistYouWithAnythingYouNeed,
//             style: Styles.tsBlack3BMedium12(),
//             textAlign: TextAlign.center,
//           ),
//
//           24.h,
//
//           _supportOptionTile(
//             title: Strings.callSupport,
//             subtitle: Strings.phoneNumber + Strings.phoneNumberValue,
//             iconPath: Images.call,
//             onTap: () => _launchPhone(Strings.phoneNumberValue),
//           ),
//           12.h,
//           _supportOptionTile(
//             title: Strings.emailSupport,
//             subtitle: Strings.mailOn + Strings.mailAddress,
//             iconPath: Images.mail,
//             onTap: () => _launchEmail(Strings.mailAddress),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _supportOptionTile({
//     required String title,
//     required String subtitle,
//     required String iconPath,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.blueF0,
//           borderRadius: BorderRadius.circular(9),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: Styles.tsBlack3BSemiBold12(),
//                     textAlign: TextAlign.center,
//                   ),
//                   4.h,
//                   Text(
//                     subtitle,
//                     style: Styles.tsBlack3BRegular12(),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               SvgPicture.asset(iconPath),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _launchPhone(String phoneNumber) async {
//     final Uri url = Uri(scheme: 'tel', path: phoneNumber);
//     if (!await launchUrl(url)) {
//       debugPrint('Could not launch $url');
//     }
//   }
//
//   void _launchEmail(String email) async {
//     final Uri url = Uri(scheme: 'mailto', path: email);
//     if (!await launchUrl(url)) {
//       debugPrint('Could not launch $url');
//     }
//   }
// }
