import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/data/values/constants.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import 'package:loan_sdk_package/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import '../../../../../data/values/animation.dart';
import '../../../../../themes/styles.dart';

class ProfileRejectedView extends StatelessWidget {
  const ProfileRejectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Wrap(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                onTap: () {
                },
                buttonText: "Okay",
              ),
            ),
          ),
        ],
      ),
      body: bodyWidget(context: context),
    );
  }

  Widget bodyWidget({required BuildContext context}) {
    return Stack(
      children: [
        // 🔴 Top Gradient (Red tone for rejection)
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

        // Curved white container
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

            // ❌ Circle with rejection animation
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

            // Title
            Text(
              "Application Rejected",
              style: Styles.tsBlack3BBold26(),
              textAlign: TextAlign.center,
            ),

            12.h,

            // Description
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
