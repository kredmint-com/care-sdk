sealed class ItrEvent {}

class OnUpdateSubmitStatus extends ItrEvent {}

class OnContinueTap extends ItrEvent {
  final String username;
  final String password;
  final String pageId;
  final String pageCategory;
  final String profileId;

  OnContinueTap({
    required this.username,
    required this.password,
    required this.pageId,
    required this.pageCategory,
    required this.profileId,
  });
}

class OnReset extends ItrEvent{}

class OnUpdateObscureText extends ItrEvent {}

