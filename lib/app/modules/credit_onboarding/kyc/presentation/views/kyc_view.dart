import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/kyc/presentation/bloc/kyc_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/kyc/presentation/bloc/kyc_state.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';

import '../../../../../../utils/helper/enums.dart';
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
  });

  final DigioKycResponse digioKycResponse;
  final String profileId;
  final String prevPageId;
  final String pageCategory;
  final String pageId;
  final StepsPage? page;

  @override
  State<KycView> createState() => _KycViewState();
}

class _KycViewState extends State<KycView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    debugPrint("Phone number : ${Storage.getSdkUser()?.phoneNumber ?? ""}");

    context.read<KycBloc>().add(
      OnStartDigioKyc(
        documentId: widget.digioKycResponse.id ?? "",
        identifier: Storage.getSdkUser()?.phoneNumber ?? "",
        tokenId: widget.digioKycResponse.accessToken?.id ?? "",
        pageCategory: widget.pageCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CreditCommonMethod.onBackPress(
          context: context,
          prevPageId: widget.prevPageId,
          profileId: widget.profileId,
        );
        return false;
      },
      child: Scaffold(
        appBar: CreditOnboardingAppBar(
          title: "",
          onBackPressed: () {
            CreditCommonMethod.onBackPress(
              context: context,
              prevPageId: widget.prevPageId,
              profileId: widget.profileId,
            );
          },
        ),
        bottomSheet: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                onTap: () {
                  context.read<KycBloc>().add(
                    OnStartDigioKyc(
                      documentId: widget.digioKycResponse.id ?? "",
                      identifier: Storage.getSdkUser()?.phoneNumber ?? "",
                      tokenId: widget.digioKycResponse.accessToken?.id ?? "",
                      pageCategory: widget.pageCategory,
                    ),
                  );
                },
                buttonText: Strings.proceed,
              ),
            ),
          ],
        ),
        body: BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
          listener: (context, state) {
            if ((state.userProfileStageUpdated) ?? false) {
              context.replaceNamed(
                Routes.sdkCreditOnboarding,
                extra: {"profileId": widget.profileId},
              );
              context.read<CreditOnboardingBloc>().add(coe.OnReset());
            }
          },
          child: BlocListener<KycBloc, KycState>(
            listener: (c, state) {
              // if ((state.digioResponse?["code"] == 1001) ||
              //     (state.digioResponse?["message"]?.toLowerCase().contains(
              //       "success",
              //     ))) {
              //   if (widget.pageCategory == PageCategory.MandateSignUrl.name) {
              //     context.read<KycBloc>().add(
              //       OnVerifyMandateStatus(
              //         digioDocId: widget.digioKycResponse.id ?? "",
              //       ),
              //     );
              //   } else {
              //     context.read<KycBloc>().add(
              //       OnVerifyEsignStatus(
              //         digioDocId: widget.digioKycResponse.id ?? "",
              //       ),
              //     );
              //   }
              //   context.read<KycBloc>().add(OnResetDigioResponse());
              // }
              // if ((state.digioResponse?["code"] == -1000)) {
              //   debugPrint("Entered this code: ${state.digioResponse?["code"]}");
              //  AppPages.router.pop();
              //   context.read<KycBloc>().add(OnResetDigioResponse());
              // }
              if (state.eSignVerified ?? false) {
                context.read<KycBloc>().add(
                  OnPatchKyc(
                    pageId: widget.pageId,
                    pageCategory: widget.pageCategory,
                    esignVerifyResponse: state.esignVerifyResponse,
                  ),
                );
                context.read<KycBloc>().add(OnResetESignStatus());
              }

              if (state.eMandateVerified ?? false) {
                context.read<KycBloc>().add(
                  OnPatchKyc(
                    pageId: widget.pageId,
                    pageCategory: widget.pageCategory,
                    mandateVerifyResponse: state.mandateVerifyResponse,
                  ),
                );
                context.read<KycBloc>().add(OnResetESignStatus());
              }

              if ((state.userProfileStageMapCompleted) ?? false) {
                context.read<CreditOnboardingBloc>().add(
                  coe.OnUpdateUserProfileStage(
                    data: state.userProfileStageMap,
                    profileId: widget.profileId,
                  ),
                );
                context.read<KycBloc>().add(
                  OnResetUserProfileStageMapCompleted(),
                );
              }
            },
            child: Padding(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
