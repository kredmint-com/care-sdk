import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/success/presentation/bloc/success_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/success/presentation/bloc/success_state.dart';

class SuccessBloc extends Bloc<SuccessEvent, SuccessState> {
  final CreditOnboardingRepository repository;

  SuccessBloc({required this.repository})
      : super(SuccessState(
          remainingSeconds: 3,
        )) {
    on<OnSuccess>(_onSuccess);
    on<OnResetUserProfileStageMapCompleted>(
      _onResetUserProfileStageMapCompleted,
    );
    on<OnTimerCountChange>(_onTimerCountChange);
  }

  void _onSuccess(OnSuccess event, Emitter<SuccessState> emit) {
    emit(state.copyWith(userProfileStageMapCompleted: false));
    Map<String, dynamic> userProfileStageMap = {
      "pageId": event.pageId,
      "pageCategory": event.pageCategory,
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
    Emitter<SuccessState> emit,
  ) {
    emit(
      state.copyWith(
        userProfileStageMapCompleted: false,
        userProfileStageMap: {},
      ),
    );
  }

  void _onTimerCountChange(
    OnTimerCountChange event,
    Emitter<SuccessState> emit,
  ) {
    emit(
      state.copyWith(
        remainingSeconds: event.count,
      ),
    );
  }
}
