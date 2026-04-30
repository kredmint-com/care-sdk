// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pinput/pinput.dart';
// import '../../app/themes/app_colors.dart';
// import '../../app/themes/styles.dart';
//
// class OtpTextField extends StatelessWidget {
//   const OtpTextField({
//     super.key,
//     required this.textEditingController,
//     required this.onComplete,
//     required this.errorText,
//   });
//
//   final TextEditingController textEditingController;
//   final VoidCallback onComplete;
//   final String errorText;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SizedBox(
//         width: size.width * 0.7,
//         child: Pinput(
//           autofocus: true,
//           controller: textEditingController,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           defaultPinTheme: PinTheme(
//               width: 56,
//               height: 56,
//               textStyle: Styles.tsBlack3BMedium18(),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.grey),
//                 borderRadius: BorderRadius.circular(15),
//               )),
//           focusedPinTheme: PinTheme(
//               width: 56,
//               height: 56,
//               textStyle: Styles.tsBlack3BMedium18(),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.blue8C),
//                 borderRadius: BorderRadius.circular(15),
//               )),
//           errorPinTheme: PinTheme(
//             width: 56,
//             height: 56,
//             textStyle: Styles.tsBlack3BMedium18(),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.red),
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//           errorText: errorText.isEmpty ? null : errorText,
//           pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//           showCursor: true,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           onCompleted: (pin) {
//             onComplete();
//           },
//         ));
//   }
// }
