import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

import '../../../../../../../widgets/custom_button.dart';
import '../../../../../../data/values/strings.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/styles.dart';
import '../../bloc/bank_statement_bloc.dart';
import '../../bloc/bank_statement_event.dart';
import '../../bloc/bank_statement_state.dart';
import 'document_widget.dart';

class UploadBankStatementWidget extends StatelessWidget {
  const UploadBankStatementWidget({
    super.key,
    required this.profileId,
  });

  final String profileId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomButton(
          onTap: () async {
            context.read<BankStatementBloc>().add(
                  OnPickStatementFile(
                    profileId: profileId,
                  ),
                );
          },
          buttonText: Strings.uploadFiles,
          suffixPadding: 8,
          suffixWidget: Icon(
            Icons.upload,
            color: AppColors.blue24,
          ),
          buttonColor: AppColors.white,
          borderColor: AppColors.blue24,
          buttonRadius: BorderRadius.circular(8),
          buttonTextStyle: Styles.tsBlue24Medium12(),
          buttonPadding: EdgeInsets.all(8),
          mainAxisSize: MainAxisSize.min,
        ),
        16.h,
        BlocBuilder<BankStatementBloc, BankStatementState>(
            builder: (context, state) {
          debugPrint(
              "Document list length : ${(state.documentList?.length ?? 0)}");
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (state.documentList?.length ?? 0),
            itemBuilder: (context, index) {
              return DocumentWidget(
                  file: state.documentList?[index],
                  onDocumentDelete: () {
                    context.read<BankStatementBloc>().add(
                          OnDocumentDelete(
                            documentId: state.documentList?[index].id ?? "",
                            index: index,
                            profileId: profileId,
                          ),
                        );
                  });
            },
          );
        }),
      ],
    );
  }
}
