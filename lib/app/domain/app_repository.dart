import 'package:loan_sdk_package/app/data/models/request/sdk_request.dart';

import '../data/models/dto/response.dart';
import '../data/models/response/user_profile_response.dart';

abstract class AppRepository {
  Future<RepoResponse<UserProfileResponse>> fetchUserProfile(
      {required SdkRequest sdkRequest});
}
