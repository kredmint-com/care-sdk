sealed class SuccessEvent {}

class OnSuccess extends SuccessEvent {
  final String? pageId;
  final String? pageCategory;

  OnSuccess({
    required this.pageId,
    required this.pageCategory,
  });
}

class OnResetUserProfileStageMapCompleted extends SuccessEvent {}

class OnTimerCountChange extends SuccessEvent {
  final int count;

  OnTimerCountChange({required this.count});
}



