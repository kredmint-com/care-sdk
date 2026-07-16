import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_detail/presentation/bloc/bank_detail_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_detail/presentation/views/bank_detail_view.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/views/down_payment_view.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/views/emi_view.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/sucess/presentation/views/success_view.dart';

import '../../injection_container.dart';
import '../../service/navigation_service.dart';
import '../modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_bloc.dart';
import '../modules/credit_onboarding/bank_statement/presentation/views/bank_statement_view.dart';
import '../modules/credit_onboarding/gst/presentation/bloc/gst_bloc.dart';
import '../modules/credit_onboarding/gst/presentation/views/gst_view.dart';
import '../modules/credit_onboarding/kyc/presentation/bloc/kyc_bloc.dart';
import '../modules/credit_onboarding/kyc/presentation/views/kyc_view.dart';
import '../modules/credit_onboarding/loi_summary/presentation/bloc/loi_bloc.dart';
import '../modules/credit_onboarding/loi_summary/presentation/views/loi_summary_view.dart';
import '../modules/credit_onboarding/presentation/bloc/credit_onboarding_bloc.dart';
import '../modules/credit_onboarding/presentation/views/credit_onboarding_view.dart';
// import '../modules/credit_onboarding/processing_fee/presentation/bloc/processing_fee_bloc.dart';
// import '../modules/credit_onboarding/processing_fee/presentation/views/processing_fee_view.dart';
import '../modules/credit_onboarding/profile_rejected/presentation/views/profile_rejected_view.dart';
import '../modules/credit_onboarding/promoter/presentation/bloc/promoter_bloc.dart';
import '../modules/credit_onboarding/promoter/presentation/views/add_promoter_view.dart';
import '../modules/credit_onboarding/promoter/presentation/views/promoter_view.dart';
import '../modules/credit_onboarding/review/presentation/views/review_screen.dart';

part 'app_routes.dart';

class AppPages {
  static GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: Routes.initial,
    routes: [
      GoRoute(path: Routes.initial, builder: (_, __) => const Scaffold()),
      GoRoute(
        name: Routes.sdkCreditOnboarding,
        path: Routes.sdkCreditOnboarding,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: BlocProvider.value(
              value: getIt<CreditOnboardingBloc>(),
              child: CreditOnboardingView(
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                accessToken: args["accessToken"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.promoter,
        path: Routes.promoter,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<PromoterBloc>()),
              ],
              child: PromoterView(
                pageId: args["pageId"],
                pageCategory: args["pageCategory"],
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                staticPageRes: args["staticPageRes"],
                mobileNumber: args["mobileNumber"],
                page: args["page"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.bankDetail,
        path: Routes.bankDetail,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<BankDetailBloc>()),
              ],
              child: BankDetailView(
                pageId: args["pageId"],
                pageCategory: args["pageCategory"],
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                staticPageRes: args["staticPageRes"],
                page: args["page"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.bankStatement,
        path: Routes.bankStatement,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<BankStatementBloc>()),
              ],
              child: BankStatementView(
                pageId: args["pageId"],
                pageCategory: args["pageCategory"],
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                staticPageRes: args["staticPageRes"],
                page: args["page"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.gst,
        path: Routes.gst,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<GstBloc>()),
              ],
              child: GstView(
                pageId: args["pageId"],
                pageCategory: args["pageCategory"],
                profileId: args["profileId"],
                gst: args["gst"],
                prevPageId: args["prevPageId"],
                page: args["page"],
              ),
            ),
          );
        },
      ),
      // GoRoute(
      //   name: Routes.itr,
      //   path: Routes.itr,
      //   pageBuilder: (_, state) {
      //     final args = state.extra as Map<String, dynamic>;
      //     return MaterialPage(
      //       child: MultiBlocProvider(
      //         providers: [
      //           BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
      //           BlocProvider(create: (context) => getIt<ItrBloc>()),
      //         ],
      //         child: ItrView(
      //           profileId: args["profileId"],
      //           pan: args["pan"],
      //           pageId: args["pageId"],
      //           pageCategory: args["pageCategory"],
      //           prevPageId: args["prevPageId"],
      //           page: args["page"],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      GoRoute(
        name: Routes.review,
        path: Routes.review,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
              ],
              child: ReviewScreen(
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.addPromoter,
        path: Routes.addPromoter,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: BlocProvider(
              create: (context) => getIt<PromoterBloc>(),
              child: AddPromoterView(
                promoterData: args["promoterData"],
                appBarTitle: args["appBarTitle"],
                mobileNumber: args["mobileNumber"],
                page: args["page"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.loiSummary,
        path: Routes.loiSummary,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<LoiBloc>()),
              ],
              child: LoiSummaryView(
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                loiSummary: args["loiSummary"],
                pageId: args["pageId"],
                page: args["page"],
              ),
            ),
          );
        },
      ),
      // GoRoute(
      //   name: Routes.processingFee,
      //   path: Routes.processingFee,
      //   pageBuilder: (_, state) {
      //     final args = state.extra as Map<String, dynamic>;
      //     return MaterialPage(
      //       child: MultiBlocProvider(
      //         providers: [
      //           BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
      //           BlocProvider(create: (context) => getIt<ProcessingFeeBloc>()),
      //         ],
      //         child: ProcessingFeeView(
      //           profileId: args["profileId"],
      //           prevPageId: args["prevPageId"],
      //           processingFee: args["processingFee"],
      //           page: args["page"],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      GoRoute(
        name: Routes.kycDetail,
        path: Routes.kycDetail,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<KycBloc>()),
              ],
              child: KycView(
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                digioKycResponse: args["digioKycResponse"],
                pageCategory: args["pageCategory"],
                pageId: args["pageId"],
                page: args["page"],
                allowSkip: args["allowSkip"],
              ),
            ),
          );
        },
      ),

      GoRoute(
        name: Routes.emi,
        path: Routes.emi,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<EmiBloc>()),
              ],
              child: EmiView(
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                staticPageRes: args["staticPageRes"],
                page: args["page"],
                tenureId: args["tenureId"],
                tenureTypeId: args["tenureTypeId"],
                pageCategory: args["pageCategory"],
                pageId: args["pageId"],
              ),
            ),
          );
        },
      ),

      GoRoute(
        name: Routes.success,
        path: Routes.success,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: SuccessView(
              profileId: args["profileId"],
              prevPageId: args["prevPageId"],
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.profileRejected,
        path: Routes.profileRejected,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: ProfileRejectedView(
              profileId: args["profileId"],
              prevPageId: args["prevPageId"],
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.downPayment,
        path: Routes.downPayment,
        pageBuilder: (_, state) {
          final args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<CreditOnboardingBloc>()),
                BlocProvider(create: (context) => getIt<DownPaymentBloc>()),
              ],
              child: DownPaymentView(
                profileId: args["profileId"],
                prevPageId: args["prevPageId"],
                page: args["page"],
                pageCategory: args["pageCategory"],
                pageId: args["pageId"],
                processingFeeData: args["processingFeeData"],
              ),
            ),
          );
        },
      ),
    ],
  );
}
