import 'package:get_it/get_it.dart';
import 'package:loan_sdk_package/app/bloc/app_bloc.dart';
import 'package:loan_sdk_package/app/data/repository/app_repository_impl.dart';
import 'package:loan_sdk_package/app/domain/app_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_detail/presentation/bloc/bank_detail_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/success/presentation/bloc/success_bloc.dart';
import 'package:loan_sdk_package/service/cashfree_payment_service.dart';
import 'package:loan_sdk_package/service/digio_service.dart';
import 'package:loan_sdk_package/service/easebuzz_payment_service.dart';
import 'package:loan_sdk_package/service/razorpay_payment_service.dart';
import 'package:loan_sdk_package/utils/helper/common_method.dart';

import 'app/data/models/dto/sdk_callback.dart';
import 'app/data/network/network_requester.dart';
import 'app/modules/credit_onboarding/data/repository/credit_onboarding_repository_impl.dart';
import 'app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'app/modules/credit_onboarding/kyc/presentation/bloc/kyc_bloc.dart';
import 'app/modules/credit_onboarding/presentation/bloc/credit_onboarding_bloc.dart';

final getIt = GetIt.asNewInstance();

void setup({SdkCallbacks? callbacks}) {
  if (callbacks != null) {
    getIt.registerSingleton<SdkCallbacks>(callbacks);
  }
  getIt.registerLazySingleton(() => NetworkRequester());
  getIt.registerFactory<CommonMethod>(() => CommonMethod());

  ///App
  getIt.registerFactory<AppRepository>(
    () => AppRepositoryImpl(networkRequester: getIt<NetworkRequester>()),
  );
  getIt.registerFactory(() => AppBloc(repository: getIt<AppRepository>()));

  ///Credit
  getIt.registerFactory<CreditOnboardingRepository>(
    () => CreditOnboardingRepositoryImpl(
      networkRequester: getIt<NetworkRequester>(),
    ),
  );
  getIt.registerFactory(
    () => CreditOnboardingBloc(
      repository: getIt<CreditOnboardingRepository>(),
      commonMethod: getIt<CommonMethod>(),
    ),
  );

  ///Emi
  getIt.registerFactory(
    () => EmiBloc(repository: getIt<CreditOnboardingRepository>()),
  );

  ///Digio Service
  getIt.registerFactory<DigioService>(() => DigioService());

  ///Kyc Detail
  getIt.registerFactory(
    () => KycBloc(
      repository: getIt<CreditOnboardingRepository>(),
      digioService: getIt<DigioService>(),
    ),
  );

  ///Bank Detail
  getIt.registerFactory(
    () => BankDetailBloc(repository: getIt<CreditOnboardingRepository>()),
  );

  ///Easebuzz Payment Service
  getIt.registerLazySingleton(() => EaseBuzzPaymentService());

  ///Cashfree Payment Service
  getIt.registerLazySingleton(() => CashfreePaymentService());

  ///Razorpay Payment Service
  getIt.registerLazySingleton(() => RazorpayPaymentService());

  ///Down Payment
  getIt.registerFactory(
    () => DownPaymentBloc(
      repository: getIt<CreditOnboardingRepository>(),
      cashfreePaymentService: getIt<CashfreePaymentService>(),
      easeBuzzPaymentService: getIt<EaseBuzzPaymentService>(),
      razorpayPaymentService: getIt<RazorpayPaymentService>(),
    ),
  );

  ///Success
  getIt.registerFactory(
    () => SuccessBloc(
      repository: getIt<CreditOnboardingRepository>(),
    ),
  );
}
