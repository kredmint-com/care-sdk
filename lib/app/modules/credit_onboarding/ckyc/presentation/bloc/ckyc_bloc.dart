import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/ckyc/presentation/bloc/ckyc_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/ckyc/presentation/bloc/ckyc_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/utils/loading/loading_utils.dart';

class CKycBloc extends Bloc<CKycEvent, CKycState> {
  final CreditOnboardingRepository repository;

  CKycBloc({required this.repository})
      : super(
          CKycState(
            otpTimerCompleted: false,
            // selectedEmiPlanIndex: 0,
            // emiPlanType: EmiPlanType.monthly.name,
          ),
        ) {
    on<OnOtpTimerChange>(_onOtpTimerChange);
    on<OnInitiateKyc>(_onInitiateKyc);
    on<OnCKycInitiatedReset>(_onCKycInitiatedReset);
    on<OnResetCKycFailed>(_onResetCKycFailed);
    on<OnValidateCKyc>(_onValidateCKyc);
    on<OnResetCKycValidated>(_onResetCKycValidated);
    on<OnOtpChange>(_onOtpChange);
    on<OnResetManualKycInitiated>(_onResetManualKycInitiated);
  }

  void _onOtpTimerChange(OnOtpTimerChange event, Emitter<CKycState> emit) {
    emit(
      state.copyWith(
        otpTimer: event.otpTimer,
        otpTimerCompleted:
            (state.otpTimerCompleted ?? true) ? true : event.otpTimer == 0,
      ),
    );
    debugPrint("Otp timer : ${state.otpTimerCompleted}");
  }

  void _onInitiateKyc(OnInitiateKyc event, Emitter<CKycState> emit) async {
    final response = await repository.initiateCKyc(
      userProfileId: event.userProfileId,
      resendOtp: event.resendOtp,
      digioKyc: event.digioKyc,
    );
    if (response.data != null) {
      emit(
        state.copyWith(
          cKycInitiatedResponse: response.data,
          cKycInitiated: event.digioKyc == false &&
              event.resendOtp == false &&
              response.data?.payload?.first.ckycFailed == false,
          cKycFailed: (response.data?.payload?.isEmpty ?? true)
              ? false
              : (response.data?.payload?.first.ckycFailed),
          manualKycInitiated: event.digioKyc,
        ),
      );
    }
  }

  void _onCKycInitiatedReset(
      OnCKycInitiatedReset event, Emitter<CKycState> emit) async {
    emit(state.copyWith(cKycInitiated: false));
  }

  void _onResetCKycFailed(
      OnResetCKycFailed event, Emitter<CKycState> emit) async {
    emit(
      state.copyWith(
        cKycFailed: false,
      ),
    );
  }

  void _onValidateCKyc(OnValidateCKyc event, Emitter<CKycState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.validateCKyc(
      userProfileId: event.userProfileId,
      promoterId: event.promoterId,
      otp: event.otp,
      pan: event.pan,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      emit(
        state.copyWith(
          cKycValidated: response.data?.payload?.payload?.success ?? false,
          cKycValidationResponse: response.data,
        ),
      );
    }
  }

  void _onResetCKycValidated(
      OnResetCKycValidated event, Emitter<CKycState> emit) async {
    emit(
      state.copyWith(
        cKycValidated: false,
      ),
    );
  }

  void _onResetManualKycInitiated(
      OnResetManualKycInitiated event, Emitter<CKycState> emit) async {
    emit(
      state.copyWith(
        manualKycInitiated: false,
      ),
    );
  }

  void _onOtpChange(OnOtpChange event, Emitter<CKycState> emit) async {
    emit(
      state.copyWith(
        validationOtp: event.otp,
      ),
    );
  }
}
