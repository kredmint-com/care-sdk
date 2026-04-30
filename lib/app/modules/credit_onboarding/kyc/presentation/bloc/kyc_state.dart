import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/verify_esign_response.dart';

import '../../../data/models/mandate_verify_response.dart';

class KycState {
  final bool? paymentSuccessfull;
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;
  final bool? eSignVerified;
  final EsignVerifyResponse? esignVerifyResponse;
  final bool? eMandateVerified;
  final MandateVerifyResponse? mandateVerifyResponse;
  final Map<String, dynamic>? digioResponse;

  KycState({
    this.paymentSuccessfull,
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
    this.eSignVerified,
    this.esignVerifyResponse,
    this.eMandateVerified,
    this.mandateVerifyResponse,
    this.digioResponse,
  });

  KycState copyWith({
    bool? paymentSuccessfull,
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
    bool? eSignVerified,
    EsignVerifyResponse? esignVerifyResponse,
    bool? eMandateVerified,
    MandateVerifyResponse? mandateVerifyResponse,
    Map<String, dynamic>? digioResponse,
  }) {
    return KycState(
      paymentSuccessfull: paymentSuccessfull ?? this.paymentSuccessfull,
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
      eSignVerified: eSignVerified ?? this.eSignVerified,
      esignVerifyResponse: esignVerifyResponse ?? this.esignVerifyResponse,
      eMandateVerified: eMandateVerified ?? this.eMandateVerified,
      mandateVerifyResponse:
          mandateVerifyResponse ?? this.mandateVerifyResponse,
      digioResponse: digioResponse ?? this.digioResponse,
    );
  }
}
