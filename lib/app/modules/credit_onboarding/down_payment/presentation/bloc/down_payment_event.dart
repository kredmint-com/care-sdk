import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/payment_patch_response.dart';

sealed class DownPaymentEvent {}

class OnResetUserProfileStageMapCompleted extends DownPaymentEvent {}

class OnPay extends DownPaymentEvent {
  final String amount;
  final String lenderId;
  final String profileId;
  final String paymentType;

  OnPay({
    required this.amount,
    required this.lenderId,
    required this.profileId,
    required this.paymentType,
  });
}

class OnReset extends DownPaymentEvent {}

class OnPatchDownPayment extends DownPaymentEvent {
  final String? pageId;
  final String? pageCategory;
  final PaymentPatchResponse? paymentPatchResponse;

  OnPatchDownPayment({
    required this.pageId,
    required this.pageCategory,
    required this.paymentPatchResponse,
  });
}
