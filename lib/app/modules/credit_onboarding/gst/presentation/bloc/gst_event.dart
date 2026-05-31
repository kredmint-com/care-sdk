sealed class GstEvent {}

class OnSendMailTap extends GstEvent {
  final String gst;
  final String email;
  final String pageId;
  final String pageCategory;
  final String profileId;

  OnSendMailTap({
    required this.gst,
    required this.email,
    required this.pageId,
    required this.pageCategory,
    required this.profileId,
  });
}

class OnReset extends GstEvent {}

class OnSubmitButtonClicked extends GstEvent {}
