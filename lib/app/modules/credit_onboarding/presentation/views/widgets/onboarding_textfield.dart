import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utils/helper/enums.dart';
import '../../../../../../widgets/common_widget.dart';
import '../../../../../../widgets/input_text_field.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../themes/app_colors.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../bloc/credit_onboarding_bloc.dart';
import '../../bloc/credit_onboarding_event.dart';
import '../../bloc/credit_onboarding_state.dart';
import 'credit_onboarding_widgets.dart';

class OnboardingTextfield extends StatefulWidget {
  const OnboardingTextfield({
    super.key,
    required this.field,
    required this.submitClicked,
    required this.index,
    required this.formKey,
  });

  final Fields? field;
  final bool submitClicked;
  final int index;
  final GlobalKey<FormState> formKey;

  @override
  State<OnboardingTextfield> createState() => _OnboardingTextfieldState();
}

class _OnboardingTextfieldState extends State<OnboardingTextfield> {
  InputType? inputType = InputType.text;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  void init() async {
    widget.field?.textEditingController?.text =
        widget.field?.value?.toString() ?? "";
    inputType = getInputType(val: widget.field?.type ?? "");
  }

  InputType? getInputType({required String val}) {
    InputType? railType;
    switch (val) {
      case "text":
        railType = InputType.text;
        break;
      case "select":
        railType = InputType.select;
        break;
      case "date":
        railType = InputType.date;
        break;
    }
    return railType;
  }

  TextInputType? getTextInputType({required String inputType}) {
    if (inputType == KeyboardType.number.name) {
      return TextInputType.number;
    } else if (inputType == KeyboardType.text.name) {
      return TextInputType.text;
    } else if (inputType == KeyboardType.email.name) {
      return TextInputType.emailAddress;
    }
    return TextInputType.text;
  }

  List<TextInputFormatter> getInputFormatters({required Fields? field}) {
    final inputType = getTextInputType(inputType: field?.type ?? "");
    final name = widget.field?.name;

    if (inputType == TextInputType.number) {
      if (name == "pinCode") {
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ];
      }
      return [FilteringTextInputFormatter.digitsOnly];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: InputTextField(
        capitalize: widget.field?.name == "pan",
        formFieldKey: widget.field?.fieldKey,
        textFieldWrapper:
            widget.field?.textEditingController ?? TextEditingController(),
        keyboardType: getTextInputType(inputType: widget.field?.type ?? ""),
        labelText: (widget.field?.mandatory ?? false)
            ? "${widget.field?.label ?? ""}*"
            : widget.field?.label ?? "",
        hintText: widget.field?.placeholder ?? "",
        validator: (String? value) {
          if ((widget.field?.mandatory ?? false) && (value?.isEmpty ?? false)) {
            return ErrorMessages.thisFieldIsRequired;
          } else if ((value?.isNotEmpty ?? false) &&
              !RegExp(
                widget.field?.regex ?? "",
              ).hasMatch(value?.trim() ?? "")) {
            return widget.field?.regexMessage ?? "";
          }
          return null;
        },
        inputFormatters: getInputFormatters(field: widget.field),
        onChanged: (val) {
          if (debounce?.isActive ?? false) debounce?.cancel();

          debounce = Timer(const Duration(milliseconds: 500), () {
            if (widget.field?.name == "gst") {
              context.read<CreditOnboardingBloc>().add(
                    OnValidateGst(gstin: val),
                  );
            }
            // if (widget.field?.subType == "pincode") {
            //   context.read<CreditOnboardingBloc>().add(
            //     OnFetchAddressDetail(pincode: val),
            //   );
            // }
            if (widget.field?.name == "pan") {
              if (val.length == 10) {
                context.read<CreditOnboardingBloc>().add(
                      OnSyncPan(panNumber: val, fieldIndex: widget.index),
                    );
              }
            }
          });
          Fields? data = widget.field?.copyWith(
            value: (widget.field?.type == KeyboardType.number.name)
                ? (int.tryParse(val) ?? "")
                : val,
          );
          context.read<CreditOnboardingBloc>().add(
                OnUpdateField(field: data, index: widget.index),
              );
          if (widget.submitClicked) {
            widget.formKey.currentState?.validate();
          }
        },
        readOnly: (inputType == InputType.select) ||
            (inputType == InputType.date) ||
            (widget.field?.name == "name") ||
            (widget.field?.readOnly ?? false),
        focusNode: (inputType == InputType.select) ||
                (inputType == InputType.date) ||
                (widget.field?.name == "name")
            ? AlwaysDisabledFocusNode()
            : null,
        suffix: (inputType == InputType.date)
            ? Icon(Icons.date_range)
            : ((widget.field?.value?.toString().isNotEmpty ?? false) &&
                    (inputType == InputType.select) &&
                    (!(widget.field?.readOnly ?? false)))
                ? IconButton(
                    onPressed: () {
                      widget.field?.textEditingController?.text = "";
                      Fields? data = widget.field?.copyWith(value: "");
                      context.read<CreditOnboardingBloc>().add(
                            OnUpdateField(field: data, index: widget.index),
                          );
                      if (widget.submitClicked) {
                        widget.formKey.currentState?.validate();
                      }
                    },
                    icon: Icon(Icons.clear, color: AppColors.greyB5),
                  )
                : null,
        onTap: () async {
          if (!(widget.field?.readOnly ?? false)) {
            if (inputType == InputType.select) {
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<CreditOnboardingBloc>().add(
                    OnResetFieldOptions(index: widget.index),
                  );
              CommonWidget().showSearchableOptionsSheet(
                heading: widget.field?.label ?? "",
                context: context,
                selectedValue: widget.field?.value,
                optionsBuilder: (_) {
                  return BlocProvider.value(
                    value: context.read<CreditOnboardingBloc>(),
                    child: BlocBuilder<CreditOnboardingBloc,
                        CreditOnboardingState>(
                      builder: (context, state) {
                        final field = state.fieldsList?[widget.index];
                        final options = List<Option>.from(
                          field?.filteredOption ?? [],
                        );

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, i) {
                            final key = options[i].name ?? "";
                            final value = options[i].value ?? "";
                            return CommonWidget().customTile(
                              key: key,
                              value: value,
                              selectedValue: field?.value,
                              onTap: ({
                                required String key,
                                required String value,
                              }) {
                                context.pop();
                                widget.field?.textEditingController?.text = key;
                                Fields? data = widget.field?.copyWith(
                                  value: value,
                                );
                                context.read<CreditOnboardingBloc>().add(
                                      OnUpdateField(
                                        field: data,
                                        index: widget.index,
                                      ),
                                    );
                                if (widget.submitClicked) {
                                  widget.formKey.currentState!.validate();
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        );
                      },
                    ),
                  );
                },
                onSearchChanged: (query) {
                  context.read<CreditOnboardingBloc>().add(
                        OnFilterFieldOptions(query: query, index: widget.index),
                      );
                },
              );
            }
            // else if (inputType == InputType.date) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            //   DateTime? dateTime = await showDatePicker(
            //     context: context,
            //     firstDate: DateTime(1800),
            //     lastDate: DateTime.now(),
            //     initialDate: CommonMethod().parseDate(date : widget.field?.value) ?? DateTime.now(),
            //   );
            //   if (dateTime != null) {
            //     widget.field?.textEditingController?.text =
            //         dateTime.formatInYYYYMMD() ?? "";
            //     Fields? data = widget.field?.copyWith(
            //       value: dateTime.formatInYYYYMMD(),
            //     );
            //     context.read<CreditOnboardingBloc>().add(
            //       OnUpdateField(field: data, index: widget.index),
            //     );
            //     if (widget.submitClicked) {
            //       widget.formKey.currentState!.validate();
            //     }
            //   }
            // }
          }
        },
      ),
    );
  }
}
