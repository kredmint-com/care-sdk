import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/loi_summary/presentation/bloc/loi_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/loi_summary/presentation/bloc/loi_state.dart';
import 'package:loan_sdk_package/utils/loading/loading_utils.dart';

class LoiBloc extends Bloc<LoiEvent, LoiState> {
  final CreditOnboardingRepository repository;

  LoiBloc({
    required this.repository,
  }) : super(LoiState()) {
    on<OnAcceptLoi>(_onAcceptLoi);
    on<OnPatchLoi>(_onPatchLoi);
    on<OnReset>(_onReset);
  }

  void _onAcceptLoi(OnAcceptLoi event, Emitter<LoiState> emit) {
    emit(state.copyWith(loiAccepted: event.val));
  }

  void _onPatchLoi(OnPatchLoi event, Emitter<LoiState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.patchLoi(
      profileId: event.profileId,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      Map<String, dynamic> dataMap = {};
      dataMap["pageId"] = event.pageId;
      dataMap["pageCategory"] = event.pageCategory;
      dataMap["staticPageRes"] = response.data?.toJson();
      emit(
        state.copyWith(
          userProfileStageMap: dataMap,
        ),
      );
    }
  }

  void _onReset(OnReset event, Emitter<LoiState> emit) {
    emit(state.copyWith(userProfileStageMap: {}));
  }
}
