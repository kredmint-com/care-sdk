import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../injection_container.dart';
import '../../../../../../loan_sdk_package.dart';
import '../../../../../data/models/dto/sdk_callback.dart';
import '../../../../../data/values/animation.dart';
import '../../../../../data/values/constants.dart';
import '../../../../../themes/styles.dart';
import '../../../credit_common_method.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({
    super.key,
    required this.profileId,
    required this.prevPageId,
  });

  final String profileId;
  final String prevPageId;

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  Future<bool> handleBackPress() async {
    return CreditCommonMethod.onBackPress(
      context: context,
      prevPageId: widget.prevPageId,
      profileId: widget.profileId,
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackPress,
      child: Scaffold(
        bottomSheet: Wrap(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                  onTap: () {
                    getIt<SdkCallbacks>().onSuccess?.call(
                      message: "Loan applied successfully",
                      status: ProfileStatus.PROFILE_COMPLETED.name,
                    );

                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  buttonText: Strings.proceed,
                ),
              ),
            ),
          ],
        ),
        body: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.42,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6FCF97), Color(0xFF56CC8A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.32,
            ),
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
            ),
          ),
        ),

        Column(
          children: [
            const Spacer(),

            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 6),
                color: Colors.white,
              ),
              child: Lottie.asset(
                Animations.review,
                package: Constants.packageName,
              ),
            ),

            30.h,

            Text(
              Strings.congratulations,
              style: Styles.tsBlack3BBold26(),
              textAlign: TextAlign.center,
            ),

            12.h,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                Strings.yourLoanApplicationHasBeenApprovedSuccessfully,
                textAlign: TextAlign.center,
                style: Styles.tsBlack3BRegular16().copyWith(
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ],
    );
  }
}
