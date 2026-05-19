import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
import 'package:loan_sdk_package/app/modules/credit_onboarding/review/presentation/views/widgets/review_detail_widget.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../loan_sdk_package.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../data/values/animation.dart';
import '../../../../../data/values/constants.dart';
import '../../../../../data/values/strings.dart';
import '../../../../../themes/styles.dart';
import '../../../credit_common_method.dart';
import '../../../presentation/bloc/credit_onboarding_bloc.dart';
import '../../../presentation/views/widgets/onboarding_app_bar.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    super.key,
    required this.profileId,
    required this.prevPageId,
  });

  final String profileId;
  final String prevPageId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    SdkBackHandler.onBackPressed = null;
  }

  void init() {
    SdkBackHandler.onBackPressed = handleBackPress;
  }

  void handleBackPress() {
    CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreditOnboardingAppBar(title: "", onBackPressed: handleBackPress),
      bottomSheet: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              buttonText: Strings.continueToHome,
            ),
          ),
        ],
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return BlocBuilder<CreditOnboardingBloc, CreditOnboardingState>(
      builder: (context, state) {
        debugPrint("Form loading : ${state.formLoading}");
        if (state.formLoading ?? false) {
          return CircularProgressIndicator();
        }
        return WillPopScope(
          onWillPop: () async {
            handleBackPress();
            return false;
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Lottie.asset(
                  Animations.review,
                  height: 250,
                  width: 250,
                  package: Constants.packageName,
                ),
                Text(
                  Strings.congratulationsUser,
                  style: Styles.tsBlack3BMedium16(),
                ),
                16.h,
                Text(
                  Strings.yourDocumentsHaveBeenSuccessfullySubmitted,
                  style: Styles.tsGrey86Regular12(),
                ),
                23.h,
                ReviewDetailWidget(),
                80.h,
              ],
            ),
          ),
        );
      },
    );
  }
}
