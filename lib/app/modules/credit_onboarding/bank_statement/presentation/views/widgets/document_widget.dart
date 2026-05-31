import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/data/models/upload_document_response.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import '../../../../../../themes/app_colors.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({
    super.key,
    required this.file,
    required this.onDocumentDelete,
  });

  final Document? file;
  final VoidCallback onDocumentDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined),
          4.w,
          Expanded(
            child: Text(
              file?.name ?? "",
              style: Styles.tsBlack3BMedium12(),
            ),
          ),
          4.w,
          IconButton(
            onPressed: onDocumentDelete,
            icon: Icon(Icons.delete_outline),
            color: AppColors.redC7,
          )
        ],
      ),
    );
  }
}
