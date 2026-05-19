import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/views/widgets/emi_plan_tile.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_event.dart';
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
import '../../../presentation/bloc/credit_onboarding_state.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';

class EmiView extends StatefulWidget {
  const EmiView({
    super.key,
    required this.profileId,
    required this.prevPageId,
    required this.staticPageRes,
    required this.pageId,
    required this.pageCategory,
    required this.page,
    required this.tenureId,
    required this.tenureTypeId,
  });

  final String pageId;
  final String pageCategory;
  final String profileId;
  final String prevPageId;
  final String tenureId;
  final String tenureTypeId;
  final List<StaticPageRes?>? staticPageRes;
  final StepsPage? page;

  @override
  State<EmiView> createState() => _EmiViewState();
}

class _EmiViewState extends State<EmiView> {
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

  void handleBackPress() {
    CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
      bottomSheet: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<EmiBloc, EmiState>(
              builder: (context, state) {
                num finalAmount = 0;
                if (state.emiPlanType == EmiPlanType.monthly.name) {
                  finalAmount =
                      widget
                          .staticPageRes?[state.selectedEmiPlanIndex ?? 0]
                          ?.emiAmt ??
                      0;
                } else {
                  finalAmount =
                      widget
                          .staticPageRes?[state.selectedEmiPlanIndex ?? 0]
                          ?.weekly
                          ?.emiAmount ??
                      0;
                }
                return CustomButton(
                  onTap: () {
                    context.read<EmiBloc>().add(
                      OnPatchEmiPlan(
                        pageId: widget.pageId,
                        pageCategory: widget.pageCategory,
                        tenureId: widget.tenureId,
                        tenureTypeId: widget.tenureTypeId,
                        tenureType: state.emiPlanType?.toUpperCase() ?? "",
                        tenure:
                            widget
                                .staticPageRes?[state.selectedEmiPlanIndex ?? 0]
                                ?.tenure,
                      ),
                    );
                  },
                  buttonText:
                      "${Strings.proceed} ${Strings.withString} ${Strings.rupee}${finalAmount.toString().formatData()}",
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
      onWillPop: () async {
        handleBackPress();
        return false;
      },
      child: BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
        listener: (context, state) {
          if ((state.userProfileStageUpdated) ?? false) {
            context.replaceNamed(
              Routes.sdkCreditOnboarding,
              extra: {"profileId": widget.profileId},
            );
            context.read<CreditOnboardingBloc>().add(coe.OnReset());
          }
        },
        child: BlocConsumer<EmiBloc, EmiState>(
          listener: (context, state) {
            if ((state.userProfileStageMapCompleted) ?? false) {
              context.read<CreditOnboardingBloc>().add(
                OnUpdateUserProfileStage(
                  data: state.userProfileStageMap,
                  profileId: widget.profileId,
                ),
              );
              context.read<EmiBloc>().add(
                OnResetUserProfileStageMapCompleted(),
              );
            }
          },
          builder: (context, state) {
            return Padding(
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
                  12.h,
                  Expanded(
                    child: ListView.separated(
                      itemCount: widget.staticPageRes?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return 8.h;
                      },
                      itemBuilder: (context, index) {
                        StaticPageRes? staticPageRes =
                            widget.staticPageRes?[index];
                        return EmiPlanTile(
                          amount:
                              state.emiPlanType == EmiPlanType.weekly.name &&
                                      state.selectedEmiPlanIndex == index
                                  ? staticPageRes?.weekly?.emiAmount
                                          ?.toString() ??
                                      ""
                                  : (staticPageRes?.emiAmt?.toString() ?? ""),
                          principalAmount:
                              staticPageRes?.amount?.toString() ?? "",
                          duration: "${staticPageRes?.tenure} ${Strings.month}",
                          interest: "${staticPageRes?.interest}",
                          isSelected: (index == state.selectedEmiPlanIndex),
                          rate:
                              "${Strings.atTheRate}${staticPageRes?.roi}${Strings.pa}",
                          total: staticPageRes?.totalAmount?.toString() ?? "",
                          showBreakdown: true,
                          index: index,
                          onUpdateSelectedEmiIndex: ({required int index}) {
                            context.read<EmiBloc>().add(
                              OnUpdateSelectedPlanIndex(index: index),
                            );
                          },
                          selectedEmiPlanType: state.emiPlanType,
                          onUpdateEmiPlanType: ({required String planType}) {
                            context.read<EmiBloc>().add(
                              OnUpdateEmiPlanType(planType: planType),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
