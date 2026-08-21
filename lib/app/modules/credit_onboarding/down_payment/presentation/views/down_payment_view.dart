// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_bloc.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_event.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_state.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
// import 'package:loan_sdk_package/app/themes/app_colors.dart';
// import 'package:loan_sdk_package/app/themes/styles.dart';
// import 'package:loan_sdk_package/utils/helper/enums.dart';
// import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
// import 'package:loan_sdk_package/utils/helper/string_extension.dart';
//
// import '../../../../../../loan_sdk_package.dart';
// import '../../../../../../widgets/custom_button.dart';
// import '../../../../../data/values/strings.dart';
// import '../../../../../route/app_pages.dart';
// import '../../../credit_common_method.dart';
// import '../../../data/models/onboarding_steps_response.dart';
// import '../../../presentation/bloc/credit_onboarding_bloc.dart';
// import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
// import '../../../presentation/views/widgets/header_widget.dart';
// import '../../../presentation/views/widgets/onboarding_app_bar.dart';
//
// class DownPaymentView extends StatefulWidget {
//   const DownPaymentView({
//     super.key,
//     required this.profileId,
//     required this.prevPageId,
//     required this.pageId,
//     required this.pageCategory,
//     required this.page,
//     required this.processingFeeData,
//   });
//
//   final String pageId;
//   final String pageCategory;
//   final String profileId;
//   final String prevPageId;
//   final StepsPage? page;
//   final ProcessingFeeData? processingFeeData;
//
//   @override
//   State<DownPaymentView> createState() => _DownPaymentViewState();
// }
//
// class _DownPaymentViewState extends State<DownPaymentView> {
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   void init() {
//     SdkBackHandler.onBackPressed = handleBackPress;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     SdkBackHandler.onBackPressed = null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
//       bottomSheet: _bottomSheet(),
//       body: WillPopScope(
//         onWillPop: handleBackPress,
//         child: MultiBlocListener(
//           listeners: [
//             /// 🔹 Credit onboarding listener
//             BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
//               listenWhen: (prev, curr) =>
//                   prev.userProfileStageUpdated != curr.userProfileStageUpdated,
//               listener: (context, state) {
//                 if (state.userProfileStageUpdated == true) {
//                   context.replaceNamed(
//                     Routes.sdkCreditOnboarding,
//                     extra: {"profileId": widget.profileId},
//                   );
//
//                   context.read<CreditOnboardingBloc>().add(coe.OnReset());
//                 }
//               },
//             ),
//
//             /// 🔹 Payment success listener
//             BlocListener<DownPaymentBloc, DownPaymentState>(
//               listenWhen: (prev, curr) =>
//                   prev.paymentSuccessfull != curr.paymentSuccessfull,
//               listener: (context, state) {
//                 if (state.paymentSuccessfull == true) {
//                   context.read<DownPaymentBloc>().add(
//                         OnPatchDownPayment(
//                           pageId: widget.pageId,
//                           pageCategory: widget.pageCategory,
//                           paymentPatchResponse: state.paymentPatchResponse,
//                         ),
//                       );
//
//                   context.read<DownPaymentBloc>().add(OnReset());
//                 }
//               },
//             ),
//
//             /// 🔹 Profile update listener
//             BlocListener<DownPaymentBloc, DownPaymentState>(
//               listenWhen: (prev, curr) =>
//                   prev.userProfileStageMapCompleted !=
//                   curr.userProfileStageMapCompleted,
//               listener: (context, state) {
//                 if (state.userProfileStageMapCompleted == true) {
//                   context.read<CreditOnboardingBloc>().add(
//                         coe.OnUpdateUserProfileStage(
//                           data: state.userProfileStageMap,
//                           profileId: widget.profileId,
//                         ),
//                       );
//
//                   context.read<DownPaymentBloc>().add(
//                         OnResetUserProfileStageMapCompleted(),
//                       );
//                 }
//               },
//             ),
//           ],
//           child: _body(),
//         ),
//       ),
//     );
//   }
//
//   /// 🔹 Back handler
//   Future<bool> handleBackPress() async {
//     return await CreditCommonMethod.onBackPress(
//       context: context,
//       prevPageId: widget.prevPageId,
//       profileId: widget.profileId,
//     );
//   }
//
//   /// 🔹 Bottom CTA
//   Widget _bottomSheet() {
//     return Wrap(
//       children: [
//         BlocBuilder<DownPaymentBloc, DownPaymentState>(
//           builder: (context, state) {
//             return Container(
//               padding: const EdgeInsets.all(20.0),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 border: Border(top: BorderSide(color: AppColors.greyE1)),
//               ),
//               child: CustomButton(
//                 onTap: () {
//                   if (widget.processingFeeData?.pgEnable ?? false) {
//                     context.read<DownPaymentBloc>().add(
//                           OnPay(
//                             amount: widget
//                                     .processingFeeData?.pgOrderRequest?.amount
//                                     ?.toString() ??
//                                 "",
//                             lenderId: widget.processingFeeData?.pgOrderRequest
//                                     ?.lenderId ??
//                                 "",
//                             profileId: widget.profileId,
//                             paymentType: widget.processingFeeData
//                                     ?.pgOrderRequest?.paymentType ??
//                                 "",
//                           ),
//                         );
//                   }
//                 },
//                 buttonText:
//                     "${Strings.proceed} with ${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}",
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   /// 🔹 Main UI
//   Widget _body() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           HeaderWidget(
//             heading: widget.page?.heading?.title ?? "",
//             subHeading: widget.page?.heading?.subTitle ?? "",
//             iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
//                 ? (widget.page?.heading?.appLogo ?? "")
//                 : ((widget.page?.heading?.pageLogo) ?? ""),
//           ),
//           24.h,
//           _paymentCard(),
//         ],
//       ),
//     );
//   }
//
//   /// 🔹 Payment Card
//   Widget _paymentCard() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Header
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(Strings.paymentSummary, style: Styles.tsBlack3BBold18()),
//             GestureDetector(
//               onTap: handleBackPress,
//               child: Text(
//                 Strings.changePlan,
//                 style: Styles.tsPrimaryMedium14(),
//               ),
//             ),
//           ],
//         ),
//
//         24.h,
//
//         /// Inner card
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: AppColors.primaryColor(),width: 2),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.wallet_outlined,
//                     color: AppColors.black3B,
//                     size: 16,
//                   ),
//                   8.w,
//                   Text(
//                     Strings.payNow,
//                     style: Styles.tsBlack3BSemiBold16(),
//                   )
//                 ],
//               ),
//               12.h,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.baseline,
//                 textBaseline: TextBaseline.alphabetic,
//                 children: [
//                   Text(
//                     "${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}",
//                     style: Styles.tsBlack3BBold28(),
//                   ),
//                   8.w,
//                   Text(
//                     Strings.today,
//                     style: Styles.tsGrey4ASemiBold14(),
//                   )
//                 ],
//               ),
//               const Divider(
//                 height: 24,
//                 color: AppColors.greyE1,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _columnItem(
//                       title: Strings.downPayment,
//                       value:
//                           "${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}"),
//                   _columnItem(
//                     title: Strings.emi,
//                     value:
//                         "${Strings.rupee}${widget.processingFeeData?.emiAmt?.toString().formatData() ?? ""}${Strings.multiply}${widget.processingFeeData?.tenure}",
//                   ),
//                   _columnItem(
//                       title: Strings.total,
//                       value:
//                           "${Strings.rupee}${widget.processingFeeData?.totalPayable?.toString().formatData() ?? ""}"),
//                   // Text(
//                   //   Strings.totalPayable,
//                   //   style: Styles.tsGrey4ARegular14(),
//                   // ),
//                   // Row(
//                   //   children: [
//                   //     const Icon(
//                   //       Icons.arrow_forward,
//                   //       size: 16,
//                   //       color: Colors.grey,
//                   //     ),
//                   //     const SizedBox(width: 6),
//                   //     Text(
//                   //       "${Strings.rupee}${widget.processingFeeData?.totalPayable?.toString().formatData() ?? ""}",
//                   //       style: Styles.tsBlack3BBold18(),
//                   //     ),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//
//         24.h,
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: AppColors.greyE1),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.calendar_month,
//                     color: AppColors.black3B,
//                     size: 16,
//                   ),
//                   8.w,
//                   Text(
//                     Strings.paymentSchedule,
//                     style: Styles.tsBlack3BSemiBold16(),
//                   )
//                 ],
//               ),
//               16.h,
//               _rowItem(
//                 title: Strings.today.capitalize(),
//                 amount:
//                 widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? "",
//                 subtitle: Strings.downPayment,
//               ),
//               12.h,
//               _rowItem(
//                 title: "Month 1-${widget.processingFeeData?.tenure ?? ""}",
//                 amount:
//                 widget.processingFeeData?.emiAmt?.toString().formatData() ?? "",
//                 subtitle: Strings.autoDebitMonthly,
//               ),
//               const Divider(
//                 height: 24,
//                 color: AppColors.greyE1,
//               ),
//               _rowItem(
//                 title: Strings.totalPayable,
//                 amount:
//                 widget.processingFeeData?.totalPayable?.toString().formatData() ?? "",
//                 showDot: false,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _amountColumn({
//     required String title,
//     required String amount,
//     required String subtitle,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: Styles.tsGrey4ASemiBold12()),
//         const SizedBox(height: 4),
//         Text(amount, style: Styles.tsBlack3BBold20()),
//         const SizedBox(height: 4),
//         Text(subtitle, style: Styles.tsGrey4ARegular12()),
//       ],
//     );
//   }
//
//   Widget _rowItem({
//     required String title,
//     required String amount,
//     String? subtitle,
//     bool showDot = true,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           title,
//           style: Styles.tsBlack3BSemiBold14(),
//         ),
//         if (showDot)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6),
//             child: Container(
//               height: 4,
//               width: 4,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.black3B,
//               ),
//             ),
//           ),
//         Text(
//           subtitle ?? "",
//           style: Styles.tsGrey4ARegular14(),
//         ),
//         const Spacer(),
//         Text(
//           "${Strings.rupee}$amount",
//           style: Styles.tsPrimarySemiBold14(),
//         ),
//       ],
//     );
//   }
//
//   Widget _columnItem({
//     required String title,
//     required String value,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//
//       children: [
//         Text(
//           title,
//           style: Styles.tsGrey4ARegular14(),
//         ),
//         Text(
//           value,
//           style: Styles.tsPrimarySemiBold14(),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
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
      backgroundColor: AppColors.white,
      appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
      bottomSheet: _bottomSheet(),
      body: WillPopScope(
        onWillPop: handleBackPress,
        child: MultiBlocListener(
          listeners: [
            /// 🔹 Credit onboarding listener — now routes straight to SuccessView
            BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
              listenWhen: (prev, curr) =>
              prev.userProfileStageUpdated != curr.userProfileStageUpdated,
              listener: (context, state) {
                if (state.userProfileStageUpdated == true) {
                  final paymentDetails = context
                      .read<DownPaymentBloc>()
                      .state
                      .paymentPatchResponse
                      ?.payload;

                  context.replaceNamed(
                    Routes.success,
                    extra: {
                      "profileId": widget.profileId,
                      "prevPageId": widget.pageId,
                      "paymentDetails": paymentDetails,
                      "isFinalStep": false,
                    },
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
        BlocBuilder<DownPaymentBloc, DownPaymentState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.greyE1)),
              ),
              child: CustomButton(
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
              ),
            );
          },
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
          24.h,
          _paymentCard(),
        ],
      ),
    );
  }

  /// 🔹 Payment Card
  Widget _paymentCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        24.h,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryColor(), width: 2),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wallet_outlined,
                    color: AppColors.black3B,
                    size: 16,
                  ),
                  8.w,
                  Text(
                    Strings.payNow,
                    style: Styles.tsBlack3BSemiBold16(),
                  )
                ],
              ),
              12.h,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}",
                    style: Styles.tsBlack3BBold28(),
                  ),
                  8.w,
                  Text(
                    Strings.today,
                    style: Styles.tsGrey4ASemiBold14(),
                  )
                ],
              ),
              const Divider(
                height: 24,
                color: AppColors.greyE1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _columnItem(
                      title: Strings.downPayment,
                      value:
                      "${Strings.rupee}${widget.processingFeeData?.pgOrderRequest?.amount?.toString().formatData() ?? ""}"),
                  _columnItem(
                    title: Strings.emi,
                    value:
                    "${Strings.rupee}${widget.processingFeeData?.emiAmt?.toString().formatData() ?? ""}${Strings.multiply}${widget.processingFeeData?.tenure}",
                  ),
                  _columnItem(
                      title: Strings.total,
                      value:
                      "${Strings.rupee}${widget.processingFeeData?.totalPayable?.toString().formatData() ?? ""}"),
                ],
              ),
            ],
          ),
        ),
        24.h,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.greyE1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: AppColors.black3B,
                    size: 16,
                  ),
                  8.w,
                  Text(
                    Strings.paymentSchedule,
                    style: Styles.tsBlack3BSemiBold16(),
                  )
                ],
              ),
              16.h,
              _rowItem(
                title: Strings.today.capitalize(),
                amount: widget.processingFeeData?.pgOrderRequest?.amount
                    ?.toString()
                    .formatData() ??
                    "",
                subtitle: Strings.downPayment,
              ),
              12.h,
              _rowItem(
                title: "Month 1-${widget.processingFeeData?.tenure ?? ""}",
                amount: widget.processingFeeData?.emiAmt
                    ?.toString()
                    .formatData() ??
                    "",
                subtitle: Strings.autoDebitMonthly,
              ),
              const Divider(
                height: 24,
                color: AppColors.greyE1,
              ),
              _rowItem(
                title: Strings.totalPayable,
                amount: widget.processingFeeData?.totalPayable
                    ?.toString()
                    .formatData() ??
                    "",
                showDot: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _rowItem({
    required String title,
    required String amount,
    String? subtitle,
    bool showDot = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Styles.tsBlack3BSemiBold14(),
        ),
        if (showDot)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              height: 4,
              width: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black3B,
              ),
            ),
          ),
        Text(
          subtitle ?? "",
          style: Styles.tsGrey4ARegular14(),
        ),
        const Spacer(),
        Text(
          "${Strings.rupee}$amount",
          style: Styles.tsPrimarySemiBold14(),
        ),
      ],
    );
  }

  Widget _columnItem({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Styles.tsGrey4ARegular14(),
        ),
        Text(
          value,
          style: Styles.tsPrimarySemiBold14(),
        ),
      ],
    );
  }
}