import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/bank_account_detail_response.dart';

sealed class BankDetailEvent {}

class OnVerifyBankDetail extends BankDetailEvent {
  final String accountNumber;
  final String ifscCode;
  final String fullName;

  OnVerifyBankDetail({
    required this.accountNumber,
    required this.ifscCode,
    required this.fullName,
  });
}

class OnValidateIFSC extends BankDetailEvent {
  final String ifscCode;

  OnValidateIFSC({required this.ifscCode});
}

class OnResetBankVerified extends BankDetailEvent {}

class OnResetBankName extends BankDetailEvent {}

class OnFetchBankDetail extends BankDetailEvent {
  final String accountNumber;
  final String ifsc;
  final String bankName;
  final String accountHolderName;

  OnFetchBankDetail({
    required this.accountNumber,
    required this.ifsc,
    required this.bankName,
    required this.accountHolderName,
  });
}

class OnResetBankDetail extends BankDetailEvent {}

class OnSubmitBankDetail extends BankDetailEvent {
  final String? pageId;
  final String? pageCategory;
  final BankAccountDetailResponse? bankAccountDetailResponse;

  OnSubmitBankDetail({
    required this.pageId,
    required this.pageCategory,
    required this.bankAccountDetailResponse,
  });
}

class OnResetUserProfileStageMapCompleted extends BankDetailEvent {}

class OnUpdateSubmitStatus extends BankDetailEvent {}

class OnResetUserFullName extends BankDetailEvent {}
