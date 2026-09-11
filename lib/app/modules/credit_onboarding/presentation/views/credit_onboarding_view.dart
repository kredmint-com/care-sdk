import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/credit_onboarding_widgets.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/detail_mismatch_bottomsheet.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/header_widget.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/onboarding_app_bar.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/widgets/stepper_widget.dart';

import '../../../../../injection_container.dart';
import '../../../../../loan_sdk_package.dart';
import '../../../../../utils/helper/enums.dart';
import '../../../../../utils/storage/storage_utils.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../data/models/dto/sdk_callback.dart';
import '../../../../route/app_pages.dart';
import '../../credit_common_method.dart';
import '../../data/models/onboarding_steps_response.dart';
import '../bloc/credit_onboarding_bloc.dart';
import '../bloc/credit_onboarding_event.dart';
import '../bloc/credit_onboarding_state.dart';

class CreditOnboardingView extends StatefulWidget {
  const CreditOnboardingView({
    super.key,
    required this.profileId,
    this.prevPageId,
    this.accessToken,
    this.manualKycInitiated = false,
    this.proposalId,
  });

  final String profileId;
  final String? prevPageId;
  final String? accessToken;
  final bool? manualKycInitiated;
  final String? proposalId;

  @override
  State<CreditOnboardingView> createState() => _CreditOnboardingViewState();
}

class _CreditOnboardingViewState extends State<CreditOnboardingView> {
  final formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    SdkBackHandler.onBackPressed = null;
  }

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
    Storage.setSdkUser(Storage.getSdkUser()?.copyWith(id: widget.profileId));
    if (widget.accessToken?.isNotEmpty ?? false) {
      Storage.setSdkUser(
        Storage.getSdkUser()?.copyWith(accessToken: widget.accessToken),
      );
    }
    context.read<CreditOnboardingBloc>().add(
          OnFetchUserProfilePage(
            profileId: widget.profileId,
            pageId: widget.prevPageId,
          ),
        );
    if (widget.proposalId?.isNotEmpty ?? false) {
      context.read<CreditOnboardingBloc>().add(
            OnSetProposalId(
              proposalId: widget.proposalId ?? "",
            ),
          );
    }
  }

  void scrollToFirstInvalidField({required List<Fields?> fieldsList}) {
    final fieldKeys = fieldsList.map((field) => field?.fieldKey).toList();

    for (final key in fieldKeys) {
      final fieldState = key?.currentState;
      if (fieldState != null && fieldState.hasError) {
        final context = key?.currentContext;
        if (context != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 400),
              alignment: 0.1,
              curve: Curves.easeInOut,
            );
          });
          break;
        }
      }
    }
  }

  Future<bool> handleBackPress() async {
    final creditOnboardingBloc = context.read<CreditOnboardingBloc>();
    return CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: (creditOnboardingBloc
                  .state.onboardingStepsResponse?.payload?.prePageEnable ??
              false)
          ? (creditOnboardingBloc
                  .state.onboardingStepsResponse?.payload?.prvPageId ??
              "")
          : "",
      profileId: widget.profileId,
    );
  }

  void onSubmitButtonTap({
    required CreditOnboardingState state,
    bool forceProceed = false,
  }) {
    context.read<CreditOnboardingBloc>().add(
          OnUpdateSubmitStatus(),
        );
    bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      FocusManager.instance.primaryFocus?.unfocus();

      Map<String, dynamic> fieldData = {};
      Map<String, dynamic> dataMap = {};
      Map<String, dynamic> addressBody = {};
      String addressFieldId = "";
      for (int i = 0; i < (state.fieldsList?.length ?? 0); i++) {
        Fields? field = state.fieldsList?[i];

        if (field?.type == InputType.address.name ||
            (field?.subType == "pincode")) {
          addressFieldId = field?.fieldId ?? "";
          addressBody[field?.subType ?? ""] = field?.value;
          debugPrint(
            "Address body data : ${field?.subType ?? ""}...${field?.value}",
          );
        }
        if (field?.type == InputType.file.name) {
          bool documentError = ((state.fieldsList?[i]?.mandatory ?? false) &&
              (state.documentList?.isEmpty ?? true));
          if (documentError) {
            isFormValid = !documentError;
            Fluttertoast.showToast(
              msg: "${field?.name ?? ""} is required",
            );
          }

          fieldData[field?.fieldId ?? ""] =
              state.documentList?.map((doc) => doc.toJson()).toList();
        }
        if (field?.type == InputType.checkbox.name) {
          bool error = ((state.fieldsList?[i]?.mandatory ?? false) &&
              !(field?.value ?? false));
          if (error) {
            isFormValid = !error;
            Fluttertoast.showToast(
              msg: "${field?.name ?? ""} is required",
            );
          }

          fieldData[field?.fieldId ?? ""] = field?.value;
        } else {
          if (forceProceed && field?.name == "forceproceed") {
            fieldData[field?.fieldId ?? ""] = true;
          } else {
            fieldData[field?.fieldId ?? ""] = field?.value;
          }
        }
      }

      if (addressFieldId.isNotEmpty) {
        fieldData[addressFieldId] = addressBody;
      }

      dataMap["data"] = fieldData;

      dataMap["pageId"] = state.onboardingStepsResponse?.payload?.pageId ?? "";

      dataMap["pageCategory"] =
          state.onboardingStepsResponse?.payload?.pageCategory ?? "";
      if (isFormValid) {
        context.read<CreditOnboardingBloc>().add(
              OnSetFormDataMap(
                formDataMap: dataMap,
              ),
            );
        context.read<CreditOnboardingBloc>().add(
              OnUpdateUserProfileStage(
                data: dataMap,
                profileId: widget.profileId,
              ),
            );
      }
    } else {
      scrollToFirstInvalidField(
        fieldsList: state.fieldsList ?? [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CreditOnboardingAppBar(
            title: "",
            onBackPressed: handleBackPress,
          ),
          body: bodyWidget(),
          bottomSheet: BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
            builder: (context, state) {
              return Wrap(
                children: [
                  BlocConsumer<CreditOnboardingBloc, CreditOnboardingState>(
                    listener: (context, state) async {
                      if (state.userProfileStageUpdated ?? false) {
                        context.read<CreditOnboardingBloc>().add(
                              OnFetchUserProfilePage(
                                  profileId: widget.profileId),
                            );
                        context.read<CreditOnboardingBloc>().add(OnReset());
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border:
                              Border(top: BorderSide(color: AppColors.greyE1)),
                        ),
                        child: CustomButton(
                          onTap: () {
                            onSubmitButtonTap(
                              state: state,
                            );
                          },
                          buttonText: Strings.proceed,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget bodyWidget() {
    return BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: handleBackPress,
          child: MultiBlocListener(
            listeners: [
              BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
                listener: (context, state) async {
                  if ((state.submitClicked ?? false) &&
                      ((state.fieldAutoPopulated) ?? false)) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      formKey.currentState?.validate();
                    });
                  }
                },
              ),
              BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
                listener: (context, state) async {
                  if (state.isNameValid == false) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withValues(alpha: 0.35),
                      builder: (context) {
                        return DetailMismatchBottomsheet(
                          onProceed: () {
                            context.pop();
                            onSubmitButtonTap(
                              state: state,
                              forceProceed: true,
                            );
                          },
                          onCrossTap: () {
                            context.pop();
                          },
                          mismatchText: Strings.nameMismatchDescription,
                          changeDetailsText: Strings.detailMismatchQuestion,
                          trustText: Strings.kycSecurityDescription,
                        );
                      },
                    );
                    context
                        .read<CreditOnboardingBloc>()
                        .add(OnResetIsNameValid());
                  }
                },
              ),
              BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
                listener: (context, state) async {
                  if (state.isDobValid == false) {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withValues(alpha: 0.35),
                      builder: (context) {
                        return DetailMismatchBottomsheet(
                          mismatchText: Strings.dobMismatchDescription,
                          trustText: Strings.pleaseContactSupportTeamForDob,
                          onCancelTap: () {
                            getIt<SdkCallbacks>().onFailure?.call(
                                  message: "DOB Mismatch",
                                  status: "DOB Mismatch",
                                );
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        );
                      },
                    );
                    context
                        .read<CreditOnboardingBloc>()
                        .add(OnResetIsDobValid());
                  }
                },
              ),
              BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
                listenWhen: (previous, current) =>
                    previous.navigate != current.navigate &&
                    current.navigate == true,
                listener: (context, state) {
                  final OnboardingStepsPayload? payload =
                      state.onboardingStepsResponse?.payload;
                  final String prevPageId = (payload?.prePageEnable ?? false)
                      ? (payload?.prvPageId ?? "")
                      : "";
                  if (payload == null) return;

                  // AppPages.router.pushNamed(
                  //   Routes.cKyc,
                  //   extra: {
                  //     "pageId": payload.pageId ?? "",
                  //     "pageCategory": payload.pageCategory ?? "",
                  //     "profileId": widget.profileId,
                  //     "prevPageId": prevPageId,
                  //     "staticPageRes": payload.staticPageRes,
                  //     "page": payload.page,
                  //   },
                  // );
                  //
                  // return;

                  if (payload.pageCategory == PageCategory.BankStatement.name) {
                    AppPages.router.pushNamed(
                      Routes.bankStatement,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "staticPageRes": payload.staticPageRes,
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory?.contains(
                        PageCategory.Promoter.name,
                      ) ??
                      false) {
                    AppPages.router.pushNamed(
                      Routes.promoter,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "staticPageRes": payload.staticPageRes,
                        "mobileNumber": payload.meta?.mobile ?? "",
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory == PageCategory.Gst.name) {
                    AppPages.router.pushNamed(
                      Routes.gst,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "gst": payload.meta?.gst ?? "",
                        "prevPageId": prevPageId,
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory == PageCategory.Review.name) {
                    AppPages.router.pushNamed(
                      Routes.review,
                      extra: {
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory == PageCategory.Itr.name) {
                    AppPages.router.pushNamed(
                      Routes.itr,
                      extra: {
                        "profileId": widget.profileId,
                        "pan": payload.meta?.pan ?? "",
                        "prevPageId": prevPageId,
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.LoiSummary.name) {
                    AppPages.router.pushNamed(
                      Routes.loiSummary,
                      extra: {
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "loiSummary": payload.loiSummary,
                        "pageId": payload.pageId,
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.ProcessingFee.name) {
                    AppPages.router.pushNamed(
                      Routes.processingFee,
                      extra: {
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "processingFee": payload.processingFee,
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.EmiPlans.name) {
                    AppPages.router.pushNamed(
                      Routes.emi,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "staticPageRes": payload.staticPageRes,
                        "page": payload.page,
                        "tenureId": (payload.page?.fields?.isEmpty ?? true)
                            ? ""
                            : payload.page?.fields?.first.fieldId,
                        "tenureTypeId":
                            ((payload.page?.fields?.length ?? 0) >= 2)
                                ? (payload.page?.fields?[1].fieldId)
                                : "",
                      },
                    );
                  } else if ((payload.pageCategory ==
                          PageCategory.KfsEsignUrl.name) ||
                      (payload.pageCategory ==
                          PageCategory.MandateSignUrl.name)) {
                    AppPages.router.pushNamed(
                      Routes.kycDetail,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "page": payload.page,
                        "allowSkip": payload.allowSkip ?? false,
                        "digioKycResponse": DigioKycResponse(
                          id: payload.digioKycResponse?.entityId ?? "",
                          accessToken: AccessToken(
                            id: payload.digioKycResponse?.id ?? "",
                          ),
                        ),
                      },
                    );
                  } else if ((payload.pageCategory ==
                          PageCategory.CKycDetail.name &&
                      ((payload.staticPageRes?.isNotEmpty ?? false) &&
                              (payload.staticPageRes?.first.ckycFailed ??
                                  false) ||
                          (widget.manualKycInitiated ?? false)))) {
                    AppPages.router.pushNamed(
                      Routes.kycDetail,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "page": payload.page,
                        "allowSkip": payload.allowSkip ?? false,
                        "digioKycResponse": DigioKycResponse(
                          id: payload.staticPageRes?.first.digioKycInitResponse
                                  ?.id ??
                              "",
                          accessToken: AccessToken(
                            id: payload.staticPageRes?.first
                                    .digioKycInitResponse?.accessToken?.id ??
                                "",
                          ),
                        ),
                        "staticPageRes": payload.staticPageRes,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.BankDetail.name) {
                    AppPages.router.pushNamed(
                      Routes.bankDetail,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "staticPageRes": payload.staticPageRes,
                        "page": payload.page,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.Success.name) {
                    AppPages.router.pushNamed(
                      Routes.success,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "isFinalStep": true,
                        "staticPageRes": payload.staticPageRes,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.ProfileRejected.name) {
                    AppPages.router.pushNamed(
                      Routes.profileRejected,
                      extra: {
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.DownPayment.name) {
                    AppPages.router.pushNamed(
                      Routes.downPayment,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "page": payload.page,
                        "processingFeeData": payload.processingFee,
                      },
                    );
                  } else if (payload.pageCategory ==
                      PageCategory.CKycDetail.name) {
                    AppPages.router.pushNamed(
                      Routes.cKyc,
                      extra: {
                        "pageId": payload.pageId ?? "",
                        "pageCategory": payload.pageCategory ?? "",
                        "profileId": widget.profileId,
                        "prevPageId": prevPageId,
                        "staticPageRes": payload.staticPageRes,
                        "page": payload.page,
                      },
                    );
                  }
                  context.read<CreditOnboardingBloc>().add(OnResetNavigation());
                },
              )
            ],
            child: (state.formLoading ?? true) || (state.navigate ?? true)
                ? const SizedBox.shrink()
                : Form(
                    key: formKey,
                    child: BlocBuilder<CreditOnboardingBloc,
                        CreditOnboardingState>(
                      builder: (context, state) {
                        final List<Fields?> fieldsList = state.fieldsList ?? [];
                        return SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).padding.bottom + 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StepperWidget(
                                currentStep: 1,
                                totalSteps: 8,
                              ),
                              20.h,
                              HeaderWidget(
                                heading: state.onboardingStepsResponse?.payload
                                        ?.page?.heading?.title ??
                                    "",
                                subHeading: state.onboardingStepsResponse
                                        ?.payload?.page?.heading?.subTitle ??
                                    "",
                                iconUrl: (state
                                            .onboardingStepsResponse
                                            ?.payload
                                            ?.page
                                            ?.heading
                                            ?.appLogo
                                            ?.isNotEmpty ??
                                        false)
                                    ? (state.onboardingStepsResponse?.payload
                                            ?.page?.heading?.appLogo ??
                                        "")
                                    : ((state.onboardingStepsResponse?.payload
                                            ?.page?.heading?.pageLogo) ??
                                        ""),
                              ),
                              12.h,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List<Widget>.generate(
                                  fieldsList.length,
                                  (index) {
                                    return CreditOnboardingWidget(
                                      field: fieldsList[index],
                                      formKey: formKey,
                                      submitClicked:
                                          (state.submitClicked ?? false),
                                      index: index,
                                      profileId: widget.profileId,
                                    );
                                  },
                                ),
                              ),
                              80.h,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
