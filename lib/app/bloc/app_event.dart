import 'package:loan_sdk_package/app/data/models/request/sdk_request.dart';

sealed class AppEvent {}

class OnFetchInfo extends AppEvent {}

class OnFetchUserProfile extends AppEvent {
  final SdkRequest sdkRequest;

  OnFetchUserProfile({required this.sdkRequest});
}

class OnResetUserProfile extends AppEvent {}



