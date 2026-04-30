// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/itr/presentation/bloc/itr_state.dart';
// import 'package:loan_sdk_package/utils/loading/loading_utils.dart';
// import 'itr_event.dart';
//
// class ItrBloc extends Bloc<ItrEvent, ItrState> {
//   final CreditOnboardingRepository repository;
//
//   ItrBloc({
//     required this.repository,
//   }) : super(ItrState()) {
//     on<OnUpdateSubmitStatus>(_onUpdateSubmitStatus);
//     on<OnContinueTap>(_onContinueTap);
//     on<OnReset>(_onReset);
//     on<OnUpdateObscureText>(_onUpdateObscureText);
//   }
//
//   void _onUpdateSubmitStatus(
//       OnUpdateSubmitStatus event, Emitter<ItrState> emit) {
//     emit(state.copyWith(submitClicked: true));
//   }
//
//   void _onContinueTap(OnContinueTap event, Emitter<ItrState> emit) async {
//     Map<String, dynamic> dataMap = {};
//     LoadingUtils.showLoader();
//     final response = await repository.sendReport(
//       username: event.username,
//       password: event.password,
//       type: "ITR_REPORT",
//       reportType: "ITR",
//       itr: true,
//       profileId: event.profileId,
//     );
//     LoadingUtils.hideLoader();
//     if (response.data != null) {
//       if (response.data?.payload?.success ?? false) {
//         dataMap["staticPageRes"] = response.data?.toJson();
//         dataMap["pageId"] = event.pageId;
//         dataMap["pageCategory"] = event.pageCategory;
//         dataMap["refId"] = response.data?.payload?.refId ?? "";
//         emit(state.copyWith(dataMap: dataMap));
//       } else {
//         Fluttertoast.showToast(
//           msg: response.data?.payload?.msg ?? "",
//         );
//       }
//     }
//   }
//
//   void _onReset(OnReset event, Emitter<ItrState> emit) {
//     emit(state.copyWith(submitClicked: false, dataMap: {}));
//   }
//
//   void _onUpdateObscureText(OnUpdateObscureText event, Emitter<ItrState> emit) {
//     emit(state.copyWith(obscureText: !(state.obscureText ?? false)));
//   }
// }
