import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';

import '../../../../../../utils/helper/sizedbox_extension.dart';
import '../../../../../data/values/strings.dart';

class DetailMismatchBottomsheet extends StatelessWidget {
  final VoidCallback? onProceed;
  final VoidCallback? onCrossTap;
  final String mismatchText;
  final String? changeDetailsText;
  final String? trustText;
  final VoidCallback? onCancelTap;

  const DetailMismatchBottomsheet({
    super.key,
    this.onProceed,
    this.onCrossTap,
    required this.mismatchText,
    this.changeDetailsText,
    this.trustText,
    this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                children: [
                  if (onCrossTap != null) ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: onCrossTap,
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    4.h,
                  ],
                  Container(
                    height: 112,
                    width: 112,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.yellowFFF7,
                    ),
                    child: Center(
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.yellowE5,
                            width: 5,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '!',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: AppColors.yellowE5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  32.h,
                  Text(
                    Strings.verificationFailed,
                    textAlign: TextAlign.center,
                    style: Styles.tsPrimaryBold24(),
                  ),
                  28.h,
                  Text(
                    mismatchText,
                    textAlign: TextAlign.center,
                    style: Styles.tsGrey4ARegular14(),
                  ),
                  22.h,
                  if (changeDetailsText?.isNotEmpty ?? false) ...[
                    Text(
                      changeDetailsText ?? "",
                      textAlign: TextAlign.center,
                      style: Styles.tsBlack3BSemiBold20(),
                    ),
                    32.h,
                  ],
                  if (trustText?.isNotEmpty ?? false) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 22,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue1F7,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: AppColors.primaryColor(),
                          ),
                          12.w,
                          Expanded(
                            child: Text(
                              trustText ?? "",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (onProceed != null) ...[
                    32.h,
                    CustomButton(
                      onTap: onProceed!,
                      buttonText: Strings.proceedAnyway,
                    ),
                  ],
                  if (onCancelTap != null) ...[
                    32.h,
                    CustomButton(
                      onTap: onCancelTap!,
                      buttonText: Strings.cancel,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
