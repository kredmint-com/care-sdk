import 'package:flutter/material.dart';
import '../../../../../../widgets/common_widget.dart';
import '../../../../../themes/app_colors.dart';

class CreditOnboardingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreditOnboardingAppBar({
    super.key,
    this.title = "",
    this.onBackPressed,
  });

  final String title;
  final VoidCallback? onBackPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CommonWidget().customAppBar(
      title: title,
      onBackPressed: () {
        if (onBackPressed != null) {
          onBackPressed!.call();
        } else {
          Navigator.of(context).pop();
        }
      },
      backgroundColor: AppColors.white,
      leadingIconColor: Colors.black,
      // suffixWidget: [
      //   IconButton(
      //     onPressed: () {
      //       OnboardingBottomsheetWidget.showBottomSheetWidget(
      //         context: context,
      //         type: BottomSheetType.CONTACT_SUPPORT,
      //       );
      //     },
      //     icon: SvgPicture.asset(
      //       Images.contactHelp,
      //       height: 20,
      //       width: 20,
      //     ),
      //   ),
      //   IconButton(
      //     onPressed: () {
      //       OnboardingBottomsheetWidget.showBottomSheetWidget(
      //         context: context,
      //         type: BottomSheetType.EXIT,
      //       );
      //     },
      //     icon: SvgPicture.asset(
      //       Images.exit,
      //       height: 20,
      //       width: 20,
      //     ),
      //   ),
      // ],
    );
  }
}
