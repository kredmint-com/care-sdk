import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/data/values/strings.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/app/themes/styles.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';

class PromoterTileWidget extends StatelessWidget {
  const PromoterTileWidget({
    super.key,
    required this.name,
    required this.panNumber,
    required this.address,
    required this.index,
    required this.onDropdownButtonToggle,
  });

  final String name;
  final String panNumber;
  final String address;
  final int index;
  final Function({required String? val}) onDropdownButtonToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blue8C),
        borderRadius: BorderRadius.circular(9),
        color: AppColors.white,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Director No.${index + 1}",
                  style: Styles.tsBlack3BRegular14()),
              SizedBox(
                width: 100,
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.centerRight,
                  selectedItemBuilder: (BuildContext context) {
                    return ["Edit", "Delete"].map((String value) {
                      return SizedBox(); // return empty widget to hide text
                    }).toList();
                  },
                  underline: SizedBox.shrink(),
                  value: "Edit",
                  icon: Icon(Icons.more_horiz),
                  elevation: 16,
                  onChanged: (String? val) {
                    onDropdownButtonToggle(val: val);
                  },
                  items: ["Edit", "Delete"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          8.h,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.blueF0F),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    promoterDataWidget(
                      title: Strings.name,
                      value: name,
                    ),
                    promoterDataWidget(
                      title: Strings.panNumber,
                      value: panNumber,
                    ),
                  ],
                ),
                16.h,
                promoterDataWidget(
                  title: Strings.address,
                  value: address,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget promoterDataWidget({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.tsGrey86Regular12(),
        ),
        Text(
          value,
          style: Styles.tsBlack3BRegular14(),
        ),
      ],
    );
  }
}
