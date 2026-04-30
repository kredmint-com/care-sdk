import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../../utils/helper/enums.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../bank_statement/presentation/views/widgets/document_widget.dart';
import '../../../data/models/onboarding_steps_response.dart';
import '../../bloc/credit_onboarding_bloc.dart';
import '../../bloc/credit_onboarding_event.dart';
import '../../bloc/credit_onboarding_state.dart';
import 'onboarding_textfield.dart';

class CreditOnboardingWidget extends StatefulWidget {
  const CreditOnboardingWidget({
    super.key,
    required this.field,
    required this.submitClicked,
    required this.formKey,
    required this.index,
    required this.profileId,
  });

  final Fields? field;
  final bool submitClicked;
  final GlobalKey<FormState> formKey;
  final int index;
  final String profileId;

  @override
  State<CreditOnboardingWidget> createState() => _CreditOnboardingWidgetState();
}

class _CreditOnboardingWidgetState extends State<CreditOnboardingWidget> {
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
      case "file":
        railType = InputType.file;
        break;
      case "heading":
        railType = InputType.heading;
        break;
      case "checkbox":
        railType = InputType.checkbox;
        break;
    }
    return railType;
  }

  @override
  Widget build(BuildContext context) {
    final inputType = getInputType(val: widget.field?.type ?? "");

    if (inputType == InputType.heading) {
      return Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Text(
          widget.field?.label ?? "",
          style: Styles.tsBlack3BMedium14(),
        ),
      );
    }

    if (inputType == InputType.file) {
      return Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<CreditOnboardingBloc>().add(
                  OnPickStatementFile(profileId: widget.profileId),
                );
              },
              buttonText: Strings.uploadFiles,
              suffixPadding: 8,
              suffixWidget: Icon(Icons.upload, color: AppColors.blue24),
              buttonColor: AppColors.white,
              borderColor: AppColors.blue24,
              buttonRadius: BorderRadius.circular(8),
              buttonTextStyle: Styles.tsBlue24Medium12(),
              buttonPadding: const EdgeInsets.all(8),
              mainAxisSize: MainAxisSize.min,
            ),
            16.h,
            BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
              builder: (context, state) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (state.documentList?.length ?? 0),
                  itemBuilder: (context, index) {
                    return DocumentWidget(
                      file: state.documentList?[index],
                      onDocumentDelete: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<CreditOnboardingBloc>().add(
                          OnDocumentDelete(
                            documentId: state.documentList?[index].id ?? "",
                            index: index,
                            profileId: widget.profileId,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    }

    if (inputType == InputType.checkbox) {
      return Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
          builder: (context, state) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              value: widget.field?.value ?? false,
              onChanged: (val) {
                Fields? data = widget.field?.copyWith(value: val);
                debugPrint("check box value : ${data?.value}");
                context.read<CreditOnboardingBloc>().add(
                  OnUpdateField(field: data, index: widget.index),
                );
              },
              title: Text(
                widget.field?.label ?? "",
                style: Styles.tsBlack3BRegular10(),
              ),
            );
          },
        ),
      );
    }

    return Visibility(
      visible: !(widget.field?.hidden ?? false),
      child: OnboardingTextfield(
        index: widget.index,
        field: widget.field,
        formKey: widget.formKey,
        submitClicked: widget.submitClicked,
      ),
    );
  }
}

// class CreditOnboardingWidgets {
//   static Widget widgetForRail({
//     required BuildContext context,
//     required widget.fields? widget.field,
//     required bool submitClicked,
//     required GlobalKey<FormState> formKey,
//     required int index,
//   }) {
//     final InputType? inputType = getInputType(val: widget.field?.type ?? "");
//     Widget widget = SizedBox();
//     // switch (inputType ?? "") {
//     //   case InputType.text || InputType.select:
//     widget = InputTextwidget.field(
//       textwidget.fieldWrapper: widget.field?.textEditingController ?? TextEditingController(),
//       // keyboardType: getTextInputType(inputType: widget.field?.type ?? ""),
//       labelText: widget.field?.label ?? "",
//       hintText: widget.field?.placeholder ?? "",
//       validator: (String? value) {
//         if ((widget.field?.mandatory ?? false) && (value?.isEmpty ?? false)) {
//           return ErrorMessages.thiswidget.fieldIsRequired;
//         } else if ((value?.isNotEmpty ?? false) &&
//             !RegExp(widget.field?.regex ?? "").hasMatch(value?.trim() ?? "")) {
//           return widget.field?.regexMessage ?? "";
//         }
//         return null;
//       },
//       onChanged: (val) {
//         if (widget.field?.name == "gst") {
//           context.read<CreditOnboardingBloc>().add(OnValidateGst(gstin: val));
//         }
//         widget.fields? data = widget.field?.copyWith(value: val);
//         context.read<CreditOnboardingBloc>().add(
//               OnUpdatewidget.field(
//                 widget.field: data,
//                 index: index,
//               ),
//             );
//         if (submitClicked) {
//           formKey.currentState?.validate();
//         }
//       },
//       readOnly:
//           (inputType == InputType.select) || (inputType == InputType.date),
//       focusNode:
//           (inputType == InputType.select) || (inputType == InputType.date)
//               ? AlwaysDisabledFocusNode()
//               : null,
//       suffix: (inputType == InputType.date)
//           ? Icon(Icons.date_range)
//           : ((widget.field?.value?.isNotEmpty ?? false) &&
//                   inputType == InputType.select)
//               ? IconButton(
//                   onPressed: () {
//                     widget.field?.textEditingController?.text = "";
//                     widget.fields? data = widget.field?.copyWith(value: "");
//                     context.read<CreditOnboardingBloc>().add(
//                           OnUpdatewidget.field(
//                             widget.field: data,
//                             index: index,
//                           ),
//                         );
//                     if (submitClicked) {
//                       formKey.currentState?.validate();
//                     }
//                   },
//                   icon: Icon(
//                     Icons.clear,
//                     color: AppColors.greyB5,
//                   ))
//               : null,
//       onTap: () async {
//         if (inputType == InputType.select) {
//           FocusManager.instance.primaryFocus?.unfocus();
//           CommonWidget().showOptionBottomSheet(
//             heading: widget.field?.label ?? "",
//             value: widget.field?.value,
//             context: context,
//             options: (widget.field?.option) ?? [],
//             onTap: ({required String val}) {
//               context.pop();
//               widget.field?.textEditingController?.text = val;
//               widget.fields? data = widget.field?.copyWith(value: val);
//               context.read<CreditOnboardingBloc>().add(
//                     OnUpdatewidget.field(
//                       widget.field: data,
//                       index: index,
//                     ),
//                   );
//               if (submitClicked) {
//                 formKey.currentState!.validate();
//               }
//             },
//           );
//         } else if (inputType == InputType.date) {
//           FocusManager.instance.primaryFocus?.unfocus();
//           DateTime? dateTime = await showDatePicker(
//             context: context,
//             firstDate: DateTime(1800),
//             lastDate: DateTime.now(),
//             initialDate: DateTime.tryParse(widget.field?.value ?? ""),
//           );
//           widget.field?.textEditingController?.text =
//               dateTime?.formatDateInYMMMD() ?? "";
//           widget.fields? data = widget.field?.copyWith(value: dateTime.toString());
//           context.read<CreditOnboardingBloc>().add(
//                 OnUpdatewidget.field(
//                   widget.field: data,
//                   index: index,
//                 ),
//               );
//           if (submitClicked) {
//             formKey.currentState!.validate();
//           }
//         }
//       },
//     );
//     // }
//     return Padding(
//       padding: const EdgeInsets.only(top: 14.0),
//       child: widget,
//     );
//   }
//
//   static InputType? getInputType({required String val}) {
//     InputType? railType;
//     switch (val) {
//       case "text":
//         railType = InputType.text;
//         break;
//       case "select":
//         railType = InputType.select;
//         break;
//       case "date":
//         railType = InputType.date;
//         break;
//     }
//     return railType;
//   }
//

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
