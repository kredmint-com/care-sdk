import '../../data/models/onboarding_steps_response.dart';
import '../../data/models/upload_document_response.dart';

class CreditOnboardingState {
  final OnboardingStepsResponse? onboardingStepsResponse;
  final bool? formLoading;
  final bool? submitClicked;
  final List<Fields?>? fieldsList;
  final bool? userProfileStageUpdated;
  final bool? stepFound;
  final bool? fieldAutoPopulated;
  final List<Document>? documentList;
  final bool? isPanValid;
  final bool? navigate;
  final bool? nameMatched;
  final bool? dobMatched;
  final bool? panValidated;
  final bool? panValidationApiLimitReached;
  final Map<String, dynamic>? formDataMap;
  final String? validationMessage;

  // final bool? businessPanFetched;
  // final bool? businessNameFetched;
  // final bool? businessTypeFetched;
  // final bool? dateOfIncorporationFetched;

  CreditOnboardingState({
    this.onboardingStepsResponse,
    this.formLoading,
    this.submitClicked,
    this.fieldsList,
    this.userProfileStageUpdated,
    this.stepFound,
    this.fieldAutoPopulated,
    this.documentList,
    this.isPanValid,
    this.navigate,
    this.nameMatched,
    this.dobMatched,
    this.panValidated,
    this.panValidationApiLimitReached,
    this.formDataMap,
    this.validationMessage,
    // this.businessNameFetched,
    // this.businessPanFetched,
    // this.businessTypeFetched,
    // this.dateOfIncorporationFetched,
  });

  CreditOnboardingState copyWith({
    OnboardingStepsResponse? onboardingStepsResponse,
    bool? formLoading,
    bool? submitClicked,
    List<Fields?>? fieldsList,
    bool? userProfileStageUpdated,
    bool? stepFound,
    bool? fieldAutoPopulated,
    List<Document>? documentList,
    bool? isPanValid,
    bool? navigate,
    bool? nameMatched,
    bool? dobMatched,
    bool? panValidated,
    bool? panValidationApiLimitReached,
    Map<String, dynamic>? formDataMap,
    String? validationMessage,
    // bool? businessPanFetched,
    // bool? businessNameFetched,
    // bool? businessTypeFetched,
    // bool? dateOfIncorporationFetched,
  }) {
    return CreditOnboardingState(
      onboardingStepsResponse:
          onboardingStepsResponse ?? this.onboardingStepsResponse,
      formLoading: formLoading ?? this.formLoading,
      submitClicked: submitClicked ?? this.submitClicked,
      fieldsList: fieldsList ?? this.fieldsList,
      userProfileStageUpdated:
          userProfileStageUpdated ?? this.userProfileStageUpdated,
      stepFound: stepFound ?? this.stepFound,
      fieldAutoPopulated: fieldAutoPopulated ?? this.fieldAutoPopulated,
      documentList: documentList ?? this.documentList,
      isPanValid: isPanValid ?? this.isPanValid,
      navigate: navigate ?? this.navigate,
      nameMatched: nameMatched ?? this.nameMatched,
      dobMatched: dobMatched ?? this.dobMatched,
      panValidated: panValidated ?? this.panValidated,
      panValidationApiLimitReached:
          panValidationApiLimitReached ?? this.panValidationApiLimitReached,
      formDataMap: formDataMap ?? this.formDataMap,
      validationMessage: validationMessage ?? this.validationMessage,
      // businessPanFetched: businessPanFetched ?? this.businessPanFetched,
      // businessNameFetched: businessNameFetched ?? this.businessNameFetched,
      // businessTypeFetched: businessTypeFetched ?? this.businessTypeFetched,
      // dateOfIncorporationFetched:
      //     dateOfIncorporationFetched ?? this.dateOfIncorporationFetched,
    );
  }
}
