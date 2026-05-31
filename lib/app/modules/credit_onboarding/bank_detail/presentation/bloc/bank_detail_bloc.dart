import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_detail/presentation/bloc/bank_detail_event.dart';
import 'package:loan_sdk_package/utils/loading/loading_utils.dart';
import '../../../domain/credit_onboarding_repository.dart';
import 'bank_detail_state.dart';

class BankDetailBloc extends Bloc<BankDetailEvent, BankDetailState> {
  final CreditOnboardingRepository repository;

  BankDetailBloc({required this.repository}) : super(BankDetailState()) {
    on<OnResetBankVerified>(_onResetBankVerified);
    on<OnVerifyBankDetail>(_onVerifyBankDetail);
    on<OnValidateIFSC>(_onValidateIFSC);
    on<OnResetBankName>(_onResetBankName);
    on<OnFetchBankDetail>(_onFetchBankDetail);
    on<OnResetBankDetail>(_onResetBankDetail);
    on<OnSubmitBankDetail>(_onSubmitBankDetail);
    on<OnResetUserProfileStageMapCompleted>(
      _onResetUserProfileStageMapCompleted,
    );
    on<OnUpdateSubmitStatus>(_onUpdateSubmitStatus);
  }

  void _onResetBankVerified(
    OnResetBankVerified event,
    Emitter<BankDetailState> emit,
  ) {
    emit(state.copyWith(bankVerified: false));
  }

  void _onVerifyBankDetail(
    OnVerifyBankDetail event,
    Emitter<BankDetailState> emit,
  ) async {
    LoadingUtils.showLoader();
    final response = await repository.validateBank(
      name: event.fullName,
      bankAccount: event.accountNumber,
      ifsc: event.ifscCode,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      if (response.data?.payload?.message?.isNotEmpty ?? false) {
        Fluttertoast.showToast(msg: response.data?.payload?.message ?? "");
      }
      emit(
        state.copyWith(
          bankVerified: (response.data?.payload?.accountStatus == "VALID"),
        ),
      );
    }
  }

  void _onValidateIFSC(
    OnValidateIFSC event,
    Emitter<BankDetailState> emit,
  ) async {
    final response = await repository.validateIfsc(ifsc: event.ifscCode);
    if (response.data != null) {
      emit(
        state.copyWith(
          bankName: response.data?.payload?.bank ?? "",
        ),
      );
    }
  }

  void _onResetBankName(OnResetBankName event, Emitter<BankDetailState> emit) {
    emit(state.copyWith(bankName: ""));
  }

  void _onFetchBankDetail(
    OnFetchBankDetail event,
    Emitter<BankDetailState> emit,
  ) async {
    LoadingUtils.showLoader();
    final response = await repository.bankAccountDetail(
      bankName: event.bankName,
      accountHolderName: event.accountHolderName,
      accountNumber: event.accountNumber,
      ifsc: event.ifsc,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      emit(
        state.copyWith(
          bankAccountDetailResponse: response.data,
          bankAccountDetailFetched: true,
        ),
      );
    }
  }

  void _onResetBankDetail(
    OnResetBankDetail event,
    Emitter<BankDetailState> emit,
  ) {
    emit(state.copyWith(bankAccountDetailFetched: false));
  }

  void _onSubmitBankDetail(
    OnSubmitBankDetail event,
    Emitter<BankDetailState> emit,
  ) {
    emit(state.copyWith(userProfileStageMapCompleted: false));
    Map<String, dynamic> userProfileStageMap = {
      "pageId": event.pageId,
      "pageCategory": event.pageCategory,
      "staticPageRes": event.bankAccountDetailResponse?.toJson(),
    };
    emit(
      state.copyWith(
        userProfileStageMapCompleted: true,
        userProfileStageMap: userProfileStageMap,
      ),
    );
  }

  void _onResetUserProfileStageMapCompleted(
    OnResetUserProfileStageMapCompleted event,
    Emitter<BankDetailState> emit,
  ) {
    emit(
      state.copyWith(
        userProfileStageMapCompleted: false,
        userProfileStageMap: {},
      ),
    );
  }

  void _onUpdateSubmitStatus(
    OnUpdateSubmitStatus event,
    Emitter<BankDetailState> emit,
  ) async {
    emit(state.copyWith(submitClicked: true));
  }
}
