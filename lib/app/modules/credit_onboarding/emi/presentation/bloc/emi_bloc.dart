import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/emi/presentation/bloc/emi_state.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';

class EmiBloc extends Bloc<EmiEvent, EmiState> {
  final CreditOnboardingRepository repository;

  EmiBloc({required this.repository})
    : super(
        EmiState(
          selectedEmiPlanIndex: 0,
          emiPlanType: EmiPlanType.monthly.name,
        ),
      ) {
    on<OnUpdateSelectedPlanIndex>(_onUpdateSelectedPlanIndex);
    on<OnUpdateEmiPlanType>(_onUpdateEmiPlanType);
    on<OnPatchEmiPlan>(_onPatchEmiPlan);
    on<OnResetUserProfileStageMapCompleted>(
      _onResetUserProfileStageMapCompleted,
    );
  }

  void _onUpdateSelectedPlanIndex(
    OnUpdateSelectedPlanIndex event,
    Emitter<EmiState> emit,
  ) {
    emit(state.copyWith(selectedEmiPlanIndex: event.index));
  }

  void _onUpdateEmiPlanType(OnUpdateEmiPlanType event, Emitter<EmiState> emit) {
    emit(state.copyWith(emiPlanType: event.planType));
  }

  void _onPatchEmiPlan(OnPatchEmiPlan event, Emitter<EmiState> emit) {
    emit(state.copyWith(userProfileStageMapCompleted: false));
    Map<String, dynamic> userProfileStageMap = {
      "pageId": event.pageId,
      "pageCategory": event.pageCategory,
      "data": {
        event.tenureId: event.tenure,
        event.tenureTypeId: event.tenureType,
      },
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
    Emitter<EmiState> emit,
  ) {
    emit(
      state.copyWith(
        userProfileStageMapCompleted: false,
        userProfileStageMap: {},
      ),
    );
  }
}
