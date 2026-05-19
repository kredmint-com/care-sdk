import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/loi_summary/presentation/bloc/loi_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/loi_summary/presentation/bloc/loi_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/loi_summary/presentation/bloc/loi_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';

class LoiSummaryView extends StatefulWidget {
  const LoiSummaryView({
    super.key,
    required this.profileId,
    required this.prevPageId,
    required this.loiSummary,
    required this.pageId,
    required this.page,
  });

  final String profileId;
  final String prevPageId;
  final LoiSummary? loiSummary;
  final String pageId;
  final StepsPage? page;

  @override
  State<LoiSummaryView> createState() => _LoiSummaryViewState();
}

class _LoiSummaryViewState extends State<LoiSummaryView> {
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

  Future<bool> handleBackPress() async {
    return
    CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CommonWidget().customAppBar(
      //   title: "",
      //   onBackPressed: onBackPress,
      // ),
      appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
      bottomSheet: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<LoiBloc, LoiState>(
              builder: (context, state) {
                return CustomButton(
                  onTap: () {
                    if (state.loiAccepted ?? false) {
                      context.read<LoiBloc>().add(
                        OnPatchLoi(
                          pageCategory: PageCategory.LoiSummary.name,
                          pageId: widget.pageId,
                          profileId: widget.profileId,
                        ),
                      );
                    }
                  },
                  buttonText: Strings.proceed,
                  disabled: !(state.loiAccepted ?? false),
                );
              },
            ),
          ),
        ],
      ),
      body: bodyWidget(context: context),
    );
  }

  Widget bodyWidget({required BuildContext context}) {
    return WillPopScope(
      onWillPop: handleBackPress,
      child: BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
        listener: (context, state) {
          if (state.userProfileStageUpdated ?? false) {
            context.replaceNamed(
              Routes.sdkCreditOnboarding,
              extra: {"profileId": widget.profileId},
            );
            context.read<CreditOnboardingBloc>().add(coe.OnReset());
          }
        },
        child: BlocListener<LoiBloc, LoiState>(
          listener: (context, state) {
            if (state.userProfileStageMap?.isNotEmpty ?? false) {
              context.read<CreditOnboardingBloc>().add(
                coe.OnUpdateUserProfileStage(
                  data: state.userProfileStageMap,
                  profileId: widget.profileId,
                ),
              );
              context.read<LoiBloc>().add(OnReset());
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  heading: widget.page?.heading?.title ?? "",
                  subHeading: widget.page?.heading?.subTitle ?? "",
                  iconUrl:
                      (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                          ? (widget.page?.heading?.appLogo ?? "")
                          : ((widget.page?.heading?.pageLogo) ?? ""),
                ),
                40.h,
                tileWidget(
                  title: Strings.financialPartner,
                  value: widget.loiSummary?.lenderName ?? "",
                ),
                12.h,
                tileWidget(
                  title: Strings.borrowerName,
                  value: widget.loiSummary?.borrowerName ?? "",
                ),
                12.h,
                tileWidget(
                  title: Strings.loanAmount,
                  value: widget.loiSummary?.loanAmount?.toString() ?? "",
                ),
                12.h,
                tileWidget(
                  title: Strings.tenureMonths,
                  value: widget.loiSummary?.tenure?.toString() ?? "",
                ),
                12.h,
                tileWidget(
                  title: Strings.interestRate,
                  value: "${widget.loiSummary?.interestRate ?? ""}%",
                ),
                12.h,
                tileWidget(
                  title: Strings.processingFeeOneTime,
                  value: "${widget.loiSummary?.processingFee ?? ""}%",
                ),
                12.h,
                tileWidget(
                  title: Strings.apr,
                  value: "${widget.loiSummary?.apr ?? ""}%",
                ),
                12.h,
                tileWidget(
                  title: Strings.debitFrequency,
                  value: "${widget.loiSummary?.durationType ?? ""}%",
                ),
                12.h,
                tileWidget(
                  title: Strings.penaltyInterest,
                  value: "${widget.loiSummary?.penalInterest ?? ""}%",
                ),
                12.h,
                tileWidget(
                  title: Strings.repaymentFrequencyInDays,
                  value:
                      widget.loiSummary?.recursivePaymentDuration?.toString() ??
                      "",
                ),
                20.h,
                Row(
                  children: [
                    BlocBuilder<LoiBloc, LoiState>(
                      builder: (context, state) {
                        return Checkbox(
                          value: state.loiAccepted ?? false,
                          onChanged: (val) {
                            context.read<LoiBloc>().add(
                              OnAcceptLoi(val: val ?? false),
                            );
                          },
                        );
                      },
                    ),
                    Text(
                      Strings.iAcceptAboveLoanLetterOfIntent,
                      style: Styles.tsBlack3BMedium12(),
                    ),
                  ],
                ),
                60.h,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tileWidget({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Styles.tsGrey86Regular14()),
        4.w,
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.tsBlack3BRegular14(),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
