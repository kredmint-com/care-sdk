import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/data/values/images.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../../widgets/custom_button.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/styles.dart';

class PanBottomSheetWidget extends StatelessWidget {
  const PanBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(Images.panExit),
          ),

          Text(
            Strings.areYouSureYouWantToExit,
            style: Styles.tsBlack3BSemiBold16(),
            textAlign: TextAlign.center,
          ),
          8.h,

          Text(
            Strings.dontWorryYourProgressIsSavedAndYoullPickUpWhereYouLeftOff,
            style: Styles.tsBlack3BMedium12(),
            textAlign: TextAlign.center,
          ),
          24.h,

          CustomButton(
            onTap: (){
              context.pop();
            },
            buttonText: Strings.no,
            buttonTextStyle: Styles.tsBlue24Medium14(),
            buttonColor: AppColors.blueEA,
            buttonRadius: BorderRadius.circular(25),
            buttonPadding: EdgeInsets.symmetric(vertical: 10),
          ),

          16.h,

          CustomButton(
            onTap: (){},
            buttonText: Strings.yesIWillDoItLater,
            buttonTextStyle: Styles.tsWhiteMedium14(),
            buttonColor: AppColors.blue24,
            buttonRadius: BorderRadius.circular(25),
            buttonPadding: EdgeInsets.symmetric(vertical: 10),
          ),

        ],
      ),
    );
  }
}
