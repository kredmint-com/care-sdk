import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/gst/presentation/bloc/gst_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/gst/presentation/bloc/gst_state.dart';
import 'package:loan_sdk_package/utils/helper/common_method.dart';
import 'package:loan_sdk_package/utils/loading/loading_utils.dart';

class GstBloc extends Bloc<GstEvent, GstState> {
  final CreditOnboardingRepository repository;
  final CommonMethod commonMethod;

  GstBloc({
    required this.repository,
    required this.commonMethod,
  }) : super(GstState()) {
    on<OnSendMailTap>(_onSendMailTap);
    on<OnReset>(_onReset);
    on<OnSubmitButtonClicked>(_onSubmitButtonClicked);
  }

  void _onSendMailTap(OnSendMailTap event, Emitter<GstState> emit) async {
    Map<String, dynamic> dataMap = {};
    emit(state.copyWith(submitClicked: true));
    LoadingUtils.showLoader();
    final response = await repository.sendReport(
      type: "EMAIL",
      reportType: "GST",
      username: event.gst,
      password: event.email,
      profileId: event.profileId,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      dataMap["staticPageRes"] = response.data?.toJson();
      dataMap["pageId"] = event.pageId;
      dataMap["pageCategory"] = event.pageCategory;
      dataMap["refId"] = response.data?.payload?.refId ?? "";
      emit(state.copyWith(dataMap: dataMap));
    }
  }

  void _onReset(OnReset event, Emitter<GstState> emit) {
    emit(state.copyWith(submitClicked: false, dataMap: {}));
  }

  void _onSubmitButtonClicked(
      OnSubmitButtonClicked event, Emitter<GstState> emit) {
    emit(state.copyWith(submitClicked: true));
  }
}
