class SuccessState {
  final Map<String, dynamic>? userProfileStageMap;
  final bool? userProfileStageMapCompleted;

  SuccessState({
    this.userProfileStageMap,
    this.userProfileStageMapCompleted,
  });

  SuccessState copyWith({
    Map<String, dynamic>? userProfileStageMap,
    bool? userProfileStageMapCompleted,
  }) {
    return SuccessState(
      userProfileStageMap: userProfileStageMap ?? this.userProfileStageMap,
      userProfileStageMapCompleted:
          userProfileStageMapCompleted ?? this.userProfileStageMapCompleted,
    );
  }
}
