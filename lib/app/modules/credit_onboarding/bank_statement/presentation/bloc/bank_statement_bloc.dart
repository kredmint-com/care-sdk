import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/utils/helper/common_method.dart';
import 'package:loan_sdk_package/utils/loading/loading_utils.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';
import '../../../data/models/upload_document_response.dart';

class BankStatementBloc extends Bloc<BankStatementEvent, BankStatementState> {
  final CreditOnboardingRepository repository;
  final CommonMethod commonMethod;

  BankStatementBloc({
    required this.repository,
    required this.commonMethod,
  }) : super(BankStatementState(
          radioGroupValue: Strings.uploadBankStatement,
        )) {
    on<OnBankStatementMethodChange>(_onBankStatementMethodChange);
    on<OnPickStatementFile>(_onPickStatementFile);
    on<OnDocumentDelete>(_onDocumentDelete);
    on<OnFetchBankStatement>(_onFetchBankStatement);
    on<OnReset>(_onReset);
    on<OnProceedTap>(_onProceedTap);
    on<OnGenerateBankStatement>(_onGenerateBankStatement);
  }

  void _onGenerateBankStatement(
      OnGenerateBankStatement event, Emitter<BankStatementState> emit) {
    emit(state.copyWith(documentList: event.documentList ?? []));
  }

  void _onBankStatementMethodChange(
      OnBankStatementMethodChange event, Emitter<BankStatementState> emit) {
    emit(state.copyWith(radioGroupValue: event.methodName));
  }

  void _onPickStatementFile(
      OnPickStatementFile event, Emitter<BankStatementState> emit) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      LoadingUtils.showLoader();
      final response = await repository.uploadDocument(
          file: result.files.single, profileId: event.profileId);
      LoadingUtils.hideLoader();
      if (response.data != null) {
        Document? document = response.data?.payload;
        PlatformFile file = result.files.single;
        List<Document>? documentList = state.documentList ?? [];
        documentList.add(
          Document(
            id: document?.id ?? "",
            name: document?.name ?? "",
            url: document?.url ?? "",
            relativeUrl: document?.relativeUrl ?? "",
          ),
        );
        emit(state.copyWith(documentList: documentList));
      }
    }
  }

  void _onDocumentDelete(
      OnDocumentDelete event, Emitter<BankStatementState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.deleteDocument(
      id: event.documentId,
      profileId: event.profileId,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      List<Document>? documentList = state.documentList ?? [];
      documentList.removeAt(event.index);
      emit(state.copyWith(documentList: documentList));
    }
  }

  void _onFetchBankStatement(
      OnFetchBankStatement event, Emitter<BankStatementState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.fetchBankStatement(
      profileId: event.profileId,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      emit(
        state.copyWith(
          redirectUrl: (response.data?.payload?.redirectUrl ?? ""),
        ),
      );
    }
  }

  void _onReset(OnReset event, Emitter<BankStatementState> emit) {
    emit(state.copyWith(
      redirectUrl: "",
      userProfileStageMap: {},
    ));
  }

  void _onProceedTap(OnProceedTap event, Emitter<BankStatementState> emit) {
    Map<String, dynamic> userProfileStageMap = {};
    List<Map<String, String>> documentDataList = [];
    for (int i = 0; i < (state.documentList?.length ?? 0); i++) {
      Map<String, String> documentDataMap = {};
      documentDataMap["userId"] = Storage.getSdkUser()?.id ?? "";
      documentDataMap["id"] = state.documentList?[i].id ?? "";
      documentDataMap["name"] = state.documentList?[i].name ?? "";
      documentDataMap["url"] = state.documentList?[i].url ?? "";
      documentDataMap["relativeUrl"] = state.documentList?[i].relativeUrl ?? "";
      documentDataList.add(documentDataMap);
    }
    userProfileStageMap["documents"] = documentDataList;
    userProfileStageMap["pageId"] = event.pageId;
    userProfileStageMap["pageCategory"] = event.pageCategory;
    emit(state.copyWith(userProfileStageMap: userProfileStageMap));
  }
}
