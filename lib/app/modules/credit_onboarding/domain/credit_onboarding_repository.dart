import 'package:file_picker/file_picker.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/loi_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/mandate_verify_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/pay_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/payment_patch_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/validate_gst_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/validate_pan_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/verify_esign_response.dart';
import '../../../data/models/dto/response.dart';
import '../data/models/bank_account_detail_response.dart';
import '../data/models/fetch_bank_statement_response.dart';
import '../data/models/onboarding_steps_response.dart';
import '../data/models/send_report_response.dart';
import '../data/models/sync_pan_response.dart';
import '../data/models/upload_document_response.dart';
import '../data/models/validate_bank_response.dart';
import '../data/models/validate_ifsc_response.dart';

abstract class CreditOnboardingRepository {
  Future<RepoResponse<OnboardingStepsResponse>> getOnboardingSteps({
    required String profileId,
    String? pageId,
  });

  Future<RepoResponse<bool>> updateUserProfileStage({
    required String profileId,
    required Map<String, dynamic>? data,
  });

  Future<RepoResponse<ValidateGstResponse>> validateGst({
    required String gstin,
  });

  Future<RepoResponse<ValidateIfscResponse>> validateIfsc({
    required String ifsc,
  });

  // Future<RepoResponse<AddressDetailResponse>> getAddressDetail({
  //   required String pincode,
  // });

  Future<RepoResponse<UploadDocumentResponse>> uploadDocument({
    required PlatformFile? file,
    String? password,
    required String profileId,
  });

  Future<RepoResponse<bool>> deleteDocument({
    required String? id,
    required String profileId,
  });

  Future<RepoResponse<FetchBankStatementResponse>> fetchBankStatement({
    required String profileId,
  });

  Future<RepoResponse<SendReportResponse>> sendReport({
    required String username,
    required String password,
    required String type,
    required String reportType,
    bool itr = false,
    required String profileId,
  });

  Future<RepoResponse<PayResponse>> pay({
    required String amount,
    required String lenderId,
    required String profileId,
    required String paymentType,
  });

  Future<RepoResponse<PaymentPatchResponse>> patchPayment({
    required String orderId,
    required String pgName,
  });

  Future<RepoResponse<LoiResponse>> patchLoi({required String profileId});

  Future<RepoResponse<ValidatePanResponse>> validatePan({
    required String panNumber,
    required String name,
    required String dob,
  });

  Future<RepoResponse<ValidateBankResponse>> validateBank({
    required String name,
    required String bankAccount,
    required String ifsc,
  });

  Future<RepoResponse<BankAccountDetailResponse>> bankAccountDetail({
    required String accountNumber,
    required String ifsc,
    required String bankName,
    required String accountHolderName,
  });

  Future<RepoResponse<EsignVerifyResponse>> verifyEsignStatus({
    required String digioDocId,
  });

  Future<RepoResponse<MandateVerifyResponse>> verifyMandateStatus({
    required String digioDocId,
  });

  Future<RepoResponse<SyncPanResponse>> syncPan({
    required String panNumber,
  });
}
