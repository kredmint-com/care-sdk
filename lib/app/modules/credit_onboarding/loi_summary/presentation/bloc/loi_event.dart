sealed class LoiEvent {}

class OnAcceptLoi extends LoiEvent {
  final bool val;

  OnAcceptLoi({required this.val});
}

class OnPatchLoi extends LoiEvent {
  final String pageCategory;
  final String pageId;
  final String profileId;

  OnPatchLoi({
    required this.pageCategory,
    required this.pageId,
    required this.profileId,
  });
}

class OnReset extends LoiEvent {}
