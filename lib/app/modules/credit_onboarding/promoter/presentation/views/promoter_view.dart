import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/promoter/presentation/views/promoter_tile_widget.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../route/app_pages.dart';
import '../../../credit_common_method.dart';
import '../../../data/models/add_promoter_request.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/bloc/credit_onboarding_event.dart' as coe;
import '../../../presentation/bloc/credit_onboarding_event.dart';
import '../../../presentation/bloc/credit_onboarding_state.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';
import '../bloc/promoter_bloc.dart';
import '../bloc/promoter_event.dart';
import '../bloc/promoter_state.dart';

class PromoterView extends StatefulWidget {
  const PromoterView({
    super.key,
    required this.pageId,
    required this.pageCategory,
    required this.profileId,
    required this.mobileNumber,
    required this.prevPageId,
    required this.page,
    this.staticPageRes,
  });

  final String pageId;
  final String pageCategory;
  final String profileId;
  final String prevPageId;
  final List<StaticPageRes?>? staticPageRes;
  final String mobileNumber;
  final StepsPage? page;

  @override
  State<PromoterView> createState() => _PromoterViewState();
}

class _PromoterViewState extends State<PromoterView> {
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

  void init() {
    generatePromoterList();
    SdkBackHandler.onBackPressed = handleBackPress;
  }

  Future<bool> handleBackPress() async {
    return
    CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  void generatePromoterList() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Promoter> promoterList = [];
      List<StaticPageRes?>? staticPageResponse = widget.staticPageRes;
      if (staticPageResponse?.isNotEmpty ?? false) {
        for (int i = 0; i < (staticPageResponse?.length ?? 0); i++) {
          debugPrint("Promoter data : ${staticPageResponse?[i]?.toJson()}");
          promoterList.add(
            Promoter.fromJson(staticPageResponse?[i]?.toJson() ?? {}),
          );
        }
        context.read<PromoterBloc>().add(OnAddPromoter(promoter: promoterList));
      } else {
        Promoter? promoter = await context.pushNamed(
          Routes.addPromoter,
          extra: {
            "promoterData": null,
            "appBarTitle":
                widget.pageCategory.toLowerCase().contains("promoter")
                    ? Strings.coApplicant
                    : Strings.director,
            "mobileNumber": widget.mobileNumber,
            "page": widget.page,
          },
        );
        if (promoter != null) {
          context.read<PromoterBloc>().add(OnAddPromoter(promoter: [promoter]));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
      bottomSheet: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<PromoterBloc, PromoterState>(
              builder: (context, state) {
                return CustomButton(
                  disabled: (state.promoterList?.isEmpty) ?? true,
                  onTap: () {
                    context.read<PromoterBloc>().add(
                      OnConfirmPromoters(
                        pageId: widget.pageId,
                        pageCategory: widget.pageCategory,
                      ),
                    );
                  },
                  buttonText: Strings.proceed,
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
          if ((state.userProfileStageUpdated) ?? false) {
            context.replaceNamed(
              Routes.sdkCreditOnboarding,
              extra: {"profileId": widget.profileId},
            );
            context.read<CreditOnboardingBloc>().add(coe.OnReset());
          }
        },
        child: BlocListener<PromoterBloc, PromoterState>(
          listener: (context, state) {
            if ((state.userProfileStageMapCompleted) ?? false) {
              debugPrint(
                "Listener promoter map : ${state.userProfileStageMap}",
              );
              context.read<CreditOnboardingBloc>().add(
                OnUpdateUserProfileStage(
                  data: state.userProfileStageMap,
                  profileId: widget.profileId,
                ),
              );
              context.read<PromoterBloc>().add(
                OnResetUserProfileStageMapCompleted(),
              );
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
                BlocBuilder<PromoterBloc, PromoterState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (state.promoterList?.length ?? 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: PromoterTileWidget(
                            name: state.promoterList?[index]?.name ?? "",
                            panNumber: state.promoterList?[index]?.pan ?? "",
                            address:
                                "${state.promoterList?[index]?.address?.addressLine1 ?? ""} ${state.promoterList?[index]?.address?.addressLine2 ?? ""} ${state.promoterList?[index]?.address?.addressLine3 ?? ""} ${state.promoterList?[index]?.address?.pincode ?? ""} ${state.promoterList?[index]?.address?.state ?? ""} ${state.promoterList?[index]?.address?.city ?? ""}",
                            index: index,
                            onDropdownButtonToggle: ({
                              required String? val,
                            }) async {
                              if (val == "Edit") {
                                Promoter? promoter = await context.pushNamed(
                                  Routes.addPromoter,
                                  extra: {
                                    "promoterData": state.promoterList?[index],
                                    "appBarTitle":
                                        widget.pageCategory
                                                .toLowerCase()
                                                .contains("promoter")
                                            ? Strings.coApplicant
                                            : Strings.director,
                                    "page": widget.page,
                                  },
                                );
                                if (promoter != null) {
                                  context.read<PromoterBloc>().add(
                                    OnUpdatePromoter(
                                      promoter: [promoter],
                                      index: index,
                                    ),
                                  );
                                }
                              } else if (val == "Delete") {
                                context.read<PromoterBloc>().add(
                                  OnRemovePromoter(
                                    promoter: [state.promoterList?[index]],
                                    index: index,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                16.h,
                BlocBuilder<PromoterBloc, PromoterState>(
                  builder: (context, state) {
                    return CustomButton(
                      onTap: () async {
                        Promoter? promoter = await context.pushNamed(
                          Routes.addPromoter,
                          extra: {
                            "promoterData": null,
                            "appBarTitle":
                                widget.pageCategory.toLowerCase().contains(
                                      "promoter",
                                    )
                                    ? Strings.coApplicant
                                    : Strings.director,
                            "mobileNumber":
                                (state.promoterList?.isEmpty ?? true)
                                    ? widget.mobileNumber
                                    : null,
                            "page": widget.page,
                          },
                        );
                        if (promoter != null) {
                          context.read<PromoterBloc>().add(
                            OnAddPromoter(promoter: [promoter]),
                          );
                        }
                      },
                      buttonText:
                          widget.pageCategory.toLowerCase().contains("promoter")
                              ? (state.promoterList?.isEmpty ?? true)
                                  ? Strings.addApplicant
                                  : Strings.addCoApplicant
                              : Strings.addDirector,
                      suffixPadding: 8,
                      suffixWidget: Icon(
                        Icons.add,
                        color: AppColors.primaryColor(),
                      ),
                      buttonColor: AppColors.white,
                      borderColor: AppColors.primaryColor(),
                      buttonRadius: BorderRadius.circular(8),
                      buttonTextStyle: Styles.tsBlue477Medium12(),
                      buttonPadding: EdgeInsets.all(8),
                      mainAxisSize: MainAxisSize.min,
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

  // );
}
