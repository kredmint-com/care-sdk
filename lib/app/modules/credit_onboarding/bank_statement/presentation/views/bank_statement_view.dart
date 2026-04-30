import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/views/widgets/netbanking_widget.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/views/widgets/upload_bank_statement_widget.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../../widgets/custom_button.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../data/models/upload_document_response.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';

class BankStatementView extends StatefulWidget {
  const BankStatementView({
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
  State<BankStatementView> createState() => _BankStatementViewState();
}

class _BankStatementViewState extends State<BankStatementView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    generateBankStatement();
  }

  void generateBankStatement() {
    List<Document> documentList = [];
    for (int i = 0; i < (widget.staticPageRes?.length ?? 0); i++) {
      documentList.add(
        Document(
          id: widget.staticPageRes?[i]?.id ?? "",
          url: widget.staticPageRes?[i]?.url ?? "",
          name: widget.staticPageRes?[i]?.name ?? "",
          relativeUrl: widget.staticPageRes?[i]?.relativeUrl ?? "",
          userId: widget.staticPageRes?[i]?.userId ?? "",
        ),
      );
    }
    context.read<BankStatementBloc>().add(
      OnGenerateBankStatement(documentList: documentList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CommonWidget().customAppBar(
      //   title: "",
      //   onBackPressed: onBackPress,
      // ),
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
          BlocBuilder<BankStatementBloc, BankStatementState>(
            builder: (context, state) {
              return Visibility(
                visible: (state.radioGroupValue == Strings.uploadBankStatement),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<BankStatementBloc, BankStatementState>(
                    builder: (context, state) {
                      return CustomButton(
                        onTap: () {
                          context.read<BankStatementBloc>().add(
                            OnProceedTap(
                              pageId: widget.pageId,
                              pageCategory: widget.pageCategory,
                            ),
                          );
                        },
                        buttonText: Strings.proceed,
                        disabled: (state.documentList?.isEmpty) ?? true,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: bodyWidget(context: context),
    );
  }

  Widget bodyWidget({required BuildContext context}) {
    return WillPopScope(
      onWillPop: () async {
        CreditCommonMethod.onBackPress(
          context: context,
          prevPageId: widget.prevPageId,
          profileId: widget.profileId,
        );
        return false;
      },
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
        child: BlocListener<BankStatementBloc, BankStatementState>(
          listener: (context, state) async {
            if (state.redirectUrl?.isNotEmpty ?? false) {
              final success = await context.pushNamed(
                Routes.webViewService,
                extra: {
                  "url": state.redirectUrl ?? "",
                  "title": Strings.netbanking,
                  "comingFromPerfios": true,
                },
              );
              context.read<BankStatementBloc>().add(OnReset());
              debugPrint("Success data : $success");
              if (success.toString() == "true") {
                context.read<CreditOnboardingBloc>().add(
                  coe.OnFetchUserProfilePage(profileId: widget.profileId),
                );
                context.read<CreditOnboardingBloc>().add(coe.OnReset());
              }
            }
            if (state.userProfileStageMap?.isNotEmpty ?? false) {
              context.read<CreditOnboardingBloc>().add(
                coe.OnUpdateUserProfileStage(
                  data: state.userProfileStageMap,
                  profileId: widget.profileId,
                ),
              );
              context.read<BankStatementBloc>().add(OnReset());
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
                      (widget.page?.heading?.appLogo) ??
                      ((widget.page?.heading?.pageLogo) ?? ""),
                ),
                36.h,
                Text(Strings.youCanUse, style: Styles.tsBlack3BMedium12()),
                16.h,
                BlocBuilder<BankStatementBloc, BankStatementState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            value: Strings.netbanking,
                            title: Text(
                              Strings.netbanking,
                              style:
                                  (state.radioGroupValue == Strings.netbanking)
                                      ? Styles.tsPrimaryRegular12()
                                      : Styles.tsGrey86Regular12(),
                            ),
                            groupValue: (state.radioGroupValue ?? ""),
                            onChanged: (val) {
                              context.read<BankStatementBloc>().add(
                                OnBankStatementMethodChange(
                                  methodName: Strings.netbanking,
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            value: Strings.uploadBankStatement,
                            title: Text(
                              Strings.uploadBankStatement,
                              style:
                                  (state.radioGroupValue ==
                                          Strings.uploadBankStatement)
                                      ? Styles.tsPrimaryRegular12()
                                      : Styles.tsGrey86Regular12(),
                            ),
                            groupValue: (state.radioGroupValue ?? ""),
                            onChanged: (val) {
                              context.read<BankStatementBloc>().add(
                                OnBankStatementMethodChange(
                                  methodName: Strings.uploadBankStatement,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                16.h,
                BlocBuilder<BankStatementBloc, BankStatementState>(
                  builder: (context, state) {
                    return (state.radioGroupValue == Strings.netbanking)
                        ? NetbankingWidget(profileId: widget.profileId)
                        : UploadBankStatementWidget(
                          profileId: widget.profileId,
                        );
                  },
                ),
                80.h,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
