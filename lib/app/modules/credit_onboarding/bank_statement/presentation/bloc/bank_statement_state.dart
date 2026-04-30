import '../../../data/models/upload_document_response.dart';

class BankStatementState {
  final bool? submitClicked;
  final String? radioGroupValue;
  final List<Document>? documentList;
  final String? redirectUrl;
  final Map<String, dynamic>? userProfileStageMap;

  BankStatementState({
    this.submitClicked,
    this.radioGroupValue,
    this.documentList,
    this.redirectUrl,
    this.userProfileStageMap,
  });

  BankStatementState copyWith({
    bool? submitClicked,
    String? radioGroupValue,
    List<Document>? documentList,
    String? redirectUrl,
    Map<String, dynamic>? userProfileStageMap,
  }) {
    return BankStatementState(
      submitClicked: submitClicked ?? this.submitClicked,
      radioGroupValue: radioGroupValue ?? this.radioGroupValue,
      documentList: documentList ?? this.documentList,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
    );
  }
}
