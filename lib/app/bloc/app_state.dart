import 'package:loan_sdk_package/app/data/models/response/user_profile_response.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppState {
  final PackageInfo? packageInfo;
  final UserProfileResponse? userProfileResponse;
  final bool? userProfileFetched;
  final bool? isLoading;

  AppState({
    this.packageInfo,
    this.userProfileResponse,
    this.userProfileFetched,
    this.isLoading,
  });

  AppState copyWith({
    PackageInfo? packageInfo,
    UserProfileResponse? userProfileResponse,
    bool? userProfileFetched,
    bool? isLoading,
  }) {
    return AppState(
      packageInfo: packageInfo ?? this.packageInfo,
      userProfileResponse: userProfileResponse ?? this.userProfileResponse,
      userProfileFetched: userProfileFetched ?? this.userProfileFetched,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
