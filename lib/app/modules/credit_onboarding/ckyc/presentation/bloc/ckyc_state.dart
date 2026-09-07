import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/ckyc_validation_response.dart';

import '../../../data/models/ckyc_initiated_response.dart';

class CKycState {
  int? otpTimer;
  bool? cKycInitiated;
  bool? cKycFailed;
  CKycInitiatedResponse? cKycInitiatedResponse;
  bool? cKycValidated;
  String? validationOtp;
  bool? otpTimerCompleted;
  CKycValidationResponse? cKycValidationResponse;
  bool? manualKycInitiated;

  // final int? selectedEmiPlanIndex;
  // final String? emiPlanType;
  // final num? finalAmount;
  // final Map<String, dynamic>? userProfileStageMap;
  // final bool? userProfileStageMapCompleted;

  CKycState({
    this.otpTimer,
    this.cKycInitiated,
    this.cKycFailed,
    this.cKycInitiatedResponse,
    this.cKycValidated,
    this.validationOtp,
    this.otpTimerCompleted,
    this.cKycValidationResponse,
    this.manualKycInitiated,
    // this.selectedEmiPlanIndex,
    // this.emiPlanType,
    // this.finalAmount,
    // this.userProfileStageMap,
    // this.userProfileStageMapCompleted,
  });

  CKycState copyWith({
    int? otpTimer,
    bool? cKycInitiated,
    bool? cKycFailed,
    CKycInitiatedResponse? cKycInitiatedResponse,
    bool? cKycValidated,
    String? validationOtp,
    bool? otpTimerCompleted,
    CKycValidationResponse? cKycValidationResponse,
    bool? manualKycInitiated,
    // int? selectedEmiPlanIndex,
    // String? emiPlanType,
    // num? finalAmount,
    // Map<String, dynamic>? userProfileStageMap,
    // bool? userProfileStageMapCompleted,
  }) {
    return CKycState(
      otpTimer: otpTimer ?? this.otpTimer,
      cKycInitiated: cKycInitiated ?? this.cKycInitiated,
      cKycFailed: cKycFailed ?? this.cKycFailed,
      cKycInitiatedResponse:
          cKycInitiatedResponse ?? this.cKycInitiatedResponse,
      cKycValidated: cKycValidated ?? this.cKycValidated,
      validationOtp: validationOtp ?? this.validationOtp,
      otpTimerCompleted: otpTimerCompleted ?? this.otpTimerCompleted,
      cKycValidationResponse:
          cKycValidationResponse ?? this.cKycValidationResponse,
      manualKycInitiated: manualKycInitiated ?? this.manualKycInitiated,
      // selectedEmiPlanIndex: selectedEmiPlanIndex ?? this.selectedEmiPlanIndex,
      // emiPlanType: emiPlanType ?? this.emiPlanType,
      // finalAmount: finalAmount ?? this.finalAmount,
      // userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      // userProfileStageMapCompleted:
      // userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
    );
  }
}
