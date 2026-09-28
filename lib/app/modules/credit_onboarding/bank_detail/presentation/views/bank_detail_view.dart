import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/config/release_env.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/widgets/input_text_field.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/stepper_widget.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/bloc/credit_onboarding_state.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';
import '../bloc/bank_detail_bloc.dart';
import '../bloc/bank_detail_event.dart';
import '../bloc/bank_detail_state.dart';

class BankDetailView extends StatefulWidget {
  const BankDetailView({
    super.key,
    required this.pageId,
    required this.pageCategory,
    required this.profileId,
    required this.prevPageId,
    required this.page,
    this.staticPageRes,
  });

  final String pageId;
  final String pageCategory;
  final String profileId;
  final String prevPageId;
  final List<StaticPageRes?>? staticPageRes;
  final StepsPage? page;

  @override
  State<BankDetailView> createState() => _PromoterViewState();
}

class _PromoterViewState extends State<BankDetailView> {
  final _formKey = GlobalKey<FormState>();
  String? _lastVerifiedKey;

  final TextEditingController accountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  Timer? _debounce;

  void _onIfscChanged({required String value}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final ifsc = value.toUpperCase();

      if (RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc)) {
        context.read<BankDetailBloc>().add(OnValidateIFSC(ifscCode: value));
      }
    });
  }

  void _checkAndVerify() {
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim().toUpperCase();
    final bankName = bankNameController.text.trim();

    final isAccountValid = account.length >= 9;
    final isIfscValid = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc);
    final isBankNameFilled = bankName.isNotEmpty;

    if (!(isAccountValid && isIfscValid && isBankNameFilled)) {
      return;
    }

    final key = '$account|$ifsc';
    if (key == _lastVerifiedKey) return;
    _lastVerifiedKey = key;

    context.read<BankDetailBloc>().add(
          OnVerifyBankDetail(
            accountNumber: account,
            ifscCode: ifsc,
            fullName: fullNameController.text.trim(),
          ),
        );
  }

  Future<bool> handleBackPress() async {
    return await CreditCommonMethod.onBackPress(
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

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
    accountController.addListener(_checkAndVerify);
    ifscController.addListener(_checkAndVerify);
    bankNameController.addListener(_checkAndVerify);
  }

  @override
  void dispose() {
    accountController.removeListener(_checkAndVerify);
    ifscController.removeListener(_checkAndVerify);
    bankNameController.removeListener(_checkAndVerify);
    accountController.dispose();
    ifscController.dispose();
    bankNameController.dispose();
    fullNameController.dispose();
    SdkBackHandler.onBackPressed = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: handleBackPress,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar:
          (widget.prevPageId.isEmpty)
              ? null
              :
          CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
          bottomSheet: BlocBuilder<BankDetailBloc, BankDetailState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border(top: BorderSide(color: AppColors.greyE1))),
                child: CustomButton(
                  onTap: () {
                    context.read<BankDetailBloc>().add(OnUpdateSubmitStatus());
                    if (_formKey.currentState?.validate() ?? false) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<BankDetailBloc>().add(
                            OnFetchBankDetail(
                              accountNumber: accountController.text.trim(),
                              ifsc: ifscController.text.trim(),
                              bankName: bankNameController.text.trim(),
                              accountHolderName: fullNameController.text.trim(),
                            ),
                          );
                    }
                  },
                  buttonText: Strings.proceed,
                ),
              );
            },
          ),
          body: bodyWidget(context: context),
        ));
  }

  Widget bodyWidget({required BuildContext context}) {
    return MultiBlocListener(
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
        BlocListener<BankDetailBloc, BankDetailState>(
          listenWhen: (previous, current) =>
              previous.bankName != current.bankName &&
              (current.bankName?.isNotEmpty ?? false),
          listener: (context, state) {
            bankNameController.text = state.bankName ?? "";

            if (state.submitClicked == true) {
              _formKey.currentState?.validate();
            }

            context.read<BankDetailBloc>().add(OnResetBankName());
          },
        ),
        BlocListener<BankDetailBloc, BankDetailState>(
          listenWhen: (previous, current) =>
              previous.bankVerified != current.bankVerified &&
              current.bankVerified == true,
          listener: (context, state) {
            // context.read<BankDetailBloc>().add(
            //   OnFetchBankDetail(
            //     accountNumber: accountController.text.trim(),
            //     ifsc: ifscController.text.trim(),
            //     bankName: bankNameController.text.trim(),
            //     accountHolderName: state.userFullName?.trim() ?? "",
            //   ),
            // );

            context.read<BankDetailBloc>().add(OnResetBankVerified());
          },
        ),
        BlocListener<BankDetailBloc, BankDetailState>(
          listenWhen: (previous, current) =>
              previous.bankAccountDetailFetched !=
                  current.bankAccountDetailFetched &&
              current.bankAccountDetailFetched == true,
          listener: (context, state) {
            context.read<BankDetailBloc>().add(
                  OnSubmitBankDetail(
                    pageId: widget.pageId,
                    pageCategory: widget.pageCategory,
                    bankAccountDetailResponse: state.bankAccountDetailResponse,
                  ),
                );

            context.read<BankDetailBloc>().add(OnResetBankDetail());
          },
        ),
        BlocListener<BankDetailBloc, BankDetailState>(
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

            context.read<BankDetailBloc>().add(
                  OnResetUserProfileStageMapCompleted(),
                );
          },
        ),
        BlocListener<BankDetailBloc, BankDetailState>(
          listener: (context, state) {
            if (state.userFullName?.isNotEmpty ?? false) {
              fullNameController.text = state.userFullName ?? "";

              if (state.submitClicked == true) {
                _formKey.currentState?.validate();
              }

              context.read<BankDetailBloc>().add(OnResetUserFullName());
            }
          },
        ),
      ],
      child: BlocBuilder<BankDetailBloc, BankDetailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepperWidget(
                    currentStep: releaseEv == ReleaseEnv.prod ? 6 : 5,
                  ),
                  20.h,
                  HeaderWidget(
                    heading: widget.page?.heading?.title ?? "",
                    subHeading: widget.page?.heading?.subTitle ?? "",
                    iconUrl:
                        (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                            ? (widget.page?.heading?.appLogo ?? "")
                            : ((widget.page?.heading?.pageLogo) ?? ""),
                  ),
                  40.h,

                  /// Account Number
                  InputTextField(
                    textFieldWrapper: accountController,
                    hintText: Strings.accountHint,
                    labelText: Strings.accountLabel,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return ErrorMessages.accountRequired;
                      }
                      if ((value?.length ?? 0) < 9) {
                        return ErrorMessages.accountInvalid;
                      }
                      return null;
                    },
                    onChanged: (_) {
                      if (state.submitClicked ?? false) {
                        _formKey.currentState?.validate();
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),

                  14.h,

                  /// IFSC Code
                  InputTextField(
                    capitalize: true,
                    textFieldWrapper: ifscController,
                    hintText: Strings.ifscHint,
                    labelText: Strings.ifscLabel,
                    onChanged: (value) {
                      _onIfscChanged(value: value);
                      if (state.submitClicked ?? false) {
                        _formKey.currentState?.validate();
                      }
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return ErrorMessages.ifscRequired;
                      } else if (!RegExp(
                        r'^[A-Z]{4}0[A-Z0-9]{6}$',
                      ).hasMatch(value?.toUpperCase() ?? "")) {
                        return ErrorMessages.ifscInvalid;
                      }
                      return null;
                    },
                  ),

                  14.h,

                  /// Bank Name
                  InputTextField(
                    textFieldWrapper: bankNameController,
                    hintText: Strings.bankNameHint,
                    labelText: Strings.bankNameLabel,
                    readOnly: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return ErrorMessages.bankNameRequired;
                      }
                      return null;
                    },
                    onChanged: (_) {
                      if (state.submitClicked ?? false) {
                        _formKey.currentState?.validate();
                      }
                    },
                  ),

                  14.h,

                  /// Full Name
                  InputTextField(
                    textFieldWrapper: fullNameController,
                    hintText: Strings.fullNameHint,
                    labelText: Strings.fullNameLabel,
                    readOnly: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return ErrorMessages.fullNameRequired;
                      }
                      return null;
                    },
                    onChanged: (_) {
                      if (state.submitClicked ?? false) {
                        _formKey.currentState?.validate();
                      }
                    },
                  ),

                  80.h,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
