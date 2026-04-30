import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/loi_response.dart';

class LoiState {
  final bool? loiAccepted;
  final Map<String, dynamic>? userProfileStageMap;

  LoiState({
    this.loiAccepted,
    this.userProfileStageMap,
  });

  LoiState copyWith({
    bool? loiAccepted,
    Map<String, dynamic>? userProfileStageMap,
  }) {
    return LoiState(
      loiAccepted: loiAccepted ?? this.loiAccepted,
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
    );
  }
}
