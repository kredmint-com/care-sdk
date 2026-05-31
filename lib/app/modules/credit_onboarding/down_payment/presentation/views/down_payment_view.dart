import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/utils/helper/string_extension.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';

class DownPaymentView extends StatefulWidget {
  const DownPaymentView({
    super.key,
    required this.profileId,
    required this.prevPageId,
    required this.pageId,
    required this.pageCategory,
    required this.page,
    required this.processingFeeData,
  });

  final String pageId;
  final String pageCategory;
  final String profileId;
  final String prevPageId;
  final StepsPage? page;
  final ProcessingFeeData? processingFeeData;

  @override
  State<DownPaymentView> createState() => _DownPaymentViewState();
}

class _DownPaymentViewState extends State<DownPaymentView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
  }

  @override
  void dispose() {
    super.dispose();
    SdkBackHandler.onBackPressed = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
      bottomSheet: _bottomSheet(),
      body: WillPopScope(
        onWillPop: handleBackPress,
        child: MultiBlocListener(
          listeners: [
            /// 🔹 Credit onboarding listener
            BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
              listenWhen: (prev, curr) =>
                  prev.userProfileStageUpdated != curr.userProfileStageUpdated,
              listener: (context, state) {
                if (state.userProfileStageUpdated == true) {
                  context.replaceNamed(
                    Routes.sdkCreditOnboarding,
                    extra: {"profileId": widget.profileId},
                  );

                  context.read<CreditOnboardingBloc>().add(coe.OnReset());
                }
              },
            ),

            /// 🔹 Payment success listener
            BlocListener<DownPaymentBloc, DownPaymentState>(
              listenWhen: (prev, curr) =>
                  prev.paymentSuccessfull != curr.paymentSuccessfull,
              listener: (context, state) {
                if (state.paymentSuccessfull == true) {
                  context.read<DownPaymentBloc>().add(
                        OnPatchDownPayment(
                          pageId: widget.pageId,
                          pageCategory: widget.pageCategory,
                          paymentPatchResponse: state.paymentPatchResponse,
                        ),
                      );

                  context.read<DownPaymentBloc>().add(OnReset());
                }
              },
            ),

            /// 🔹 Profile update listener
            BlocListener<DownPaymentBloc, DownPaymentState>(
              listenWhen: (prev, curr) =>
                  prev.userProfileStageMapCompleted !=
                  curr.userProfileStageMapCompleted,
              listener: (context, state) {
                if (state.userProfileStageMapCompleted == true) {
                  context.read<CreditOnboardingBloc>().add(
                        coe.OnUpdateUserProfileStage(
                          data: state.userProfileStageMap,
                          profileId: widget.profileId,
                        ),
                      );

                  context.read<DownPaymentBloc>().add(
                        OnResetUserProfileStageMapCompleted(),
                      );
                }
              },
            ),
          ],
          child: _body(),
        ),
      ),
    );
  }

  /// 🔹 Back handler
  Future<bool> handleBackPress() async {
    return await CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  /// 🔹 Bottom CTA
  Widget _bottomSheet() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<DownPaymentBloc, DownPaymentState>(
            builder: (context, state) {
              return CustomButton(
                onTap: () {
                  if (widget.processingFeeData?.pgEnable ?? false) {
                    context.read<DownPaymentBloc>().add(
                          OnPay(
                            amount: widget
                                    .processingFeeData?.pgOrderRequest?.amount
                                    ?.toString() ??
                                "",
                            lenderId: widget.processingFeeData?.pgOrderRequest
                                    ?.lenderId ??
                                "",
                            profileId: widget.profileId,
                            paymentType: widget.processingFeeData
                                    ?.pgOrderRequest?.paymentType ??
                                "",
                          ),
                        );
                  }
                },
                buttonText:
                    "${Strings.proceed} with ${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}",
              );
            },
          ),
        ),
      ],
    );
  }

  /// 🔹 Main UI
  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(
            heading: widget.page?.heading?.title ?? "",
            subHeading: widget.page?.heading?.subTitle ?? "",
            iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                ? (widget.page?.heading?.appLogo ?? "")
                : ((widget.page?.heading?.pageLogo) ?? ""),
          ),
          12.h,
          _paymentCard(),
        ],
      ),
    );
  }

  /// 🔹 Payment Card
  Widget _paymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.paymentSummary, style: Styles.tsBlack3BBold18()),
              GestureDetector(
                onTap: handleBackPress,
                child: Text(
                  Strings.changePlan,
                  style: Styles.tsPrimaryMedium14(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Inner card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F5F8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _amountColumn(
                      title: Strings.payNow,
                      amount:
                          "${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}",
                      subtitle: Strings.downPayment,
                    ),
                    Text("+", style: Styles.tsGrey4ABold20()),
                    _amountColumn(
                      title: Strings.emi,
                      amount:
                          "${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}",
                      subtitle:
                          "${Strings.multiply}${widget.processingFeeData?.tenure} ${(widget.processingFeeData?.tenureType?.toLowerCase() == EmiPlanType.monthly.name) ? Strings.months : Strings.weeks}",
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.withOpacity(0.3)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.totalPayable,
                      style: Styles.tsGrey4ARegular14(),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${Strings.rupee}${widget.processingFeeData?.totalPayable?.toString().formatData() ?? ""}",
                          style: Styles.tsBlack3BBold18(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountColumn({
    required String title,
    required String amount,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Styles.tsGrey4ASemiBold12()),
        const SizedBox(height: 4),
        Text(amount, style: Styles.tsBlack3BBold20()),
        const SizedBox(height: 4),
        Text(subtitle, style: Styles.tsGrey4ARegular12()),
      ],
    );
  }
}
