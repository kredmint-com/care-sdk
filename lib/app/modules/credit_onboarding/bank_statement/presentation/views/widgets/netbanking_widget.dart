import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/bank_statement/presentation/bloc/bank_statement_event.dart';
import '../../../../../../../widgets/custom_button.dart';
import '../../../../../../data/values/strings.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/styles.dart';
import '../../bloc/bank_statement_bloc.dart';

class NetbankingWidget extends StatelessWidget {
  const NetbankingWidget({
    super.key,
    required this.profileId,
  });

  final String profileId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onTap: () async {
            context.read<BankStatementBloc>().add(OnFetchBankStatement(
                  profileId: profileId,
                ));
          },
          buttonText: Strings.fetchBankStatement,
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
      ],
    );
  }
}
