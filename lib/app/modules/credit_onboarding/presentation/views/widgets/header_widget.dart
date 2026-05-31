import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.iconUrl,
  });

  final String heading;
  final String subHeading;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: Styles.tsBlack3BMedium16(),
              ),
              2.h,
              Text(
                subHeading,
                style: Styles.tsGrey86Regular12(),
              ),
            ],
          ),
        ),
        if (iconUrl.isNotEmpty) ...[
          20.w,
          (iconUrl.split(".").last == "svg")
              ? SvgPicture.network(
                  iconUrl,
                  height: 55,
                  width: 55,
                )
              : Image.network(
                  iconUrl,
                  height: 55,
                  width: 55,
                )
        ],
      ],
    );
  }
}
