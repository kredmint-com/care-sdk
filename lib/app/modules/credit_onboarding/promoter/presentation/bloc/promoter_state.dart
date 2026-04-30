import '../../../data/models/add_promoter_request.dart';

class PromoterState {
  final String? residenceType;
  final bool? sameAsCurrentAddress;
  final bool? submitClicked;
  final String? selectedResidenceValue;
  final List<Promoter?>? promoterList;
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;
  final Map<String, String>? stateCityMap;
  final bool? nameMatched;
  final bool? dobMatched;
  final bool? panValidated;
  final bool? panValidationApiLimitReached;

  PromoterState({
    this.residenceType,
    this.submitClicked,
    this.selectedResidenceValue,
    this.promoterList,
    this.sameAsCurrentAddress,
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
    this.stateCityMap,
    this.nameMatched,
    this.dobMatched,
    this.panValidated,
    this.panValidationApiLimitReached,
  });

  PromoterState copyWith({
    String? residenceType,
    bool? submitClicked,
    String? selectedResidenceValue,
    List<Promoter?>? promoterList,
    bool? sameAsCurrentAddress,
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
    Map<String, String>? stateCityMap,
    bool? nameMatched,
    bool? dobMatched,
    bool? panValidated,
    bool? panValidationApiLimitReached,
  }) {
    return PromoterState(
      residenceType: residenceType ?? this.residenceType,
      submitClicked: submitClicked ?? this.submitClicked,
      selectedResidenceValue:
          selectedResidenceValue ?? this.selectedResidenceValue,
      promoterList: promoterList ?? this.promoterList,
      sameAsCurrentAddress: sameAsCurrentAddress ?? this.sameAsCurrentAddress,
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
      stateCityMap: stateCityMap ?? this.stateCityMap,
      nameMatched: nameMatched ?? this.nameMatched,
      dobMatched: dobMatched ?? this.dobMatched,
      panValidated: panValidated ?? this.panValidated,
      panValidationApiLimitReached:
          panValidationApiLimitReached ?? this.panValidationApiLimitReached,
    );
  }
}
