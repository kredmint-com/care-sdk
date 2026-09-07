class SuccessState {
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;
  final int? remainingSeconds;

  SuccessState({
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
    this.remainingSeconds,
  });

  SuccessState copyWith({
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
    int? remainingSeconds,
  }) {
    return SuccessState(
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}
