sealed class EmiEvent {}

class OnUpdateSelectedPlanIndex extends EmiEvent {
  final int index;

  OnUpdateSelectedPlanIndex({required this.index});
}

class OnUpdateEmiPlanType extends EmiEvent {
  final String planType;

  OnUpdateEmiPlanType({required this.planType});
}

class OnPatchEmiPlan extends EmiEvent {
  final String? pageId;
  final String? pageCategory;
  final String? tenureId;
  final String? tenureTypeId;
  final num? tenure;
  final String? tenureType;

  OnPatchEmiPlan({
    required this.pageId,
    required this.pageCategory,
    required this.tenureId,
    required this.tenureTypeId,
    required this.tenure,
    required this.tenureType,
  });
}

class OnResetUserProfileStageMapCompleted extends EmiEvent {}
