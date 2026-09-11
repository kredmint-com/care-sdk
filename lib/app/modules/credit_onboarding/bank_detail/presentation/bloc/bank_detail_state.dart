import '../../../data/models/bank_account_detail_response.dart';

class BankDetailState {
  final bool? bankVerified;
  final String? bankName;
  final BankAccountDetailResponse? bankAccountDetailResponse;
  final bool? bankAccountDetailFetched;
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;
  final bool? submitClicked;
  final String? userFullName;

  BankDetailState({
    this.bankVerified,
    this.bankName,
    this.bankAccountDetailResponse,
    this.bankAccountDetailFetched,
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
    this.submitClicked,
    this.userFullName,
  });

  BankDetailState copyWith({
    bool? bankVerified,
    String? bankName,
    BankAccountDetailResponse? bankAccountDetailResponse,
    bool? bankAccountDetailFetched,
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
    bool? submitClicked,
    String? userFullName,
  }) {
    return BankDetailState(
      bankVerified: bankVerified ?? this.bankVerified,
      bankName: bankName ?? this.bankName,
      bankAccountDetailResponse:
          bankAccountDetailResponse ?? this.bankAccountDetailResponse,
      bankAccountDetailFetched:
          bankAccountDetailFetched ?? this.bankAccountDetailFetched,
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
      submitClicked: submitClicked ?? this.submitClicked,
      userFullName: userFullName ?? this.userFullName,
    );
  }
}
