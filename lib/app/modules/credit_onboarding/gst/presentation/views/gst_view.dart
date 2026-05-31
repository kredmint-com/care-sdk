import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/gst/presentation/bloc/gst_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_event.dart'
    as coe;
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/views/widgets/onboarding_app_bar.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/utils/helper/string_extension.dart';
import 'package:loan_sdk_package/widgets/input_text_field.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../bloc/gst_bloc.dart';
import '../bloc/gst_event.dart';

class GstView extends StatefulWidget {
  const GstView({
    super.key,
    required this.pageId,
    required this.pageCategory,
    required this.profileId,
    required this.gst,
    required this.prevPageId,
    required this.page,
  });

  final String pageId;
  final String pageCategory;
  final String profileId;
  final String gst;
  final String prevPageId;
  final StepsPage? page;

  @override
  State<GstView> createState() => _GstViewState();
}

class _GstViewState extends State<GstView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
  }

  Future<bool> handleBackPress() async {
    return CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    formKey.currentState?.dispose();
    SdkBackHandler.onBackPressed = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          // CommonWidget().customAppBar(title: "", onBackPressed: onBackPress),
          CreditOnboardingAppBar(onBackPressed: handleBackPress),
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
        child: BlocListener<GstBloc, GstState>(
          listener: (context, state) {
            if (state.dataMap?.isNotEmpty ?? false) {
              context.read<CreditOnboardingBloc>().add(
                    coe.OnUpdateUserProfileStage(
                      data: state.dataMap,
                      profileId: widget.profileId,
                    ),
                  );
              context.read<GstBloc>().add(OnReset());
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
                  iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                      ? (widget.page?.heading?.appLogo ?? "")
                      : ((widget.page?.heading?.pageLogo) ?? ""),
                ),
                40.h,
                Text(
                  Strings.enterYourEmailToReceiveTheOnboardingLink,
                  style: Styles.tsBlack3BMedium12(),
                ),
                12.h,
                BlocBuilder<GstBloc, GstState>(
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      autovalidateMode: (state.submitClicked ?? false)
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.gst.isEmpty) ...[
                            InputTextField(
                              textFieldWrapper: gstController,
                              hintText: Strings.gstNumber,
                              labelText: Strings.gstNumber,
                              validator: (val) {
                                if (val?.isEmpty ?? false) {
                                  return ErrorMessages.thisFieldIsRequired;
                                } else if (!(val?.isValidGST() ?? false)) {
                                  return ErrorMessages.invalidInput;
                                }
                                return null;
                              },
                              capitalize: true,
                            ),
                            16.h,
                          ],
                          InputTextField(
                            textFieldWrapper: emailController,
                            hintText: Strings.enterEmail,
                            labelText: Strings.email,
                            validator: (val) {
                              if (val?.isEmpty ?? false) {
                                return ErrorMessages.thisFieldIsRequired;
                              } else if (!(val?.isValidEmail() ?? false)) {
                                return ErrorMessages.emailInvalid;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                24.h,
                BlocBuilder<GstBloc, GstState>(
                  builder: (context, state) {
                    return CustomButton(
                      onTap: () {
                        context.read<GstBloc>().add(OnSubmitButtonClicked());
                        if (formKey.currentState?.validate() ?? false) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<GstBloc>().add(
                                OnSendMailTap(
                                  gst: widget.gst.isNotEmpty
                                      ? widget.gst
                                      : gstController.text.trim(),
                                  email: emailController.text.trim(),
                                  pageId: widget.pageId,
                                  pageCategory: widget.pageCategory,
                                  profileId: widget.profileId,
                                ),
                              );
                        }
                      },
                      buttonText: Strings.sendMail,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
