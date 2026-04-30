import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/upload_document_response.dart';

sealed class BankStatementEvent {}

class OnBankStatementMethodChange extends BankStatementEvent {
  final String methodName;

  OnBankStatementMethodChange({required this.methodName});
}

class OnPickStatementFile extends BankStatementEvent {
  final String profileId;

  OnPickStatementFile({required this.profileId});
}

class OnDocumentDelete extends BankStatementEvent {
  final String documentId;
  final int index;
  final String profileId;

  OnDocumentDelete({
    required this.documentId,
    required this.index,
    required this.profileId,
  });
}

class OnFetchBankStatement extends BankStatementEvent {
  final String profileId;

  OnFetchBankStatement({required this.profileId,});
}

class OnReset extends BankStatementEvent {}

class OnProceedTap extends BankStatementEvent {
  final String pageId;
  final String pageCategory;

  OnProceedTap({required this.pageId, required this.pageCategory});
}

class OnGenerateBankStatement extends BankStatementEvent {
  final List<Document> documentList;

  OnGenerateBankStatement({required this.documentList});
}
