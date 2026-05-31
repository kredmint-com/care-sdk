class EmiState {
  final int? selectedEmiPlanIndex;
  final String? emiPlanType;
  final num? finalAmount;
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;

  EmiState({
    this.selectedEmiPlanIndex,
    this.emiPlanType,
    this.finalAmount,
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
  });

  EmiState copyWith({
    int? selectedEmiPlanIndex,
    String? emiPlanType,
    num? finalAmount,
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
  }) {
    return EmiState(
      selectedEmiPlanIndex: selectedEmiPlanIndex ?? this.selectedEmiPlanIndex,
      emiPlanType: emiPlanType ?? this.emiPlanType,
      finalAmount: finalAmount ?? this.finalAmount,
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
    );
  }
}
