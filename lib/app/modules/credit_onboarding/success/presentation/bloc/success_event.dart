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



