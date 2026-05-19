import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/data/values/constants.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../injection_container.dart';
import '../../../../../../loan_sdk_package.dart';
import '../../../../../data/models/dto/sdk_callback.dart';
import '../../../../../data/values/animation.dart';
import '../../../../../themes/styles.dart';
import '../../../credit_common_method.dart';

class ProfileRejectedView extends StatefulWidget {
  const ProfileRejectedView({
    super.key,
    required this.profileId,
    required this.prevPageId,
  });

  final String profileId;
  final String prevPageId;

  @override
  State<ProfileRejectedView> createState() => _ProfileRejectedViewState();
}

class _ProfileRejectedViewState extends State<ProfileRejectedView> {
  Future<bool> handleBackPress() async {
    return await CreditCommonMethod.onBackPress(
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
                    getIt<SdkCallbacks>().onFailure?.call(
                      message: "Loan application failed",
                      status: ProfileStatus.PROFILE_REJECTED.name,
                    );

                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  buttonText: "Okay",
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
        /// 🔴 Top Gradient
        Container(
          height: MediaQuery.of(context).size.height * 0.42,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFEB5757)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        /// Curved white container
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

            /// ❌ Animation Circle
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 6),
                color: Colors.white,
              ),
              child: Lottie.asset(
                Animations.rejected,
                package: Constants.packageName,
              ),
            ),

            30.h,

            /// Title
            Text(
              "Application Rejected",
              style: Styles.tsBlack3BBold26(),
              textAlign: TextAlign.center,
            ),

            12.h,

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "We’re sorry, your loan application could not be approved at this time. You can try again later or contact support for help.",
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
