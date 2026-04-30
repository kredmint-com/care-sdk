import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/date_extension.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/utils/helper/string_extension.dart';
import '../../../../../../utils/helper/enums.dart';
import '../../../../../../widgets/common_widget.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/input_text_field.dart';
import '../../../../../data/values/images.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../themes/app_colors.dart';
import '../../../data/models/add_promoter_request.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../../presentation/views/widgets/credit_onboarding_widgets.dart';
import '../../../presentation/views/widgets/header_widget.dart';
import '../bloc/promoter_bloc.dart';
import '../bloc/promoter_event.dart';
import '../bloc/promoter_state.dart';

class AddPromoterView extends StatefulWidget {
  const AddPromoterView({
    super.key,
    this.promoterData,
    required this.appBarTitle,
    required this.mobileNumber,
    required this.page,
  });

  final Promoter? promoterData;
  final String appBarTitle;
  final String? mobileNumber;
  final StepsPage? page;

  @override
  State<AddPromoterView> createState() => _AddPromoterViewState();
}

class _AddPromoterViewState extends State<AddPromoterView> {
  final nameController = TextEditingController();
  GlobalKey<FormFieldState<String>> nameFieldKey =
      GlobalKey<FormFieldState<String>>();
  final panController = TextEditingController();
  GlobalKey<FormFieldState<String>> panFieldKey =
      GlobalKey<FormFieldState<String>>();

  final dobController = TextEditingController();
  GlobalKey<FormFieldState<String>> dobFieldKey =
      GlobalKey<FormFieldState<String>>();

  final mobileController = TextEditingController();
  GlobalKey<FormFieldState<String>> mobileFieldKey =
      GlobalKey<FormFieldState<String>>();

  final emailController = TextEditingController();
  GlobalKey<FormFieldState<String>> emailFieldKey =
      GlobalKey<FormFieldState<String>>();

  final aadharController = TextEditingController();
  GlobalKey<FormFieldState<String>> aadharFieldKey =
      GlobalKey<FormFieldState<String>>();

  final genderController = TextEditingController();
  GlobalKey<FormFieldState<String>> genderFieldKey =
      GlobalKey<FormFieldState<String>>();

  final currentAddressLine1Controller = TextEditingController();
  GlobalKey<FormFieldState<String>> currentAddressLine1FieldKey =
      GlobalKey<FormFieldState<String>>();

  final currentAddressLine2Controller = TextEditingController();
  GlobalKey<FormFieldState<String>> currentAddressLine2FieldKey =
      GlobalKey<FormFieldState<String>>();

  final currentAddressLine3Controller = TextEditingController();
  GlobalKey<FormFieldState<String>> currentAddressLine3FieldKey =
      GlobalKey<FormFieldState<String>>();

  final currentPincodeController = TextEditingController();
  GlobalKey<FormFieldState<String>> currentPincodeFieldKey =
      GlobalKey<FormFieldState<String>>();

  final currentStateController = TextEditingController();
  GlobalKey<FormFieldState<String>> currentStateFieldKey =
      GlobalKey<FormFieldState<String>>();

  final currentCityController = TextEditingController();
  GlobalKey<FormFieldState<String>> currentCityFieldKey =
      GlobalKey<FormFieldState<String>>();

  final permanentAddressLine1Controller = TextEditingController();
  GlobalKey<FormFieldState<String>> permanentAddressLine1FieldKey =
      GlobalKey<FormFieldState<String>>();

  final permanentAddressLine2Controller = TextEditingController();
  GlobalKey<FormFieldState<String>> permanentAddressLine2FieldKey =
      GlobalKey<FormFieldState<String>>();

  final permanentAddressLine3Controller = TextEditingController();
  GlobalKey<FormFieldState<String>> permanentAddressLine3FieldKey =
      GlobalKey<FormFieldState<String>>();

  final permanentPincodeController = TextEditingController();
  GlobalKey<FormFieldState<String>> permanentPincodeFieldKey =
      GlobalKey<FormFieldState<String>>();

  final permanentStateController = TextEditingController();
  GlobalKey<FormFieldState<String>> permanentStateFieldKey =
      GlobalKey<FormFieldState<String>>();

  final permanentCityController = TextEditingController();
  GlobalKey<FormFieldState<String>> permanentCityFieldKey =
      GlobalKey<FormFieldState<String>>();

  ScrollController scrollController = ScrollController();

  final formKey = GlobalKey<FormState>();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
    scrollController.dispose();
    nameFieldKey.currentState?.dispose();
    panFieldKey.currentState?.validate();
    dobFieldKey.currentState?.validate();
    mobileFieldKey.currentState?.validate();
    emailFieldKey.currentState?.validate();
    aadharFieldKey.currentState?.validate();
    genderFieldKey.currentState?.validate();
    currentAddressLine1FieldKey.currentState?.validate();
    currentAddressLine2FieldKey.currentState?.validate();
    currentAddressLine3FieldKey.currentState?.validate();
    currentPincodeFieldKey.currentState?.dispose();
    currentStateFieldKey.currentState?.dispose();
    currentCityFieldKey.currentState?.dispose();
    permanentAddressLine1FieldKey.currentState?.validate();
    permanentAddressLine2FieldKey.currentState?.validate();
    permanentAddressLine3FieldKey.currentState?.validate();
    permanentAddressLine3FieldKey.currentState?.validate();
    permanentPincodeFieldKey.currentState?.dispose();
    permanentStateFieldKey.currentState?.dispose();
    permanentCityFieldKey.currentState?.dispose();
  }

  void init() {
    setPromoterData();
  }

  void setPromoterData() {
    mobileController.text = widget.mobileNumber ?? "";
    Promoter? promoter = widget.promoterData;
    if (promoter != null) {
      nameController.text = promoter.name ?? "";
      panController.text = promoter.pan ?? "";
      if (promoter.dob != null) {
        dobController.text =
            DateTime.fromMillisecondsSinceEpoch(promoter.dob ?? 0)
                .formatInYYYYMMD();
        debugPrint(
            "promoter.isSameAsCurrentAddress : ${DateTime.fromMicrosecondsSinceEpoch(promoter.dob ?? 0).formatInYYYYMMD()}");
      }
      mobileController.text = promoter.mobile?.toString() ?? "";
      emailController.text = promoter.email?.toString() ?? "";
      aadharController.text = promoter.aadharNumber ?? "";
      genderController.text = promoter.gender ?? "";
      currentAddressLine1Controller.text = promoter.address?.addressLine1 ?? "";
      currentAddressLine2Controller.text = promoter.address?.addressLine2 ?? "";
      currentAddressLine3Controller.text = promoter.address?.addressLine3 ?? "";
      currentPincodeController.text = promoter.address?.pincode ?? "";
      currentStateController.text = promoter.address?.state ?? "";
      currentCityController.text = promoter.address?.city ?? "";
      permanentAddressLine1Controller.text =
          promoter.permanentAddress?.addressLine1 ?? "";
      permanentAddressLine2Controller.text =
          promoter.permanentAddress?.addressLine2 ?? "";
      permanentAddressLine3Controller.text =
          promoter.permanentAddress?.addressLine3 ?? "";
      permanentPincodeController.text =
          promoter.permanentAddress?.pincode ?? "";
      permanentStateController.text = promoter.permanentAddress?.state ?? "";
      permanentCityController.text = promoter.permanentAddress?.city ?? "";
      context.read<PromoterBloc>().add(
            OnUpdateResidence(
              residence: promoter.residence ?? "",
            ),
          );
      context.read<PromoterBloc>().add(
            OnUpdateCurrentAddressStatus(
              sameAsCurrentAddress: promoter.isSameAsCurrentAddress ?? false,
            ),
          );
    }
  }

  void saveData({required PromoterState state}) {
    if (formKey.currentState?.validate() ?? false) {
      if (state.residenceType?.isEmpty ?? true) {
        Fluttertoast.showToast(msg: ErrorMessages.residenceIsRequired);
      } else if ((state.nameMatched ?? false) && (state.dobMatched ?? false)) {
        // if ((formKey.currentState?.validate() ?? false)) {
        context.pop(
          Promoter(
            id: DateTime.now().millisecondsSinceEpoch,
            name: nameController.text.trim(),
            pan: panController.text.trim(),
            dob: DateTime.tryParse(dobController.text)?.millisecondsSinceEpoch,
            mobile: mobileController.text.trim(),
            email: emailController.text.trim(),
            aadharNumber: aadharController.text.trim(),
            gender: genderController.text.trim(),
            address: Address(
              addressLine1: currentAddressLine1Controller.text.trim(),
              addressLine2: currentAddressLine2Controller.text.trim(),
              addressLine3: currentAddressLine3Controller.text.trim(),
              pincode: currentPincodeController.text.trim(),
              state: currentStateController.text.trim(),
              city: currentCityController.text.trim(),
            ),
            isSameAsCurrentAddress: state.sameAsCurrentAddress ?? false,
            permanentAddress: Address(
              addressLine1: permanentAddressLine1Controller.text.trim(),
              addressLine2: permanentAddressLine2Controller.text.trim(),
              addressLine3: permanentAddressLine3Controller.text.trim(),
              pincode: permanentPincodeController.text.trim(),
              state: permanentStateController.text.trim(),
              city: permanentCityController.text.trim(),
            ),
            residence: state.residenceType,
          ),
        );
      }
      // }
    }
  }

  void scrollToFirstInvalidField() {
    debugPrint("Entered scrollToFirstInvalidField");
    final fieldKeys = [
      nameFieldKey,
      panFieldKey,
      dobFieldKey,
      mobileFieldKey,
      emailFieldKey,
      aadharFieldKey,
      genderFieldKey,
      currentAddressLine1FieldKey,
      currentAddressLine2FieldKey,
      currentAddressLine3FieldKey,
      currentPincodeFieldKey,
      currentStateFieldKey,
      currentCityFieldKey,
      permanentAddressLine1FieldKey,
      permanentAddressLine2FieldKey,
      permanentAddressLine3FieldKey,
      permanentStateFieldKey,
      permanentCityFieldKey,
      permanentPincodeFieldKey,
    ];

    for (final key in fieldKeys) {
      final fieldState = key?.currentState;
      if (fieldState != null && fieldState.hasError) {
        final context = key?.currentContext;
        if (context != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 400),
              alignment: 0.1,
              curve: Curves.easeInOut,
            );
          });
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget().customAppBar(
        title: "",
      ),
      bottomSheet: Wrap(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16,
              ),
              child: BlocBuilder<PromoterBloc, PromoterState>(
                  builder: (context, state) {
                return CustomButton(
                  onTap: () {
                    debugPrint("OnTap called");
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<PromoterBloc>().add(OnSubmitClicked());
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<PromoterBloc>().add(
                            OnValidatePan(
                              panNumber: panController.text.trim(),
                              name: nameController.text.trim().toUpperCase(),
                              dob: DateTime.parse(dobController.text)
                                  .formatInDDMMYYYY(),
                            ),
                          );
                    } else {
                      scrollToFirstInvalidField();
                    }
                  },
                  buttonText: Strings.proceed,
                  buttonRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  // buttonColor: AppColors.blue24,
                );
              })),
        ],
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return BlocConsumer<PromoterBloc, PromoterState>(
        listener: (context, state) {
      if (state.stateCityMap?.isNotEmpty ?? false) {
        if ((state.stateCityMap?["addressType"] ?? "") ==
            AddressType.permanent.name) {
          permanentStateController.text = state.stateCityMap?["state"] ?? "";
          permanentCityController.text = state.stateCityMap?["city"] ?? "";
        } else {
          currentStateController.text = state.stateCityMap?["state"] ?? "";
          currentCityController.text = state.stateCityMap?["city"] ?? "";
        }
      }
      debugPrint("PAn validated data : ${state.panValidated}");
      if (state.panValidated ?? false) {
        if (state.submitClicked ?? false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            saveData(
              state: state,
            );
          });
        }
        context.read<PromoterBloc>().add(OnResetPanValidation());
      }
    }, builder: (context, state) {
      return Form(
        key: formKey,
        autovalidateMode: (state.submitClicked ?? false)
            ? AutovalidateMode.onUserInteraction
            : null,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                heading: widget.page?.heading?.title ?? "",
                subHeading: widget.page?.heading?.subTitle ?? "",
                iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
                    ? (widget.page?.heading?.appLogo ?? "")
                    : ((widget.page?.heading?.pageLogo) ?? ""),
              ),
              20.h,
              InputTextField(
                formFieldKey: nameFieldKey,
                textFieldWrapper: nameController,
                hintText: Strings.nameAsPerPanWithAsterisk,
                labelText: Strings.nameAsPerPanWithAsterisk,
                validator: (String? val) {
                  debugPrint(
                      "Name mmatched : ${state.nameMatched} ${state.dobMatched}");
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(state.panValidationApiLimitReached ?? false) &&
                      !(state.nameMatched ?? true)) {
                    return ErrorMessages.providedNameDoesNotAlignsWithPan;
                  }
                  return null;
                },
                onChanged: (val) {
                  if (state.submitClicked ?? false) {
                    if (debounce?.isActive ?? false) debounce?.cancel();

                    debounce = Timer(const Duration(milliseconds: 500), () {
                      context.read<PromoterBloc>().add(OnResetNameMatched());
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        formKey.currentState?.validate();
                      });
                    });
                  }
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: panFieldKey,
                textFieldWrapper: panController,
                hintText: Strings.panWithAsterisk,
                labelText: Strings.panWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(val?.isValidPan() ?? false)) {
                    return ErrorMessages.invalidInput;
                  }
                  return null;
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: dobFieldKey,
                readOnly: true,
                focusNode: AlwaysDisabledFocusNode(),
                textFieldWrapper: dobController,
                hintText: Strings.dobAsPerPanWithAsterisk,
                labelText: Strings.dobAsPerPanWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(state.panValidationApiLimitReached ?? false) &&
                      !(state.dobMatched ?? true)) {
                    return ErrorMessages.providedDobDoesNotAlignsWithPan;
                  }
                  return null;
                },
                suffix: Icon(Icons.date_range),
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (state.submitClicked ?? false) {
                    context.read<PromoterBloc>().add(OnResetDobMatched());
                    if (state.submitClicked ?? false) {
                      formKey.currentState?.validate();
                    }
                  }
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1800),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.tryParse(dobController.text.trim()),
                  );
                  dobController.text = dateTime?.formatInYYYYMMD() ?? "";

                  // context.read<PromoterBloc>().add(
                  //       OnValidatePan(
                  //         panNumber: panController.text.trim(),
                  //         name: nameController.text.trim().toUpperCase(),
                  //         dob: DateTime.parse(dobController.text)
                  //             .formatInDDMMYYYY(),
                  //       ),
                  //     );
                  // if (state.submitClicked ?? false) {
                  //   formKey.currentState?.validate();
                  // }
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: mobileFieldKey,
                textFieldWrapper: mobileController,
                readOnly: (widget.mobileNumber?.isNotEmpty ?? false),
                hintText: Strings.mobileWithAsterisk,
                labelText: Strings.mobileWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(val?.isValidPhone() ?? false)) {
                    return ErrorMessages.invalidInput;
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.number,
              ),
              14.h,
              InputTextField(
                formFieldKey: emailFieldKey,
                textFieldWrapper: emailController,
                hintText: Strings.emailWithAsterisk,
                labelText: Strings.emailWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(val?.isValidEmail() ?? false)) {
                    return ErrorMessages.invalidInput;
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              14.h,
              InputTextField(
                formFieldKey: aadharFieldKey,
                textFieldWrapper: aadharController,
                hintText: Strings.aadharNumberWithAsterisk,
                labelText: Strings.aadharNumberWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(val?.isValidAadhaar() ?? false)) {
                    return ErrorMessages.invalidInput;
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
              ),
              14.h,
              InputTextField(
                formFieldKey: genderFieldKey,
                textFieldWrapper: genderController,
                readOnly: true,
                hintText: Strings.genderWithAsterisk,
                labelText: Strings.genderWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  CommonWidget().showOptionBottomSheet(
                    heading: "Select Gender",
                    value: genderController.text.trim(),
                    context: context,
                    options: [
                      {"key": "Male", "value": "Male"},
                      {"key": "Female", "value": "Female"},
                      {"key": "Other", "value": "Other"},
                    ],
                    onTap: ({required String key, required String value}){
                      context.pop();
                      genderController.text = key;
                      // widget.field?.textEditingController?.text = val;
                      // Fields? data = widget.field?.copyWith(value: val);
                      // context.read<CreditOnboardingBloc>().add(
                      //   OnUpdateField(
                      //     field: data,
                      //     index: widget.index,
                      //   ),
                      // );
                      // if (widget.submitClicked) {
                      //   widget.formKey.currentState!.validate();
                      // }
                    },
                  );
                },
              ),
              20.h,
              Text(
                Strings.currentAddress,
                style: Styles.tsBlack3BMedium12(),
              ),
              12.h,
              InputTextField(
                formFieldKey: currentAddressLine1FieldKey,
                textFieldWrapper: currentAddressLine1Controller,
                hintText: Strings.addressLine1WithAsterisk,
                labelText: Strings.addressLine1WithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: currentAddressLine2FieldKey,
                textFieldWrapper: currentAddressLine2Controller,
                hintText: Strings.addressLine2,
                labelText: Strings.addressLine2,
              ),
              14.h,
              InputTextField(
                formFieldKey: currentAddressLine3FieldKey,
                textFieldWrapper: currentAddressLine3Controller,
                hintText: Strings.addressLine3,
                labelText: Strings.addressLine3,
              ),
              14.h,
              InputTextField(
                formFieldKey: currentPincodeFieldKey,
                textFieldWrapper: currentPincodeController,
                hintText: Strings.pincodeWithAsterisk,
                labelText: Strings.pincodeWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(val?.isValidPincode() ?? false)) {
                    return ErrorMessages.invalidInput;
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  context.read<PromoterBloc>().add(
                        OnFetchAddressDetail(
                          pincode: val.trim(),
                          isCurrentAddress: true,
                        ),
                      );
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: currentCityFieldKey,
                textFieldWrapper: currentCityController,
                hintText: Strings.cityWithAsterisk,
                labelText: Strings.cityWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: currentStateFieldKey,
                textFieldWrapper: currentStateController,
                hintText: Strings.stateWithAsterisk,
                labelText: Strings.stateWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
              20.h,
              Text(
                Strings.permanentAddress,
                style: Styles.tsBlack3BMedium12(),
              ),
              8.h,
              BlocBuilder<PromoterBloc, PromoterState>(
                  builder: (context, state) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    Strings.sameAsCurrentAddress,
                    style: Styles.tsBlack3BMedium14(),
                  ),
                  value: state.sameAsCurrentAddress ?? false,
                  onChanged: (val) {
                    context.read<PromoterBloc>().add(
                          OnUpdateCurrentAddressStatus(
                            sameAsCurrentAddress: val ?? false,
                          ),
                        );
                    if (val ?? false) {
                      permanentAddressLine1Controller.text =
                          currentAddressLine1Controller.text.trim();
                      permanentAddressLine2Controller.text =
                          currentAddressLine2Controller.text.trim();
                      permanentAddressLine3Controller.text =
                          currentAddressLine3Controller.text.trim();
                      permanentPincodeController.text =
                          currentPincodeController.text.trim();
                      permanentStateController.text =
                          currentStateController.text.trim();
                      permanentCityController.text =
                          currentCityController.text.trim();
                    }
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                );
              }),
              14.h,
              InputTextField(
                formFieldKey: permanentAddressLine1FieldKey,
                textFieldWrapper: permanentAddressLine1Controller,
                hintText: Strings.addressLine1WithAsterisk,
                labelText: Strings.addressLine1WithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: permanentAddressLine2FieldKey,
                textFieldWrapper: permanentAddressLine2Controller,
                hintText: Strings.addressLine2,
                labelText: Strings.addressLine2,
              ),
              14.h,
              InputTextField(
                formFieldKey: permanentAddressLine3FieldKey,
                textFieldWrapper: permanentAddressLine3Controller,
                hintText: Strings.addressLine3,
                labelText: Strings.addressLine3,
              ),
              14.h,
              InputTextField(
                formFieldKey: permanentPincodeFieldKey,
                textFieldWrapper: permanentPincodeController,
                hintText: Strings.pincodeWithAsterisk,
                labelText: Strings.pincodeWithAsterisk,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  } else if (!(val?.isValidPincode() ?? false)) {
                    return ErrorMessages.invalidInput;
                  }
                  return null;
                },
                onChanged: (val) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(const Duration(milliseconds: 500), () {
                    context.read<PromoterBloc>().add(
                          OnFetchAddressDetail(
                            pincode: val.trim(),
                          ),
                        );
                  });
                },
                keyboardType: TextInputType.number,
              ),
              14.h,
              InputTextField(
                formFieldKey: permanentCityFieldKey,
                textFieldWrapper: permanentCityController,
                hintText: Strings.cityWithAsterisk,
                labelText: Strings.cityWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
              14.h,
              InputTextField(
                formFieldKey: permanentStateFieldKey,
                textFieldWrapper: permanentStateController,
                hintText: Strings.stateWithAsterisk,
                labelText: Strings.stateWithAsterisk,
                validator: (String? val) {
                  if (val?.isDataEmpty() ?? true) {
                    return ErrorMessages.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
              14.h,
              Text(Strings.yourResidenceIsWithAsterisk),
              BlocBuilder<PromoterBloc, PromoterState>(
                  builder: (context, state) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: Strings.owned,
                        groupValue: state.residenceType,
                        onChanged: (value) {
                          context
                              .read<PromoterBloc>()
                              .add(OnUpdateResidence(residence: Strings.owned));
                        },
                        title: Text(Strings.owned),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: Strings.rented,
                        groupValue: state.residenceType,
                        onChanged: (value) {
                          context.read<PromoterBloc>().add(
                              OnUpdateResidence(residence: Strings.rented));
                        },
                        title: Text(Strings.rented),
                      ),
                    ),
                  ],
                );
              }),
              80.h,
            ],
          ),
        ),
      );
    });
  }
}
