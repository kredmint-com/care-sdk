import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/credit_onboarding_widgets.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/header_widget.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/onboarding_app_bar.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../loan_sdk_package.dart';
import '../../../../../utils/helper/enums.dart';
import '../../../../../utils/storage/storage_utils.dart';
import '../../../../../widgets/custom_button.dart';
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
  });

  final String profileId;
  final String? prevPageId;
  final String? accessToken;

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
    debugPrint("Entered init : ${Storage.getSdkUser()?.id}");
    context.read<CreditOnboardingBloc>().add(
          OnFetchUserProfilePage(
            profileId: widget.profileId,
            pageId: widget.prevPageId,
          ),
        );
  }

  void scrollToFirstInvalidField({required List<Fields?> fieldsList}) {
    debugPrint("Entered scrollToFirstInvalidField");
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CreditOnboardingAppBar(
            title: "",
            onBackPressed: handleBackPress,
          ),
          body: bodyWidget(),
          bottomSheet: BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
            builder: (context, state) {
              return Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16,
                    ),
                    child: BlocConsumer<CreditOnboardingBloc,
                        CreditOnboardingState>(
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
                        return Visibility(
                          visible: (!(state.formLoading ?? false)),
                          child: CustomButton(
                            onTap: () {
                              // debugPrint("button tap 1");
                              context.read<CreditOnboardingBloc>().add(
                                    OnUpdateSubmitStatus(),
                                  );
                              bool isFormValid =
                                  formKey.currentState!.validate();
                              if (isFormValid) {
                                FocusManager.instance.primaryFocus?.unfocus();

                                Map<String, dynamic> fieldData = {};
                                Map<String, dynamic> dataMap = {};
                                Map<String, dynamic> addressBody = {};
                                String addressFieldId = "";
                                for (int i = 0;
                                    i < (state.fieldsList?.length ?? 0);
                                    i++) {
                                  if (state.fieldsList?[i]?.type ==
                                          InputType.address.name ||
                                      (state.fieldsList?[i]?.subType ==
                                          "pincode")) {
                                    addressFieldId =
                                        state.fieldsList?[i]?.fieldId ?? "";
                                    addressBody[state.fieldsList?[i]?.subType ??
                                        ""] = state.fieldsList?[i]?.value;
                                    debugPrint(
                                      "Address body data : ${state.fieldsList?[i]?.subType ?? ""}...${state.fieldsList?[i]?.value}",
                                    );
                                  }
                                  if (state.fieldsList?[i]?.type ==
                                      InputType.file.name) {
                                    bool documentError = ((state
                                                .fieldsList?[i]?.mandatory ??
                                            false) &&
                                        (state.documentList?.isEmpty ?? true));
                                    if (documentError) {
                                      isFormValid = !documentError;
                                      Fluttertoast.showToast(
                                        msg:
                                            "${state.fieldsList?[i]?.name ?? ""} is required",
                                      );
                                    }

                                    fieldData[state.fieldsList?[i]?.fieldId ??
                                            ""] =
                                        state.documentList
                                            ?.map((doc) => doc.toJson())
                                            .toList();
                                  }
                                  if (state.fieldsList?[i]?.type ==
                                      InputType.checkbox.name) {
                                    bool error =
                                        ((state.fieldsList?[i]?.mandatory ??
                                                false) &&
                                            !(state.fieldsList?[i]?.value ??
                                                false));
                                    if (error) {
                                      isFormValid = !error;
                                      Fluttertoast.showToast(
                                        msg:
                                            "${state.fieldsList?[i]?.name ?? ""} is required",
                                      );
                                    }

                                    fieldData[state.fieldsList?[i]?.fieldId ??
                                        ""] = state.fieldsList?[i]?.value;
                                  } else {
                                    fieldData[state.fieldsList?[i]?.fieldId ??
                                        ""] = state.fieldsList?[i]?.value;
                                  }
                                }

                                if (addressFieldId.isNotEmpty) {
                                  fieldData[addressFieldId] = addressBody;
                                }

                                dataMap["data"] = fieldData;

                                dataMap["pageId"] = state
                                        .onboardingStepsResponse
                                        ?.payload
                                        ?.pageId ??
                                    "";

                                dataMap["pageCategory"] = state
                                        .onboardingStepsResponse
                                        ?.payload
                                        ?.pageCategory ??
                                    "";
                                if (isFormValid) {
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
                            },
                            buttonText: Strings.proceed,
                            buttonRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            // buttonColor: AppColors.blue24,
                          ),
                        );
                      },
                    ),
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
          child: BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
            listener: (context, state) async {
              if ((state.submitClicked ?? false) &&
                  ((state.fieldAutoPopulated) ?? false)) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  formKey.currentState?.validate();
                });
              }
            },
            child: Form(
              key: formKey,
              child: BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
                // buildWhen: (previous, current) {
                //   return previous.onboardingStepsResponse !=
                //       current.onboardingStepsResponse;
                // },
                builder: (context, state) {
                  debugPrint("Bloc builder updated");
                  final List<Fields?> fieldsList = state.fieldsList ?? [];
                  return (state.formLoading ?? true)
                      ? SizedBox.shrink()
                      : SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).padding.bottom + 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
