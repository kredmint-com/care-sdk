import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/onboarding_steps_response.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/domain/credit_onboarding_repository.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_event.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/utils/helper/common_method.dart';
import 'package:loan_sdk_package/utils/loading/loading_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../utils/helper/enums.dart';
import '../../../../../utils/storage/storage_utils.dart';
import '../../../../data/values/urls.dart';
import '../../../../route/app_pages.dart';
import '../../data/models/upload_document_response.dart';

class CreditOnboardingBloc
    extends Bloc<CreditOnboardingEvent, CreditOnboardingState> {
  final CreditOnboardingRepository repository;
  final CommonMethod commonMethod;

  CreditOnboardingBloc({required this.repository, required this.commonMethod})
    : super(CreditOnboardingState()) {
    on<OnFetchUserProfilePage>(_onFetchUserProfilePage);
    on<OnUpdateSubmitStatus>(_onUpdateSubmitStatus);
    on<OnUpdateField>(_onUpdateField);
    on<OnUpdateUserProfileStage>(_onUpdateUserProfileStage);
    on<OnValidateGst>(_onValidateGst);
    on<OnFetchAddressDetail>(_onFetchAddressDetail);
    on<OnReset>(_onReset);
    on<OnResetStepFound>(_onResetStepFound);
    on<OnPickStatementFile>(_onPickStatementFile);
    on<OnDocumentDelete>(_onDocumentDelete);
    on<OnFilterFieldOptions>(_onFilterFieldOptions);
    on<OnResetFieldOptions>(_onResetFieldOptions);
    on<OnSyncPan>(_onSyncPan);
  }

  void _onFetchUserProfilePage(
    OnFetchUserProfilePage event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    // try {
    emit(state.copyWith(formLoading: true));
    LoadingUtils.showLoader();
    final response = await repository.getOnboardingSteps(
      profileId: event.profileId,
      pageId: event.pageId,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      List<Document>? documentList = [];
      List<Fields?>? fieldsList = response.data?.payload?.page?.fields;
      for (int i = (fieldsList?.length ?? 0) - 1; i >= 0; i--) {
        if (fieldsList?[i]?.type == InputType.address.name) {
          final baseField = fieldsList![i]!;

          fieldsList.removeAt(i);
          debugPrint(
            "Base data value : ${baseField.fieldId} ... ${baseField.type} .. ${baseField.value}",
          );
          String addressLine1 = "";
          String addressLine2 = "";
          String addressLine3 = "";
          String pincode = "";
          String state = "";
          String city = "";
          if (baseField.value is Map<String, dynamic>) {
            addressLine1 = baseField.value["addressLine1"] ?? "";
            addressLine2 = baseField.value["addressLine2"] ?? "";
            addressLine3 = baseField.value["addressLine3"] ?? "";
            pincode = baseField.value["pincode"]?.toString() ?? "";
            state = baseField.value["state"] ?? "";
            city = baseField.value["city"] ?? "";
          }
          fieldsList.insertAll(
            i,
            [
              Fields(
                fieldId: baseField.fieldId,
                type: baseField.type,
                subType: "addressLine1",
                label: "Address line 1",
                value: addressLine1,
                mandatory: baseField.mandatory,
                textEditingController: TextEditingController(),
                fieldKey: GlobalKey(),
              ),
              Fields(
                fieldId: baseField.fieldId,
                type: baseField.type,
                subType: "addressLine2",
                label: "Address line 2",
                value: addressLine2,
                mandatory: false,
                textEditingController: TextEditingController(),
                fieldKey: GlobalKey(),
              ),
              Fields(
                fieldId: baseField.fieldId,
                type: baseField.type,
                subType: "addressLine3",
                label: "Address line 3",
                value: addressLine3,
                mandatory: false,
                textEditingController: TextEditingController(),
                fieldKey: GlobalKey(),
              ),
              Fields(
                fieldId: baseField.fieldId,
                type: KeyboardType.number.name,
                subType: "pincode",
                label: "Pincode",
                value: pincode,
                mandatory: baseField.mandatory,
                regex: r'^\d{6}$',
                regexMessage: ErrorMessages.invalidInput,
                textEditingController: TextEditingController(),
                fieldKey: GlobalKey(),
              ),
              Fields(
                fieldId: baseField.fieldId,
                type: baseField.type,
                subType: "state",
                label: "State",
                value: state,
                mandatory: baseField.mandatory,
                textEditingController: TextEditingController(),
                fieldKey: GlobalKey(),
              ),
              Fields(
                fieldId: baseField.fieldId,
                type: baseField.type,
                subType: "city",
                label: "City",
                value: city,
                mandatory: baseField.mandatory,
                textEditingController: TextEditingController(),
                fieldKey: GlobalKey(),
              ),
            ].whereType<Fields>(),
          );
        } else if (fieldsList?[i]?.type == InputType.file.name) {
          debugPrint(
            "fieldsList?[i]?.value is List<dynamic> : ${fieldsList?[i]?.value is List<dynamic>}",
          );
          if (fieldsList?[i]?.value is List<dynamic>) {
            documentList =
                (fieldsList?[i]?.value as List<dynamic>)
                    .map((ele) => Document.fromJson(ele))
                    .toList();
          }
        }
      }
      emit(
        state.copyWith(
          onboardingStepsResponse: response.data,
          fieldsList: fieldsList,
          formLoading: false,
          documentList: documentList,
          submitClicked: false,
          fieldAutoPopulated: false,
        ),
      );
      navigateUserToParticularStep(
        profileId: event.profileId,
        prevPageId:
            (response.data?.payload?.prePageEnable ?? false)
                ? (response.data?.payload?.prvPageId ?? "")
                : "",
        onboardingStepsResponse: response.data,
      );

      // emit(state.copyWith(stepFound: stepPresent));
    }
    // } catch (e) {
    //   debugPrint("Exception : __onFetchUserProfilePage $e");
    // }
  }

  void navigateUserToParticularStep({
    required String profileId,
    required String prevPageId,
    required OnboardingStepsResponse? onboardingStepsResponse,
  }) async {
    // AppConfigResponse? appConfigResponse = Storage.getAppConfig();
    // // debugPrint("Onboarding step data : ${appConfigResponse?.payload?.meta?.oNBOARDINGSTEPS?.last}...${state.onboardingStepsResponse?.payload?.pageCategory}");
    bool stepPresent = true;
    // appConfigResponse?.payload?.meta?.oNBOARDINGSTEPS
    //     ?.contains(onboardingStepsResponse?.payload?.pageCategory ?? "") ??
    // false;
    debugPrint(
      "Steps present data : $stepPresent .... ${onboardingStepsResponse?.payload?.pageCategory}",
    );
    if (stepPresent) {
      if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.BankStatement.name) {
        AppPages.router.replaceNamed(
          Routes.bankStatement,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "prevPageId": prevPageId,
            "staticPageRes": onboardingStepsResponse?.payload?.staticPageRes,
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory?.contains(
            PageCategory.Promoter.name,
          ) ??
          false) {
        AppPages.router.replaceNamed(
          Routes.promoter,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "prevPageId": prevPageId,
            "staticPageRes": onboardingStepsResponse?.payload?.staticPageRes,
            "mobileNumber":
                onboardingStepsResponse?.payload?.meta?.mobile ?? "",
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.Gst.name) {
        AppPages.router.replaceNamed(
          Routes.gst,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "gst": onboardingStepsResponse?.payload?.meta?.gst ?? "",
            "prevPageId": prevPageId,
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.Review.name) {
        AppPages.router.replaceNamed(
          Routes.review,
          extra: {
            "profileId": profileId,
            "prevPageId": prevPageId,
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.Itr.name) {
        AppPages.router.replaceNamed(
          Routes.itr,
          extra: {
            "profileId": profileId,
            "pan": onboardingStepsResponse?.payload?.meta?.pan ?? "",
            "prevPageId": prevPageId,
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.LoiSummary.name) {
        AppPages.router.replaceNamed(
          Routes.loiSummary,
          extra: {
            "profileId": profileId,
            "prevPageId": prevPageId,
            "loiSummary": onboardingStepsResponse?.payload?.loiSummary,
            "pageId": onboardingStepsResponse?.payload?.pageId,
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.ProcessingFee.name) {
        AppPages.router.replaceNamed(
          Routes.processingFee,
          extra: {
            "profileId": profileId,
            "prevPageId": prevPageId,
            "processingFee": onboardingStepsResponse?.payload?.processingFee,
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.EmiPlans.name) {
        AppPages.router.replaceNamed(
          Routes.emi,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "prevPageId": prevPageId,
            "staticPageRes": onboardingStepsResponse?.payload?.staticPageRes,
            "page": onboardingStepsResponse?.payload?.page,
            "tenureId":
                (onboardingStepsResponse?.payload?.page?.fields?.isEmpty ??
                        true)
                    ? ""
                    : onboardingStepsResponse
                        ?.payload
                        ?.page
                        ?.fields
                        ?.first
                        .fieldId,
            "tenureTypeId":
                ((onboardingStepsResponse?.payload?.page?.fields?.length ??
                            0) >=
                        2)
                    ? (onboardingStepsResponse
                        ?.payload
                        ?.page
                        ?.fields?[1]
                        .fieldId)
                    : "",
          },
        );
      } else if ((onboardingStepsResponse?.payload?.pageCategory ==
              PageCategory.KfsEsignUrl.name) ||
          (onboardingStepsResponse?.payload?.pageCategory ==
              PageCategory.MandateSignUrl.name)) {
        AppPages.router.replaceNamed(
          Routes.kycDetail,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "prevPageId": prevPageId,
            "page": onboardingStepsResponse?.payload?.page,
            "digioKycResponse": DigioKycResponse(
              id:
                  onboardingStepsResponse
                      ?.payload
                      ?.digioKycResponse
                      ?.entityId ??
                  "",
              accessToken: AccessToken(
                id:
                    onboardingStepsResponse?.payload?.digioKycResponse?.id ??
                    "",
              ),
            ),
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.BankDetail.name) {
        AppPages.router.replaceNamed(
          Routes.bankDetail,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "prevPageId": prevPageId,
            "staticPageRes": onboardingStepsResponse?.payload?.staticPageRes,
            "page": onboardingStepsResponse?.payload?.page,
          },
        );
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.Success.name) {
        AppPages.router.replaceNamed(Routes.success);
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.ProfileRejected.name) {
        AppPages.router.replaceNamed(Routes.profileRejected);
      } else if (onboardingStepsResponse?.payload?.pageCategory ==
          PageCategory.DownPayment.name) {
        AppPages.router.replaceNamed(
          Routes.downPayment,
          extra: {
            "pageId": onboardingStepsResponse?.payload?.pageId ?? "",
            "pageCategory":
                onboardingStepsResponse?.payload?.pageCategory ?? "",
            "profileId": profileId,
            "prevPageId": prevPageId,
            "page": onboardingStepsResponse?.payload?.page,
            "processingFeeData":
                onboardingStepsResponse?.payload?.processingFee,
          },
        );
      }
    } else {
      PackageInfo? packageInfo = await PackageInfo.fromPlatform();
      AppPages.router.replaceNamed(
        Routes.webViewService,
        extra: {
          "url": Urls.onboarding(
            userId: Storage.getSdkUser()?.id ?? "",
            token: Storage.getSdkUser()?.accessToken ?? "",
            refreshToken: Storage.getSdkUser()?.refreshToken ?? "",
            buildNo: packageInfo.buildNumber,
            profileId: profileId,
            accountId: Storage.getSdkUser()?.accountId ?? "",
            version: Storage.getSdkUser()?.version ?? "",
          ),
          "title": "",
          //onboardingStepsResponse?.payload?.pageCategory?.removeUnderscoreAndCapitalize,
        },
      );
    }
  }

  void _onUpdateSubmitStatus(
    OnUpdateSubmitStatus event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    emit(state.copyWith(submitClicked: true));
  }

  void _onUpdateField(
    OnUpdateField event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    List<Fields?>? fieldList = state.fieldsList ?? [];
    fieldList[event.index] = event.field;
    List<Fields>? fields =
        fieldList.where((e) => e != null).cast<Fields>().toList();
    OnboardingStepsResponse? updatedOnboardingStepsResponse = state
        .onboardingStepsResponse
        ?.copyWith(
          payload: state.onboardingStepsResponse?.payload?.copyWith(
            page: state.onboardingStepsResponse?.payload?.page?.copyWith(
              fields: fields,
            ),
          ),
        );
    emit(
      state.copyWith(onboardingStepsResponse: updatedOnboardingStepsResponse),
    );
  }

  void _onUpdateUserProfileStage(
    OnUpdateUserProfileStage event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    emit(state.copyWith(userProfileStageUpdated: false));
    LoadingUtils.showLoader();
    Map<String, dynamic>? dataMap = event.data;
    // if(dataMap?["staticPageRes"] == null) {
    //   dataMap?["staticPageRes"] = {};
    // }
    final response = await repository.updateUserProfileStage(
      profileId: event.profileId,
      data: dataMap,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      debugPrint("userProfileStageUpdated");
      emit(state.copyWith(userProfileStageUpdated: true));
    }
  }

  void _onValidateGst(
    OnValidateGst event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    final response = await repository.validateGst(gstin: event.gstin);
    if (response.data != null) {
      List<Fields?>? fieldsList = state.fieldsList;
      // bool businessPanFetched = false;
      // bool businessNameFetched = false;
      // bool businessTypeFetched = false;
      // bool dateOfIncorporationFetched = false;
      for (int i = 0; i < (state.fieldsList?.length ?? 0); i++) {
        if (state.fieldsList?[i]?.name == "pan") {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: event.gstin.substring(2, 12),
            textEditingController: TextEditingController(
              text: event.gstin.substring(2, 12),
            ),
            readOnly: true,
          );
          fieldsList?[i] = field;
        }
        if (state.fieldsList?[i]?.name == "companyType") {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: response.data?.payload?.businessType ?? "",
            textEditingController: TextEditingController(
              text: response.data?.payload?.businessType ?? "",
            ),
            readOnly:
                (response.data?.payload?.businessType?.isNotEmpty ?? false),
          );
          fieldsList?[i] = field;
        }
        if (state.fieldsList?[i]?.name == "incorporationDate") {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: response.data?.payload?.dateOfRegistration ?? "",
            textEditingController: TextEditingController(
              text: response.data?.payload?.dateOfRegistration ?? "",
            ),
            readOnly:
                (response.data?.payload?.dateOfRegistration?.isNotEmpty ??
                    false),
          );
          fieldsList?[i] = field;
        }
        if (state.fieldsList?[i]?.name == "name") {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: response.data?.payload?.legalName ?? "",
            textEditingController: TextEditingController(
              text: response.data?.payload?.legalName ?? "",
            ),
            readOnly: (response.data?.payload?.legalName?.isNotEmpty ?? false),
          );
          fieldsList?[i] = field;
        }
      }
      debugPrint("entered this : ${fieldsList?[2]?.value}");
      emit(state.copyWith(fieldsList: fieldsList, fieldAutoPopulated: true));
    }
  }

  void _onFetchAddressDetail(
    OnFetchAddressDetail event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    final response = await repository.getAddressDetail(pincode: event.pincode);
    if (response.data != null) {
      Map<String, String>? stateCityMap = await commonMethod
          .getStateCityFromAddressResponse(
            addressDetailResponse: response.data,
          );
      List<Fields?>? fieldsList = state.fieldsList;
      for (int i = 0; i < (state.fieldsList?.length ?? 0); i++) {
        if ((stateCityMap?["state"]?.isNotEmpty ?? false) &&
            (state.fieldsList?[i]?.subType == "state")) {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: stateCityMap?["state"],
            textEditingController: TextEditingController(
              text: stateCityMap?["state"],
            ),
          );
          fieldsList?[i] = field;
        }
        if ((stateCityMap?["city"]?.isNotEmpty ?? false) &&
            (state.fieldsList?[i]?.subType == "city")) {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: stateCityMap?["city"],
            textEditingController: TextEditingController(
              text: stateCityMap?["city"],
            ),
          );
          fieldsList?[i] = field;
        }
      }
      emit(state.copyWith(fieldsList: fieldsList, fieldAutoPopulated: true));
    }
  }

  void _onSyncPan(OnSyncPan event, Emitter<CreditOnboardingState> emit) async {
    LoadingUtils.showLoader();
    final response = await repository.syncPan(panNumber: event.panNumber);
    LoadingUtils.hideLoader();
    if (response.data != null) {
      List<Fields?>? fieldsList = state.fieldsList;

      if (response.data?.payload?.status == "INVALID") {
        Fluttertoast.showToast(msg: response.data?.payload?.message ?? "");
        return;
      }
      for (int i = 0; i < (state.fieldsList?.length ?? 0); i++) {
        if (state.fieldsList?[i]?.name == "name") {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: response.data?.payload?.registeredName ?? "",
            textEditingController: TextEditingController(
              text: response.data?.payload?.registeredName ?? "",
            ),
          );
          fieldsList?[i] = field;
        }
        if (state.fieldsList?[i]?.name == "date") {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: response.data?.payload?.dateOfBirth ?? "",
            textEditingController: TextEditingController(
              text: response.data?.payload?.dateOfBirth ?? "",
            ),
          );
          fieldsList?[i] = field;
        }
        if ((response.data?.payload?.address?.pincode != 0) &&
            (state.fieldsList?[i]?.name == "pinCode")) {
          Fields? field = state.fieldsList?[i]?.copyWith(
            value: response.data?.payload?.address?.pincode ?? "",
            textEditingController: TextEditingController(
              text: response.data?.payload?.address?.pincode?.toString() ?? "",
            ),
          );
          fieldsList?[i] = field;
        }
      }
      emit(state.copyWith(fieldsList: fieldsList, fieldAutoPopulated: true));
    }
  }

  void _onReset(OnReset event, Emitter<CreditOnboardingState> emit) async {
    emit(state.copyWith(userProfileStageUpdated: false, submitClicked: false));
  }

  void _onResetStepFound(
    OnResetStepFound event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    emit(state.copyWith(stepFound: true));
  }

  void _onPickStatementFile(
    OnPickStatementFile event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      LoadingUtils.showLoader();
      final response = await repository.uploadDocument(
        file: result.files.single,
        profileId: event.profileId,
      );
      LoadingUtils.hideLoader();
      if (response.data != null) {
        Document? document = response.data?.payload;
        PlatformFile file = result.files.single;
        List<Document>? documentList = state.documentList ?? [];
        documentList.add(
          Document(
            id: document?.id ?? "",
            name: document?.name ?? "",
            url: document?.url ?? "",
            relativeUrl: document?.relativeUrl ?? "",
          ),
        );
        emit(state.copyWith(documentList: documentList));
      }
    }
  }

  void _onDocumentDelete(
    OnDocumentDelete event,
    Emitter<CreditOnboardingState> emit,
  ) async {
    LoadingUtils.showLoader();
    final response = await repository.deleteDocument(
      id: event.documentId,
      profileId: event.profileId,
    );
    LoadingUtils.hideLoader();
    if (response.data != null) {
      List<Document>? documentList = state.documentList ?? [];
      documentList.removeAt(event.index);
      emit(state.copyWith(documentList: documentList));
    }
  }

  void _onFilterFieldOptions(
    OnFilterFieldOptions event,
    Emitter<CreditOnboardingState> emit,
  ) {
    final fieldList = List<Fields?>.from(state.fieldsList ?? []);
    final field = fieldList[event.index];

    final allOptions = List<Option>.from(field?.option ?? []);

    debugPrint("Total options before filter: ${allOptions.length}");

    final filtered =
        event.query.trim().isEmpty
            ? allOptions
            : allOptions.where((option) {
              return (option.name ?? "").toLowerCase().contains(
                event.query.toLowerCase(),
              );
            }).toList();

    debugPrint(
      "Options after filtering for '${event.query}': ${filtered.length}",
    );

    fieldList[event.index] = field?.copyWith(filteredOption: filtered);
    emit(state.copyWith(fieldsList: List<Fields?>.from(fieldList)));
  }

  void _onResetFieldOptions(
    OnResetFieldOptions event,
    Emitter<CreditOnboardingState> emit,
  ) {
    final fieldList = List<Fields?>.from(state.fieldsList ?? []);
    final field = fieldList[event.index];
    final allOptions = List<Option>.from(field?.option ?? []);
    fieldList[event.index] = field?.copyWith(filteredOption: allOptions);
    emit(state.copyWith(fieldsList: List<Fields?>.from(fieldList)));
  }
}
