import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loan_sdk_package/app/data/models/dto/response.dart';
import 'package:loan_sdk_package/app/data/network/network_requester.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/bank_account_detail_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/loi_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/payment_patch_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/sync_pan_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/validate_bank_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/validate_pan_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/verify_esign_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';

import '../../../../../utils/helper/enums.dart';
import '../../../../../utils/helper/exception_handler.dart';
import '../../../../data/values/urls.dart';
import '../models/fetch_bank_statement_response.dart';
import '../models/mandate_verify_response.dart';
import '../models/onboarding_steps_response.dart';
import '../models/pay_response.dart';
import '../models/send_report_response.dart';
import '../models/upload_document_response.dart';
import '../models/validate_gst_response.dart';
import '../models/validate_ifsc_response.dart';

class CreditOnboardingRepositoryImpl extends CreditOnboardingRepository {
  final NetworkRequester networkRequester;

  CreditOnboardingRepositoryImpl({required this.networkRequester});

  @override
  Future<RepoResponse<OnboardingStepsResponse>> getOnboardingSteps({
    required String profileId,
    String? pageId,
  }) async {
    String path = Urls.userProfilePage(baseUrlType: BaseUrlType.lead.name);
    final response = await networkRequester.get(
      path: path,
      query: {
        "accountId": profileId,
        "userProfileId": profileId,
        "pageId": pageId,
      },
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: OnboardingStepsResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<bool>> updateUserProfileStage({
    required String profileId,
    required Map<String, dynamic>? data,
  }) async {
    String path = Urls.updateUserProfileStage(
      baseUrlType: BaseUrlType.lead.name,
    );
    final response = await networkRequester.post(
      path: path,
      query: {"userProfileId": profileId},
      data: data,
    );
    // debugPrint("Data payload : ${json.encode(data)}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: true);
  }

  @override
  Future<RepoResponse<ValidateGstResponse>> validateGst({
    required String gstin,
  }) async {
    String path = Urls.validateGst(baseUrlType: BaseUrlType.master.name);
    final response = await networkRequester.get(
      path: path,
      query: {"gstin": gstin},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ValidateGstResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<ValidateIfscResponse>> validateIfsc({
    required String ifsc,
  }) async {
    String path = Urls.validateIfsc(
      baseUrlType: BaseUrlType.master.name,
      ifsc: ifsc,
    );

    final response = await networkRequester.get(path: path);

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ValidateIfscResponse.fromJson(response));
  }

  // @override
  // Future<RepoResponse<AddressDetailResponse>> getAddressDetail({
  //   required String pincode,
  // }) async {
  //   final response = await networkRequester.get(
  //     path: Urls.getAddressDetail,
  //     query: {"address": pincode, "key": Env.placesApiKey},
  //   );
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: AddressDetailResponse.fromJson(response));
  // }

  @override
  Future<RepoResponse<UploadDocumentResponse>> uploadDocument({
    required PlatformFile? file,
    String? password,
    required String profileId,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file?.path ?? "",
        filename: file?.name.split(".").first ?? "",
        contentType: MediaType("application", "pdf"),
      ),
      'docType': DocumentType.BANK_STATEMENT.name,
      'password': password,
    });
    String path = Urls.uploadDocument(baseUrlType: BaseUrlType.user.name);
    final response = await networkRequester.postFormData(
      path: path,
      query: {"userId": profileId},
      formData: formData,
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UploadDocumentResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<bool>> deleteDocument({
    required String? id,
    required String profileId,
  }) async {
    final response = await networkRequester.delete(
      path: Urls.deleteDocument(baseUrlType: BaseUrlType.user.name),
      query: {"id": id, "uid": profileId},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: true);
  }

  @override
  Future<RepoResponse<FetchBankStatementResponse>> fetchBankStatement({
    required String profileId,
  }) async {
    String path = Urls.netbanking(baseUrlType: BaseUrlType.underwriting.name);
    final response = await networkRequester.get(
      path: path,
      query: {"userId": profileId},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: FetchBankStatementResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<SendReportResponse>> sendReport({
    required String username,
    required String password,
    required String type,
    required String reportType,
    required String profileId,
    bool itr = false,
  }) async {
    final response = await networkRequester.post(
      path: Urls.report(baseUrlType: BaseUrlType.underwriting.name),
      data: (itr)
          ? {
              "type": type,
              "reportType": reportType,
              "userId": profileId,
              "request": {
                "type": type,
                "username": username,
                "password": password,
              },
            }
          : {
              "type": type,
              "reportType": reportType,
              "userId": profileId,
              "request": {
                "type": type,
                "gstin": [username],
                "email": [password],
              },
            },
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: SendReportResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<PayResponse>> pay({
    required String amount,
    required String lenderId,
    required String profileId,
    required String paymentType,
  }) async {
    String path = Urls.pay(baseUrlType: BaseUrlType.account.name);
    final response = await networkRequester.post(
      path: path,
      data: {
        "userId": profileId,
        "paymentType": paymentType,
        "amount": amount,
        "lenderId": lenderId,
        "paymentInProgress": false,
      },
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: PayResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<PaymentPatchResponse>> patchPayment({
    required String orderId,
    required String pgName,
  }) async {
    String path = Urls.pay(baseUrlType: BaseUrlType.account.name);
    final response = await networkRequester.patch(
      path: path,
      data: {"orderId": orderId, "pgName": pgName},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: PaymentPatchResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<LoiResponse>> patchLoi({
    required String profileId,
  }) async {
    String path = Urls.loi(baseUrlType: BaseUrlType.user.name);
    final response = await networkRequester.patch(
      path: path,
      query: {"status": "Accepted", "userId": profileId},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LoiResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<ValidatePanResponse>> validatePan({
    required String panNumber,
    required String name,
    required String dob,
  }) async {
    final response = await networkRequester.get(
      path: Urls.validatePan(baseUrlType: BaseUrlType.master.name),
      query: {"panNumber": panNumber, "name": name, "dob": dob},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ValidatePanResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<ValidateBankResponse>> validateBank({
    required String name,
    required String bankAccount,
    required String ifsc,
  }) async {
    final response = await networkRequester.get(
      path: Urls.validateBank(baseUrlType: BaseUrlType.master.name),
      query: {"name": name, "bankAccount": bankAccount, "ifsc": ifsc},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ValidateBankResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<BankAccountDetailResponse>> bankAccountDetail({
    required String accountNumber,
    required String ifsc,
    required String bankName,
    required String accountHolderName,
  }) async {
    final response = await networkRequester.post(
      path: Urls.bank(baseUrlType: BaseUrlType.account.name),
      data: {
        "accountNumber": accountNumber,
        "ifsc": ifsc,
        "bankName": bankName,
        "accountHolderName": accountHolderName,
        "userId": Storage.getSdkUser()?.id ?? "",
      },
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: BankAccountDetailResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<EsignVerifyResponse>> verifyEsignStatus({
    required String digioDocId,
  }) async {
    final response = await networkRequester.patch(
      path: Urls.verifyEsign(baseUrlType: BaseUrlType.user.name),
      query: {"userId": Storage.getSdkUser()?.id ?? ""},
      data: {
        "digioResponse": {"digioDocId": digioDocId},
        "documentId": digioDocId,
      },
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: EsignVerifyResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<MandateVerifyResponse>> verifyMandateStatus({
    required String digioDocId,
  }) async {
    final response = await networkRequester.patch(
      path: Urls.verifyMandate(baseUrlType: BaseUrlType.user.name),
      query: {"userId": Storage.getSdkUser()?.id ?? ""},
      data: {
        "digioResponse": {"digioDocId": digioDocId},
        "documentId": digioDocId,
      },
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MandateVerifyResponse.fromJson(response));
  }

  @override
  Future<RepoResponse<SyncPanResponse>> syncPan({
    required String panNumber,
  }) async {
    final response = await networkRequester.get(
      path: Urls.syncPan(baseUrlType: BaseUrlType.master.name),
      query: {"panNumber": panNumber},
    );
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: SyncPanResponse.fromJson(response));
  }
}
