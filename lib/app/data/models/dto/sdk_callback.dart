class SdkCallbacks {
  final Function({required String message, required String status})? onSuccess;
  final Function({required String message, required String status})? onFailure;
  final Function({required String message, required String status})? onClose;

  SdkCallbacks({
    this.onSuccess,
    this.onFailure,
    this.onClose,
  });
}