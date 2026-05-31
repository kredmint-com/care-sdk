import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/service/digio_service.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';

import 'kyc_event.dart';
import 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final CreditOnboardingRepository repository;
  final DigioService digioService;

  KycBloc({required this.repository, required this.digioService})
      : super(KycState()) {
    on<OnStartDigioKyc>(_onStartDigioKyc);
    on<OnVerifyEsignStatus>(_onVerifyEsignStatus);
    on<OnVerifyMandateStatus>(_onVerifyMandateStatus);
    on<OnPatchKyc>(_onPatchKyc);
    on<OnResetESignStatus>(_onResetESignStatus);
    on<OnResetEMandateStatus>(_onResetEMandateStatus);
    on<OnResetUserProfileStageMapCompleted>(
      _onResetUserProfileStageMapCompleted,
    );
  }

  void _onStartDigioKyc(OnStartDigioKyc event, Emitter<KycState> emit) async {
    final response = await digioService.startKyc(
      documentId: event.documentId,
      identifier: event.identifier,
      tokenId: event.tokenId,
    );
    if ((response["code"] == 1001) ||
        (response["message"].toLowerCase().contains("success"))) {
      if (event.pageCategory == PageCategory.MandateSignUrl.name) {
        add(OnVerifyMandateStatus(digioDocId: event.documentId));
      } else {
        add(OnVerifyEsignStatus(digioDocId: event.documentId));
      }
    }
  }

  void _onVerifyEsignStatus(
    OnVerifyEsignStatus event,
    Emitter<KycState> emit,
  ) async {
    final response = await repository.verifyEsignStatus(
      digioDocId: event.digioDocId,
    );
    if (response.data != null) {
      emit(
        state.copyWith(eSignVerified: true, esignVerifyResponse: response.data),
      );
    }
  }

  void _onVerifyMandateStatus(
    OnVerifyMandateStatus event,
    Emitter<KycState> emit,
  ) async {
    final response = await repository.verifyMandateStatus(
      digioDocId: event.digioDocId,
    );
    if (response.data != null) {
      emit(
        state.copyWith(
          eSignVerified: true,
          mandateVerifyResponse: response.data,
        ),
      );
    }
  }

  void _onPatchKyc(OnPatchKyc event, Emitter<KycState> emit) async {
    emit(state.copyWith(userProfileStageMapCompleted: false));
    Map<String, dynamic> userProfileStageMap = {
      "pageId": event.pageId,
      "pageCategory": event.pageCategory,
      "staticPageRes": event.esignVerifyResponse != null
          ? event.esignVerifyResponse?.toJson()
          : event.mandateVerifyResponse?.toJson(),
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
    Emitter<KycState> emit,
  ) {
    emit(
      state.copyWith(
        userProfileStageMapCompleted: false,
        userProfileStageMap: {},
      ),
    );
  }

  void _onResetESignStatus(OnResetESignStatus event, Emitter<KycState> emit) {
    emit(state.copyWith(eSignVerified: false, esignVerifyResponse: null));
  }

  void _onResetEMandateStatus(
      OnResetEMandateStatus event, Emitter<KycState> emit) {
    emit(state.copyWith(eMandateVerified: false, mandateVerifyResponse: null));
  }
}
