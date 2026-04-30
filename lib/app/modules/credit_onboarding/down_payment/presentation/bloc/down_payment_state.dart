import '../../../data/models/payment_patch_response.dart';

class DownPaymentState {
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;
  final bool? paymentSuccessfull;
  final PaymentPatchResponse? paymentPatchResponse;

  DownPaymentState({
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
    this.paymentSuccessfull,
    this.paymentPatchResponse,
  });

  DownPaymentState copyWith({
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
    bool? paymentSuccessfull,
    PaymentPatchResponse? paymentPatchResponse,
  }) {
    return DownPaymentState(
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
      paymentSuccessfull: paymentSuccessfull ?? this.paymentSuccessfull,
      paymentPatchResponse: paymentPatchResponse ?? this.paymentPatchResponse,
    );
  }
}
