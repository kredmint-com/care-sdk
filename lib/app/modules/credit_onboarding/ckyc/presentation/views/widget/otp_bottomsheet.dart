import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';

import '../../../../../../../utils/helper/otp_text_field.dart';
import '../../../../../../../utils/helper/sizedbox_extension.dart';
import '../../../../../../data/values/strings.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({
    super.key,
    required this.onUpdateTimer,
    required this.otpTimer,
    required this.mobileNumber,
    required this.onVerifyOtp,
    required this.onDigioKyc,
    required this.showDigioKycButton,
    required this.onResendOtp,
    required this.otp,
    required this.onOtpChange,
  });

  final Function({required int val}) onUpdateTimer;
  final int otpTimer;
  final String mobileNumber;
  final String otp;
  final Function({required String val}) onVerifyOtp;
  final Function({required String val}) onOtpChange;
  final VoidCallback onDigioKyc;
  final bool showDigioKycButton;
  final VoidCallback onResendOtp;

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final TextEditingController otpController = TextEditingController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startOtpTimer();
  }

  void startOtpTimer() {
    debugPrint("showDigioKycButton : ${widget.showDigioKycButton}");
    int count = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      count--;
      if (mounted) {
        widget.onUpdateTimer(
          val: count,
        );
      }
      if (count == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Title
              Text(
                'Enter your OTP',
                style: Styles.tsBlack3BSemiBold28(),
              ),

              12.h,

              // Mobile number
              Text(
                'Sent to +91${widget.mobileNumber}',
                style: TextStyle(
                  color: Color(0xFF465066),
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              // OTP
              OtpTextField(
                textEditingController: otpController,
                onChanged: ({required String val}) {
                  widget.onOtpChange(
                    val: val,
                  );
                },
                errorText: "",
              ),

              // Timer / Resend
              (widget.otpTimer) > 0
                  ? Padding(
                      padding: EdgeInsetsGeometry.only(
                        bottom: 10,
                        top: 28,
                      ),
                      child: Text.rich(
                        TextSpan(
                            text: Strings.didNotReceiveTheOtpRetryIn,
                            style: Styles.tsBlack3BRegular14Opacity(),
                            children: [
                              const WidgetSpan(
                                child: SizedBox(
                                    width: 5), // This adds 10 pixels of space
                              ),
                              TextSpan(
                                text: widget.otpTimer.toString(),
                                style: Styles.tsBlack3BBold42Opacity(),
                              ),
                              const WidgetSpan(
                                child: SizedBox(
                                    width: 5), // This adds 10 pixels of space
                              ),
                              TextSpan(
                                text: widget.otpTimer > 1
                                    ? Strings.seconds
                                    : Strings.second,
                                style: Styles.tsBlack3BRegular14Opacity(),
                              ),
                            ]),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsetsGeometry.only(top: 12),
                      child: TextButton(
                        onPressed: () {
                          widget.onResendOtp();
                          startOtpTimer();
                        },
                        child: Text(
                          'Resend OTP',
                          style: Styles.tsBlue24Regular14Underline(),
                        ),
                      ),
                    ),

              12.h,
              // Verify button
              CustomButton(
                disabled: widget.otp.length < 6,
                onTap: () {
                  widget.onVerifyOtp(
                    val: otpController.text,
                  );
                },
                buttonText: 'Verify OTP',
                borderColor: AppColors.transparent,
              ),
              if (widget.showDigioKycButton) ...[
                12.h,
                CustomButton(
                  onTap: widget.onDigioKyc,
                  buttonText: 'Proceed with Manual Kyc',
                  buttonColor: AppColors.transparent,
                  borderColor: AppColors.headingColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
