import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/kyc/presentation/bloc/kyc_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/kyc/presentation/bloc/kyc_state.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/bloc/credit_onboarding_state.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';
import '../bloc/kyc_event.dart';

class KycView extends StatefulWidget {
  const KycView({
    super.key,
    required this.digioKycResponse,
    required this.profileId,
    required this.prevPageId,
    required this.pageCategory,
    required this.pageId,
    required this.page,
    required this.allowSkip,
    required this.staticPageRes,
  });

  final DigioKycResponse digioKycResponse;
  final String profileId;
  final String prevPageId;
  final String pageCategory;
  final String pageId;
  final StepsPage? page;
  final bool allowSkip;
  final List<StaticPageRes?>? staticPageRes;

  @override
  State<KycView> createState() => _KycViewState();
}

class _KycViewState extends State<KycView> {
  @override
  void initState() {
    super.initState();
    debugPrint("KycView initState ${identityHashCode(this)}");
    init();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("KycView dispose ${identityHashCode(this)}");
    SdkBackHandler.onBackPressed = null;
  }

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
    if (widget.allowSkip) {
      return;
    }
    debugPrint("kyc data  : ${widget.digioKycResponse.toJson()}");
    context.read<KycBloc>().add(
          OnStartDigioKyc(
            documentId: widget.digioKycResponse.id ?? "",
            identifier: Storage.getSdkUser()?.phoneNumber ?? "",
            tokenId: widget.digioKycResponse.accessToken?.id ?? "",
            pageCategory: widget.pageCategory,
            pan: widget.staticPageRes?.first?.promoterPan ?? "",
          ),
        );
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
    return WillPopScope(
      onWillPop: handleBackPress,
      child: Scaffold(
        appBar: CreditOnboardingAppBar(
          title: "",
          onBackPressed: handleBackPress,
        ),
        bottomSheet: Wrap(
          children: [
            if (widget.allowSkip) ...[
              Center(
                child: TextButton(
                  onPressed: () {
                    context.read<CreditOnboardingBloc>().add(
                          coe.OnUpdateUserProfileStage(
                            data: {
                              "pageId": widget.pageId,
                              "pageCategory": widget.pageCategory,
                              "skipPage": true,
                            },
                            profileId: widget.profileId,
                          ),
                        );
                  },
                  child: Text(
                    Strings.skip,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: CustomButton(
                onTap: () {
                  context.read<KycBloc>().add(
                        OnStartDigioKyc(
                          documentId: widget.digioKycResponse.id ?? "",
                          identifier: Storage.getSdkUser()?.phoneNumber ?? "",
                          tokenId:
                              widget.digioKycResponse.accessToken?.id ?? "",
                          pageCategory: widget.pageCategory,
                          pan: widget.staticPageRes?.first?.promoterPan ?? "",
                        ),
                      );
                },
                buttonText: Strings.proceed,
              ),
            ),
          ],
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
            BlocListener<KycBloc, KycState>(
              listenWhen: (previous, current) =>
                  previous.eSignVerified != current.eSignVerified &&
                  current.eSignVerified == true,
              listener: (context, state) {
                debugPrint("E Sign Verified");

                context.read<KycBloc>().add(
                      OnPatchKyc(
                        pageId: widget.pageId,
                        pageCategory: widget.pageCategory,
                        esignVerifyResponse: state.esignVerifyResponse,
                      ),
                    );

                context.read<KycBloc>().add(OnResetESignStatus());
              },
            ),
            BlocListener<KycBloc, KycState>(
              listenWhen: (previous, current) =>
                  previous.eMandateVerified != current.eMandateVerified &&
                  current.eMandateVerified == true,
              listener: (context, state) {
                debugPrint("E Mandate Verified");

                context.read<KycBloc>().add(
                      OnPatchKyc(
                        pageId: widget.pageId,
                        pageCategory: widget.pageCategory,
                        mandateVerifyResponse: state.mandateVerifyResponse,
                      ),
                    );

                context.read<KycBloc>().add(OnResetEMandateStatus());
              },
            ),
            BlocListener<KycBloc, KycState>(
              listenWhen: (previous, current) =>
                  previous.workflowVerified != current.workflowVerified &&
                  current.workflowVerified == true,
              listener: (context, state) {
                context.read<KycBloc>().add(
                      OnPatchKyc(
                        pageId: widget.pageId,
                        pageCategory: widget.pageCategory,
                        digioWorkflowResponse: state.digioWorkflowResponse,
                      ),
                    );

                context.read<KycBloc>().add(OnResetEMandateStatus());
              },
            ),
            BlocListener<KycBloc, KycState>(
              listenWhen: (previous, current) =>
                  previous.userProfileStageMapCompleted !=
                      current.userProfileStageMapCompleted &&
                  current.userProfileStageMapCompleted == true,
              listener: (context, state) {
                debugPrint("Updating User Profile Stage");

                context.read<CreditOnboardingBloc>().add(
                      coe.OnUpdateUserProfileStage(
                        data: state.userProfileStageMap,
                        profileId: widget.profileId,
                      ),
                    );

                context.read<KycBloc>().add(
                      OnResetUserProfileStageMapCompleted(),
                    );
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  heading: widget.page?.heading?.title ?? "",
                  subHeading: widget.page?.heading?.subTitle ?? "",
                  iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                      ? (widget.page?.heading?.appLogo ?? "")
                      : (widget.page?.heading?.pageLogo ?? ""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
