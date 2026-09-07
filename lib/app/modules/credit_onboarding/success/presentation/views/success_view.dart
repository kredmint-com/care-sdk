import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/payment_patch_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/success/presentation/bloc/success_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/success/presentation/bloc/success_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/success/presentation/bloc/success_state.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/utils/helper/date_extension.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/utils/helper/string_extension.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../injection_container.dart';
import '../../../../../../loan_sdk_package.dart';
import '../../../../../../utils/helper/enums.dart';
import '../../../../../data/models/dto/sdk_callback.dart';
import '../../../../../data/values/animation.dart';
import '../../../../../data/values/constants.dart';
import '../../../../../route/app_pages.dart';
import '../../../../../themes/styles.dart';
import '../../../credit_common_method.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/bloc/credit_onboarding_state.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({
    super.key,
    required this.profileId,
    required this.prevPageId,
    this.paymentDetails,
    this.isFinalStep = true,
    required this.pageId,
    required this.pageCategory,
    this.staticPageRes,
  });

  final String profileId;
  final String prevPageId;
  final PatchPaymentPayload? paymentDetails;
  final bool isFinalStep;
  final String? pageId;
  final String? pageCategory;
  final List<StaticPageRes?>? staticPageRes;

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  Timer? timer;

  Future<bool> handleBackPress() async {
    return CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    SdkBackHandler.onBackPressed = null;
  }

  void init() {
    if (!widget.isFinalStep) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        final remainingSeconds = 3 - timer.tick;
        context.read<SuccessBloc>().add(
              OnTimerCountChange(
                count: remainingSeconds,
              ),
            );
        if (timer.tick == 3) {
          timer.cancel();
          context.replaceNamed(
            Routes.sdkCreditOnboarding,
            extra: {"profileId": widget.profileId},
          );
        }
      });
    }
    SdkBackHandler.onBackPressed = handleBackPress;
    // if (widget.isFinalStep) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     context.read<SuccessBloc>().add(
    //           OnSuccess(
    //             pageId: widget.pageId,
    //             pageCategory: widget.pageCategory,
    //           ),
    //         );
    //   });
    // }
  }

  void _onProceed() {
    if (widget.isFinalStep) {
      getIt<SdkCallbacks>().onSuccess?.call(
            message: "Loan applied successfully",
            status: ProfileStatus.PROFILE_COMPLETED.name,
            invoiceNo: (widget.staticPageRes?.isEmpty ?? true)
                ? ""
                : widget.staticPageRes?.first?.invoiceId ?? "",
          );
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      context.replaceNamed(
        Routes.sdkCreditOnboarding,
        extra: {"profileId": widget.profileId},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackPress,
      child: Scaffold(
        bottomSheet: Wrap(
          children: [
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (!widget.isFinalStep) ...[
                        BlocBuilder<SuccessBloc, SuccessState>(
                          builder: (context, state) {
                            return Text(Strings.redirectMessage(
                                remainingSeconds:
                                    state.remainingSeconds?.toString() ?? ""));
                          },
                        ),
                        12.h,
                      ],
                      CustomButton(
                        onTap: _onProceed,
                        buttonText: Strings.proceed,
                      ),
                    ],
                  )),
            ),
          ],
        ),
        body: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    final screenHeight = MediaQuery.of(context).size.height;
    const circleSize = 180.0;

    return MultiBlocListener(
      listeners: [
        BlocListener<SuccessBloc, SuccessState>(
          listenWhen: (previous, current) =>
              previous.userProfileStageMapCompleted !=
                  current.userProfileStageMapCompleted &&
              current.userProfileStageMapCompleted == true,
          listener: (context, state) {
            context.read<CreditOnboardingBloc>().add(
                  coe.OnUpdateUserProfileStage(
                    data: state.userProfileStageMap,
                    profileId: widget.profileId,
                  ),
                );
            context.read<SuccessBloc>().add(
                  OnResetUserProfileStageMapCompleted(),
                );
          },
        ),
        BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
          listenWhen: (previous, current) =>
              previous.userProfileStageUpdated !=
                  current.userProfileStageUpdated &&
              current.userProfileStageUpdated == true,
          listener: (context, state) {
            context.read<CreditOnboardingBloc>().add(coe.OnReset());
          },
        ),
      ],
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.32,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6FCF97), Color(0xFF56CC8A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.22),
              constraints: BoxConstraints(minHeight: screenHeight * 0.78),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F5F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6),
                  color: Colors.white,
                ),
                child: Lottie.asset(
                  Animations.review,
                  package: Constants.packageName,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: screenHeight * 0.12 + circleSize + 30,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.paymentDetails?.title ?? Strings.congratulations,
                    style: Styles.tsBlack3BBold26(),
                    textAlign: TextAlign.center,
                  ),
                  12.h,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      widget.paymentDetails?.subTitle ??
                          Strings
                              .yourLoanApplicationHasBeenApprovedSuccessfully,
                      textAlign: TextAlign.center,
                      style: Styles.tsBlack3BRegular16().copyWith(
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (widget.paymentDetails != null) ...[
                    24.h,
                    _transactionDetailsCard(
                        widget.paymentDetails ?? PatchPaymentPayload()),
                  ],
                  100.h,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionDetailsCard(PatchPaymentPayload details) {
    final formattedDate = details.paidAt != null
        ? DateTime.fromMillisecondsSinceEpoch((details.paidAt ?? 0).toInt())
            .formatDateWithTime()
        : null;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1E1E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.description_outlined,
                size: 16,
                color: AppColors.black,
              ),
              4.w,
              Text(
                Strings.transactionDetails,
                style: Styles.tsBlack3BSemiBold16(),
              ),
            ],
          ),
          16.h,
          if (details.amount != null)
            _detailColumn(
              Strings.amount,
              "${Strings.rupee}${details.amount.toString().formatData()}",
            ),
          if (details.modeOfPayment != null) ...[
            Divider(
              height: 16,
              color: AppColors.greyE1,
            ),
            _detailColumn(Strings.modeOfPayment, details.modeOfPayment ?? ""),
          ],
          if (details.transactionRefId != null) ...[
            Divider(
              height: 16,
              color: AppColors.greyE1,
            ),
            _detailColumn(
                Strings.transactionReferenceId, details.transactionRefId ?? "",
                showCopyIcon: true),
          ],
          if (details.utr != null) ...[
            Divider(
              height: 16,
              color: AppColors.greyE1,
            ),
            _detailColumn(Strings.utr, details.utr ?? "", showCopyIcon: true),
          ],
          if (details.refNo != null) ...[
            Divider(
              height: 16,
              color: AppColors.greyE1,
            ),
            _detailColumn(Strings.referenceNumber, details.refNo ?? "",
                showCopyIcon: true),
          ],
          if (formattedDate != null) ...[
            Divider(
              height: 16,
              color: AppColors.greyE1,
            ),
            _detailColumn(Strings.paidAt, formattedDate),
          ],
        ],
      ),
    );
  }

  Widget _detailColumn(String label, String value,
      {bool showCopyIcon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.tsGrey4ARegular14()),
        4.h,
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: Styles.tsBlack3BSemiBold14(),
              ),
            ),
            Visibility(
              visible: showCopyIcon,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: value));
                      Fluttertoast.showToast(
                        msg: Strings.copiedToClipboard,
                      );
                    },
                    child: Icon(
                      Icons.copy,
                      color: AppColors.grey,
                      size: 16,
                    )),
              ),
            )
          ],
        ),
      ],
    );
  }
}
