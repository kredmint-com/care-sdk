import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/mandate_verify_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/verify_esign_response.dart';

sealed class KycEvent {}

class OnStartDigioKyc extends KycEvent {
  final String documentId;
  final String tokenId;
  final String identifier;
  final String pageCategory;

  OnStartDigioKyc({
    required this.documentId,
    required this.tokenId,
    required this.identifier,
    required this.pageCategory,
  });
}

class OnVerifyEsignStatus extends KycEvent {
  final String digioDocId;

  OnVerifyEsignStatus({required this.digioDocId});
}

class OnVerifyMandateStatus extends KycEvent {
  final String digioDocId;

  OnVerifyMandateStatus({required this.digioDocId});
}

class OnResetESignStatus extends KycEvent {}

class OnResetEMandateStatus extends KycEvent {}

class OnPatchKyc extends KycEvent {
  final String? pageId;
  final String? pageCategory;
  final EsignVerifyResponse? esignVerifyResponse;
  final MandateVerifyResponse? mandateVerifyResponse;

  OnPatchKyc({
    required this.pageId,
    required this.pageCategory,
    this.esignVerifyResponse,
    this.mandateVerifyResponse,
  });
}

class OnResetUserProfileStageMapCompleted extends KycEvent {}

class OnResetDigioResponse extends KycEvent {}
