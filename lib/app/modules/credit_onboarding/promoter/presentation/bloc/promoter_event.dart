import '../../../data/models/add_promoter_request.dart';

sealed class PromoterEvent {}

class OnUpdateResidence extends PromoterEvent {
  final String residence;

  OnUpdateResidence({required this.residence});
}

class OnUpdateCurrentAddressStatus extends PromoterEvent {
  final bool sameAsCurrentAddress;

  OnUpdateCurrentAddressStatus({required this.sameAsCurrentAddress});
}

class OnAddPromoter extends PromoterEvent {
  final List<Promoter?> promoter;

  OnAddPromoter({
    required this.promoter,
  });
}

class OnRemovePromoter extends PromoterEvent {
  final List<Promoter?> promoter;
  final int index;

  OnRemovePromoter({required this.promoter, required this.index});
}

class OnUpdatePromoter extends PromoterEvent {
  final List<Promoter?> promoter;
  final int index;

  OnUpdatePromoter({
    required this.promoter,
    required this.index,
  });
}

class OnConfirmPromoters extends PromoterEvent {
  final String pageId;
  final String pageCategory;

  OnConfirmPromoters({
    required this.pageId,
    required this.pageCategory,
  });
}

class OnSubmitClicked extends PromoterEvent {}

class OnFetchAddressDetail extends PromoterEvent {
  final String pincode;
  final bool isCurrentAddress;

  OnFetchAddressDetail({
    required this.pincode,
    this.isCurrentAddress = false,
  });
}

class OnResetUserProfileStageMapCompleted extends PromoterEvent {}

class OnValidatePan extends PromoterEvent {
  String panNumber;
  String name;
  String dob;

  OnValidatePan({
    required this.panNumber,
    required this.name,
    required this.dob,
  });
}

class OnResetPanValidation extends PromoterEvent {}

class OnResetNameMatched extends PromoterEvent {}

class OnResetDobMatched extends PromoterEvent {}
