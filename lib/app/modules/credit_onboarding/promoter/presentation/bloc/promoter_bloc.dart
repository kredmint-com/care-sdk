import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/promoter/presentation/bloc/promoter_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/promoter/presentation/bloc/promoter_state.dart';

import '../../../../../../utils/helper/common_method.dart';
import '../../../../../../utils/loading/loading_utils.dart';
import '../../../data/models/add_promoter_request.dart';
import '../../../domain/credit_onboarding_repository.dart';

class PromoterBloc extends Bloc<PromoterEvent, PromoterState> {
  final CreditOnboardingRepository repository;
  final CommonMethod commonMethod;

  PromoterBloc({
    required this.repository,
    required this.commonMethod,
  }) : super(PromoterState()) {
    on<OnUpdateResidence>(_onUpdateResidence);
    on<OnAddPromoter>(_onAddPromoter);
    on<OnRemovePromoter>(_onRemovePromoter);
    on<OnUpdatePromoter>(_onUpdatePromoter);
    on<OnUpdateCurrentAddressStatus>(_onUpdateCurrentAddressStatus);
    on<OnConfirmPromoters>(_onConfirmPromoters);
    on<OnSubmitClicked>(_onSubmitClicked);
    // on<OnFetchAddressDetail>(_onFetchAddressDetail);
    on<OnResetUserProfileStageMapCompleted>(
        _onResetUserProfileStageMapCompleted);
    on<OnValidatePan>(_onValidatePan);
    on<OnResetPanValidation>(_onResetPanValidation);
    on<OnResetNameMatched>(_onResetNameMatched);
    on<OnResetDobMatched>(_onResetDobMatched);
  }

  void _onUpdateResidence(
      OnUpdateResidence event, Emitter<PromoterState> emit) {
    emit(state.copyWith(residenceType: event.residence));
  }

  void _onAddPromoter(OnAddPromoter event, Emitter<PromoterState> emit) {
    List<Promoter?> promoterList = state.promoterList ?? [];
    for (int i = 0; i < event.promoter.length; i++) {
      promoterList.add(event.promoter[i]);
    }
    List<Promoter?> updatedPromoterList = promoterList;
    emit(state.copyWith(promoterList: updatedPromoterList));
    debugPrint("_onAddPromoter data : ${state.promoterList?.length}");
  }

  void _onRemovePromoter(OnRemovePromoter event, Emitter<PromoterState> emit) {
    List<Promoter?> promoterList = state.promoterList ?? [];
    promoterList.removeAt(event.index);
    emit(state.copyWith(promoterList: promoterList));
    debugPrint("_onAddPromoter data : ${state.promoterList?.length}");
  }

  void _onUpdatePromoter(OnUpdatePromoter event, Emitter<PromoterState> emit) {
    List<Promoter?> promoterList = state.promoterList ?? [];
    promoterList[event.index] = event.promoter.first;
    // List<Promoter?> updatedPromoterList = promoterList;
    emit(state.copyWith(promoterList: promoterList));
    debugPrint("_onAddPromoter data : ${state.promoterList?.length}");
  }

  void _onUpdateCurrentAddressStatus(
      OnUpdateCurrentAddressStatus event, Emitter<PromoterState> emit) {
    emit(state.copyWith(sameAsCurrentAddress: event.sameAsCurrentAddress));
  }

  void _onSubmitClicked(OnSubmitClicked event, Emitter<PromoterState> emit) {
    emit(state.copyWith(
      submitClicked: true,
    ));
  }

  void _onConfirmPromoters(
      OnConfirmPromoters event, Emitter<PromoterState> emit) {
    emit(state.copyWith(userProfileStageMapCompleted: false));
    debugPrint("Promoter list length : ${state.promoterList}");
    Map<String, dynamic> userProfileStageMap = {
      "staticPageRes": [],
      "pageId": event.pageId,
      "pageCategory": event.pageCategory,
    };
    List<Map<String, dynamic>> staticPageMapList = [];
    for (int i = 0; i < (state.promoterList?.length ?? 0); i++) {
      Map<String, dynamic> promoterMap = {};
      state.promoterList?[i]?.toJson().forEach(
        (key, value) {
          promoterMap[key] = value;
        },
      );
      staticPageMapList.add(promoterMap);
    }
    userProfileStageMap["staticPageRes"] = staticPageMapList;
    debugPrint(
        "Final data map : ${json.encode(userProfileStageMap["staticPageRes"])}");
    emit(state.copyWith(
      userProfileStageMapCompleted: true,
      userProfileStageMap: userProfileStageMap,
    ));
  }

  // void _onFetchAddressDetail(
  //     OnFetchAddressDetail event, Emitter<PromoterState> emit) async {
  //   final response = await repository.getAddressDetail(pincode: event.pincode);
  //   if (response.data != null) {
  //     Map<String, String>? stateCityMap =
  //         await commonMethod.getStateCityFromAddressResponse(
  //       addressDetailResponse: response.data,
  //     );
  //     if (event.isCurrentAddress) {
  //       stateCityMap?["addressType"] = AddressType.current.name;
  //     } else {
  //       stateCityMap?["addressType"] = AddressType.permanent.name;
  //     }
  //     emit(state.copyWith(stateCityMap: stateCityMap));
  //   }
  // }

  void _onResetUserProfileStageMapCompleted(
      OnResetUserProfileStageMapCompleted event, Emitter<PromoterState> emit) {
    emit(state.copyWith(
      userProfileStageMapCompleted: false,
      userProfileStageMap: {},
    ));
  }

  void _onValidatePan(OnValidatePan event, Emitter<PromoterState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.validatePan(
      panNumber: event.panNumber,
      name: event.name,
      dob: event.dob,
    );
    LoadingUtils.hideLoader();
    emit(
      state.copyWith(
          nameMatched: (response.data?.payload?.nameMatched) ?? false,
          dobMatched: (response.data?.payload?.dobMatched) ?? false,
          panValidated: true,
          panValidationApiLimitReached: (response.data == null)),
    );
  }

  void _onResetPanValidation(
      OnResetPanValidation event, Emitter<PromoterState> emit) {
    emit(state.copyWith(
      // nameMatched: true,
      // dobMatched: true,
      panValidated: false,
      // panValidationApiLimitReached: false,
    ));
  }

  void _onResetNameMatched(
      OnResetNameMatched event, Emitter<PromoterState> emit) {
    emit(state.copyWith(
      nameMatched: true,
      panValidationApiLimitReached: false,
    ));
  }

  void _onResetDobMatched(
      OnResetDobMatched event, Emitter<PromoterState> emit) {
    emit(state.copyWith(
      dobMatched: true,
      panValidationApiLimitReached: false,
    ));
  }
}
