import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';

sealed class CreditOnboardingEvent {}

class OnFetchUserProfilePage extends CreditOnboardingEvent {
  final String profileId;
  final String? pageId;

  OnFetchUserProfilePage({required this.profileId, this.pageId});
}

class OnUpdateSubmitStatus extends CreditOnboardingEvent {}

class OnUpdateField extends CreditOnboardingEvent {
  final Fields? field;
  final int index;

  OnUpdateField({required this.field, required this.index});
}

class OnUpdateUserProfileStage extends CreditOnboardingEvent {
  final Map<String, dynamic>? data;
  final String profileId;

  OnUpdateUserProfileStage({required this.data, required this.profileId});
}

class OnValidateGst extends CreditOnboardingEvent {
  final String gstin;

  OnValidateGst({required this.gstin});
}

// class OnFetchAddressDetail extends CreditOnboardingEvent {
//   final String pincode;
//
//   OnFetchAddressDetail({required this.pincode});
// }

class OnSyncPan extends CreditOnboardingEvent {
  final String panNumber;
  final int fieldIndex;

  OnSyncPan({required this.panNumber, required this.fieldIndex});
}

class OnReset extends CreditOnboardingEvent {}

class OnResetStepFound extends CreditOnboardingEvent {}

class OnPickStatementFile extends CreditOnboardingEvent {
  final String profileId;

  OnPickStatementFile({required this.profileId});
}

class OnDocumentDelete extends CreditOnboardingEvent {
  final String documentId;
  final int index;
  final String profileId;

  OnDocumentDelete({
    required this.documentId,
    required this.index,
    required this.profileId,
  });
}

class OnFilterFieldOptions extends CreditOnboardingEvent {
  final String query;
  final int index;

  OnFilterFieldOptions({required this.query, required this.index});
}

class OnResetFieldOptions extends CreditOnboardingEvent {
  final int index;

  OnResetFieldOptions({required this.index});
}

class OnResetNavigation extends CreditOnboardingEvent {}
