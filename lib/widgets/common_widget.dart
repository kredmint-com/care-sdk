import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
import '../app/data/values/images.dart';
import '../app/data/values/strings.dart';
import '../app/themes/app_colors.dart';
import '../app/themes/styles.dart';
import 'input_text_field.dart';

class CommonWidget {
  PreferredSizeWidget customAppBar({
    String? title,
    Widget? titleWidget,
    String? subTitle,
    List<Widget>? suffixWidget,
    VoidCallback? onBackPressed,
    TextStyle? titleStyle,
    Color? backgroundColor = AppColors.white,
    bool centerTitle = false,
    bool hideLeading = false,
    var bottom,
    Color? leadingIconColor,
    Widget? leadingWidget,
    double? titleLeftPadding,
  }) {
    return AppBar(
      iconTheme: IconThemeData(
        color: leadingIconColor,
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: !hideLeading,
      backgroundColor: backgroundColor,
      bottom: bottom,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      leading: hideLeading
          ? const SizedBox.shrink()
          : leadingWidget ??
              (onBackPressed != null
                  ? (Platform.isAndroid)
                      ? IconButton(
                          onPressed: onBackPressed,
                          icon: const Icon(Icons.arrow_back),
                        )
                      : IconButton(
                          onPressed: onBackPressed,
                          icon: const Icon(Icons.arrow_back_ios),
                        )
                  : null),
      leadingWidth: hideLeading ? 0 : null,
      title: Padding(
        padding: EdgeInsets.only(
          left: titleLeftPadding ?? 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget ??
                Text(
                  title ?? "",
                  style: titleStyle ?? Styles.tsBlack3BMedium14(),
                ),
            if (subTitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  subTitle,
                  style: Styles.tsBlack3BRegular12Opacity(
                    opacity: 0.6,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: suffixWidget,
      actionsPadding: EdgeInsets.only(right: 16),
    );
  }

  void customDialog({
    required BuildContext context,
    required String heading,
    required String subHeading,
    required VoidCallback onOkTap,
    VoidCallback? onCancelTap,
    String? okButtonText,
    String? cancelButtonText,
    bool barrierDismissible = true,
  }) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return barrierDismissible;
        },
        child: CupertinoAlertDialog(
          title: Text(heading),
          content: SizedBox(width: size.width * 0.9, child: Text(subHeading)),
          actions: [
            if (onCancelTap != null)
              TextButton(
                onPressed: onCancelTap,
                child: Text(cancelButtonText ?? Strings.cancel),
              ),
            TextButton(
              onPressed: onOkTap,
              child: Text(okButtonText ?? Strings.yes),
            ),
          ],
        ),
      ),
    );
  }

  void showOptionBottomSheet({
    required BuildContext context,
    required List<Map<String, String>>? options,
    required Function({required String key, required String value}) onTap,
    required String heading,
    String? value,
    ValueChanged<String>? onSearchChanged,
  }) async {
    debugPrint("Options : $options");
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(heading, style: Styles.tsBlack3BSemiBold16()),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon:
                          Icon(Icons.clear, size: 30, color: AppColors.greyB5),
                    ),
                  ],
                ),
              ),
              if (onSearchChanged != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: TextField(
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: Strings.search,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.greyB5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.greyB5),
                      ),
                    ),
                  ),
                ),
              10.h,
              ListView(
                shrinkWrap: true,
                children: options?.map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListTile(
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: value == option["value"]
                              ? AppColors.primaryColor().withOpacity(0.2)
                              : null,
                          title: Text(option["key"] ?? ""),
                          onTap: () => onTap(
                            key: option["key"] ?? "",
                            value: option["value"] ?? "",
                          ),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSearchableOptionsSheet({
    required BuildContext context,
    required String heading,
    required Widget Function(BuildContext context) optionsBuilder,
    required Function(String) onSearchChanged,
    String? selectedValue,
  }) {
    TextEditingController searchController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (c) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(c).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyD0,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(heading, style: Styles.tsBlack3BSemiBold16()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InputTextField(
                  onChanged: onSearchChanged,
                  textFieldWrapper: searchController,
                  hintText: Strings.search,
                  prefix: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
                    child: SvgPicture.asset(
                      Images.search,
                      color: AppColors.greyB5,
                    ),
                  ),
                  hintStyle: Styles.tsGrey80Regular12(),
                  borderRadius: 30,
                ),
              ),
              20.h,
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: optionsBuilder(c),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget customTile({
    required Function({required String key, required String value}) onTap,
    required String? key,
    required String? value,
    String? selectedValue,
  }) {
    final bool isSelected = selectedValue != null && selectedValue == value;
    return InkWell(
      onTap: () => onTap(key: key ?? "", value: value ?? ""),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor().withOpacity(0.07)
              : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor() : AppColors.greyD0,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.list_alt_outlined,
              color: isSelected ? AppColors.primaryColor() : AppColors.black10,
              size: 18,
            ),
            16.w,
            Expanded(
              child: Text(key ?? "",
                  style: isSelected
                      ? Styles.tsPrimaryBold12()
                      : Styles.tsBlack3BMedium12()),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryColor(),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
