import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/ckyc/presentation/bloc/ckyc_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/ckyc/presentation/bloc/ckyc_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/ckyc/presentation/views/widget/otp_bottomsheet.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../utils/helper/sizedbox_extension.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/bloc/credit_onboarding_state.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';
import '../bloc/ckyc_event.dart';

class CKycView extends StatefulWidget {
  const CKycView({
    super.key,
    required this.staticPageRes,
    required this.profileId,
    required this.prevPageId,
    required this.pageCategory,
    required this.pageId,
    required this.page,
  });

  final List<StaticPageRes?>? staticPageRes;
  final String profileId;
  final String prevPageId;
  final String pageCategory;
  final String pageId;
  final StepsPage? page;

  @override
  State<CKycView> createState() => _CKycViewState();
}

class _CKycViewState extends State<CKycView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    context.read<CKycBloc>().add(
          OnInitiateKyc(
            userProfileId: widget.profileId,
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    SdkBackHandler.onBackPressed = null;
  }

  Future<bool> handleBackPress() async {
    return CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: handleBackPress,
      child: Scaffold(
        appBar: CreditOnboardingAppBar(
          title: "",
          onBackPressed: handleBackPress,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
              listenWhen: (previous, current) =>
                  previous.userProfileStageUpdated !=
                      current.userProfileStageUpdated &&
                  current.userProfileStageUpdated == true,
              listener: (context, state) {
                context.replaceNamed(
                  Routes.sdkCreditOnboarding,
                  extra: {"profileId": widget.profileId},
                );

                context.read<CreditOnboardingBloc>().add(coe.OnReset());
              },
            ),
            BlocListener<CKycBloc, CKycState>(
              listener: (context, state) {
                if (state.cKycInitiated ?? false) {
                  context.read<CKycBloc>().add(OnCKycInitiatedReset());
                  if (!context.mounted) return;

                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) {
                      final cKycBloc = context.read<CKycBloc>();

                      return BlocProvider.value(
                        value: cKycBloc,
                        child: BlocBuilder<CKycBloc, CKycState>(
                          bloc: cKycBloc,
                          builder: (context, state) {
                            debugPrint(
                                "Otp timer completed : ${state.otpTimerCompleted}..... ${(!(state.cKycValidated ?? true) || (state.otpTimerCompleted ?? false))}");
                            return OtpBottomSheet(
                              mobileNumber: (state.cKycInitiatedResponse
                                          ?.payload?.isEmpty ??
                                      true)
                                  ? ""
                                  : state.cKycInitiatedResponse?.payload?.first
                                          .mobile ??
                                      "",
                              otpTimer: state.otpTimer ?? 0,
                              onUpdateTimer: ({required int val}) {
                                if (!mounted) {
                                  return;
                                }
                                context
                                    .read<CKycBloc>()
                                    .add(OnOtpTimerChange(otpTimer: val));
                              },
                              onVerifyOtp: ({required String val}) {
                                if (state.cKycInitiatedResponse?.payload
                                        ?.isEmpty ??
                                    true) {
                                  return;
                                }
                                final cKycInitiatedPayload =
                                    state.cKycInitiatedResponse?.payload?.first;
                                context.read<CKycBloc>().add(
                                      OnValidateCKyc(
                                        userProfileId: widget.profileId,
                                        promoterId:
                                            cKycInitiatedPayload?.promoterId ??
                                                "",
                                        otp: val,
                                        pan:
                                            cKycInitiatedPayload?.promoterPan ??
                                                "",
                                      ),
                                    );
                              },
                              onDigioKyc: () {
                                context.read<CKycBloc>().add(
                                      OnInitiateKyc(
                                        userProfileId: widget.profileId,
                                        digioKyc: true,
                                      ),
                                    );
                              },
                              showDigioKycButton:
                                  state.cKycValidated == false ||
                                      state.otpTimerCompleted == true,
                              onResendOtp: () {
                                context.read<CKycBloc>().add(
                                      OnInitiateKyc(
                                        userProfileId: widget.profileId,
                                        resendOtp: true,
                                      ),
                                    );
                              },
                              onOtpChange: ({required String val}) {
                                context.read<CKycBloc>().add(
                                      OnOtpChange(
                                        otp: val,
                                      ),
                                    );
                              },
                              otp: state.validationOtp ?? "",
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
            BlocListener<CKycBloc, CKycState>(
              listener: (context, state) {
                if (state.cKycFailed ?? false) {
                  context.replaceNamed(
                    Routes.sdkCreditOnboarding,
                    extra: {"profileId": widget.profileId},
                  );
                  context.read<CKycBloc>().add(OnResetCKycFailed());
                }
              },
            ),
            BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
              listener: (context, state) {
                if ((state.userProfileStageUpdated) ?? false) {
                  context.replaceNamed(
                    Routes.sdkCreditOnboarding,
                    extra: {"profileId": widget.profileId},
                  );
                  context.read<CreditOnboardingBloc>().add(coe.OnReset());
                }
              },
            ),
            BlocListener<CKycBloc, CKycState>(
              listener: (context, state) {
                if ((state.manualKycInitiated) ?? false) {
                  context.pop();
                  context.replaceNamed(
                    Routes.sdkCreditOnboarding,
                    extra: {
                      "profileId": widget.profileId,
                      "manualKycInitiated": true,
                    },
                  );
                  context.read<CKycBloc>().add(OnResetManualKycInitiated());
                }
              },
            ),
            BlocListener<CKycBloc, CKycState>(
              listener: (context, state) {
                if (state.cKycValidated ?? false) {
                  context.pop();
                  Map<String, dynamic>? staticPageRes =
                      widget.staticPageRes?.first?.toJson();
                  staticPageRes?["response"] =
                      state.cKycValidationResponse?.toJson();
                  context.read<CreditOnboardingBloc>().add(
                        coe.OnUpdateUserProfileStage(
                          data: {
                            "pageId": widget.pageId,
                            "pageCategory": widget.pageCategory,
                            "staticPageRes": [staticPageRes],
                          },
                          profileId: widget.profileId,
                        ),
                      );

                  context.read<CKycBloc>().add(OnResetCKycValidated());
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderWidget(
                  heading: widget.page?.heading?.title ?? "",
                  subHeading: widget.page?.heading?.subTitle ?? "",
                  iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                      ? (widget.page?.heading?.appLogo ?? "")
                      : ((widget.page?.heading?.pageLogo) ?? ""),
                ),
                SizedBox(
                  height: size.height * 0.25,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor(),
                          backgroundColor: AppColors.grey,
                        ),
                      ),
                      20.h,
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                        child: Text('Fetching your KYC record',
                            style: Styles.tsBlack3BSemiBold24()),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                        child: Text(
                            'Please wait while we securely retrieve and verify your KYC details.',
                            textAlign: TextAlign.center,
                            style: Styles.tsBlack3BRegular14()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
