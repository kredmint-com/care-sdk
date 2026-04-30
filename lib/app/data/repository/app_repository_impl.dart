import 'package:loan_sdk_package/app/data/models/dto/response.dart';
import 'package:loan_sdk_package/app/data/network/network_requester.dart';
import 'package:loan_sdk_package/app/data/values/urls.dart';
import 'package:loan_sdk_package/app/domain/app_repository.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import '../../../utils/helper/exception_handler.dart';
import '../models/request/sdk_request.dart';
import '../models/response/user_profile_response.dart';

class AppRepositoryImpl extends AppRepository {
  final NetworkRequester networkRequester;

  AppRepositoryImpl({required this.networkRequester});

  @override
  Future<RepoResponse<UserProfileResponse>> fetchUserProfile({
    required SdkRequest sdkRequest,
  }) async {
    String path = Urls.eligibility(baseUrlType: BaseUrlType.lead.name);
    final response = await networkRequester.post(
      path: path,
      data: sdkRequest.toJson(),
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UserProfileResponse.fromJson(response));
  }
}
