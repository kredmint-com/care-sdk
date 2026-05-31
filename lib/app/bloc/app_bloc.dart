import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/bloc/app_event.dart';
import 'package:loan_sdk_package/app/bloc/app_state.dart';
import 'package:loan_sdk_package/app/domain/app_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository repository;

  AppBloc({required this.repository}) : super(AppState()) {
    on<OnFetchInfo>(_onFetchInfo);
    on<OnFetchUserProfile>(_onFetchUserProfile);
    on<OnResetUserProfile>(_onResetUserProfile);
  }

  void _onFetchInfo(OnFetchInfo event, Emitter<AppState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(packageInfo: packageInfo));
  }

  void _onFetchUserProfile(
    OnFetchUserProfile event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await repository.fetchUserProfile(
      sdkRequest: event.sdkRequest,
    );
    emit(state.copyWith(isLoading: false));
    if (response.data != null) {
      emit(
        state.copyWith(
          userProfileResponse: response.data,
          userProfileFetched: true,
        ),
      );
    }
  }

  void _onResetUserProfile(
    OnResetUserProfile event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(userProfileFetched: false));
  }
}
