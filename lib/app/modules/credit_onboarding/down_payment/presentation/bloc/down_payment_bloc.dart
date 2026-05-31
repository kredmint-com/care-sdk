import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/down_payment/presentation/bloc/down_payment_state.dart';

import '../../../../../../service/cashfree_payment_service.dart';
import '../../../../../../service/easebuzz_payment_service.dart';
import '../../../../../../service/razorpay_payment_service.dart';
import '../../../../../../utils/helper/enums.dart';
import '../../../../../../utils/loading/loading_utils.dart';
import '../../../../../../utils/storage/storage_utils.dart';

class DownPaymentBloc extends Bloc<DownPaymentEvent, DownPaymentState> {
  final CreditOnboardingRepository repository;
  final CashfreePaymentService cashfreePaymentService;
  final EaseBuzzPaymentService easeBuzzPaymentService;
  final RazorpayPaymentService razorpayPaymentService;

  DownPaymentBloc({
    required this.repository,
    required this.cashfreePaymentService,
    required this.easeBuzzPaymentService,
    required this.razorpayPaymentService,
  }) : super(DownPaymentState()) {
    on<OnResetUserProfileStageMapCompleted>(
      _onResetUserProfileStageMapCompleted,
    );
    on<OnPay>(_onPay);
    on<OnReset>(_onReset);
    on<OnPatchDownPayment>(_onPatchDownPayment);
  }

  void _onResetUserProfileStageMapCompleted(
    OnResetUserProfileStageMapCompleted event,
    Emitter<DownPaymentState> emit,
  ) {
    emit(
      state.copyWith(
        userProfileStageMapCompleted: false,
        userProfileStageMap: {},
      ),
    );
  }

  void _onPay(OnPay event, Emitter<DownPaymentState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.pay(
      amount: event.amount,
      lenderId: event.lenderId,
      profileId: event.profileId,
      paymentType: event.paymentType,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      if (response.data?.payload?.pgName == Pg.CASH_FREE.name) {
        await cashfreePaymentService.initiatePayment(
          orderId: (response.data?.payload?.orderId ?? ""),
          paymentSessionId: (response.data?.payload?.pgSessionId ?? ""),
        );
      } else if ((response.data?.payload?.pgName == Pg.Razorpay.name) ||
          (response.data?.payload?.pgName == Pg.ORA.name)) {
        Map<String, dynamic> options = {
          "key": response.data?.payload?.key ?? "",
          "amount": ((response.data?.payload?.orderAmount ?? 0) * 100),
          "name": response.data?.payload?.meta?.name ?? 'Kredmint',
          "description": response.data?.payload?.meta?.description ?? 'Payment',
          "image":
              'https://kredmint-public.s3.ap-south-1.amazonaws.com/kredmint-logo.png',
          "order_id": response.data?.payload?.pgSessionId ?? "",
          "prefill": {
            "name": response.data?.payload?.name ?? "",
            "email": '',
            "contact": Storage.getSdkUser()?.id ?? "",
          },
        };
        await razorpayPaymentService.initiatePayment(options: options);
      } else if ((response.data?.payload?.pgName == Pg.EaseBuzz.name) ||
          (response.data?.payload?.pgName == Pg.ZEAL.name)) {
        await easeBuzzPaymentService.initiatePayment(
          accessKey: response.data?.payload?.pgSessionId ?? "",
        );
      }
      final patchPaymentResponse = await repository.patchPayment(
        orderId: (response.data?.payload?.orderId ?? ""),
        pgName: (response.data?.payload?.pgName ?? ""),
      );
      if (patchPaymentResponse.data?.payload?.status ==
          PaymentStatus.SUCCESS.name) {
        emit(
          state.copyWith(
            paymentSuccessfull: true,
            paymentPatchResponse: patchPaymentResponse.data,
          ),
        );
      }
    }
  }

  void _onReset(OnReset event, Emitter<DownPaymentState> emit) {
    emit(state.copyWith(paymentSuccessfull: false));
  }

  void _onPatchDownPayment(
    OnPatchDownPayment event,
    Emitter<DownPaymentState> emit,
  ) {
    emit(state.copyWith(userProfileStageMapCompleted: false));
    Map<String, dynamic> userProfileStageMap = {
      "pageId": event.pageId,
      "pageCategory": event.pageCategory,
      "staticPageRes": event.paymentPatchResponse?.toJson(),
    };
    emit(
      state.copyWith(
        userProfileStageMapCompleted: true,
        userProfileStageMap: userProfileStageMap,
      ),
    );
  }
}
