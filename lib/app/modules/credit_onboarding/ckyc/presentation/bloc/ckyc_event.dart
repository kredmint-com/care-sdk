sealed class CKycEvent {}

class OnOtpTimerChange extends CKycEvent {
  final int otpTimer;

  OnOtpTimerChange({required this.otpTimer});
}

class OnInitiateKyc extends CKycEvent {
  final String userProfileId;
  final bool resendOtp;
  final bool digioKyc;

  OnInitiateKyc({
    required this.userProfileId,
    this.resendOtp = false,
    this.digioKyc = false,
  });
}

class OnCKycInitiatedReset extends CKycEvent {}

class OnResetCKycFailed extends CKycEvent {}

class OnValidateCKyc extends CKycEvent {
  final String userProfileId;
  final String promoterId;
  final String otp;
  final String pan;

  OnValidateCKyc({
    required this.userProfileId,
    required this.promoterId,
    required this.otp,
    required this.pan,
  });
}

class OnResetCKycValidated extends CKycEvent {}

class OnOtpChange extends CKycEvent{
  final String otp;

  OnOtpChange({required this.otp});
}

class OnResetManualKycInitiated extends CKycEvent {}
