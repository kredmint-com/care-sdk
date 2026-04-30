import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_pages.dart';

class CreditCommonMethod {
  static void onBackPress({
    required String prevPageId,
    required String profileId,
    required BuildContext context,
  }) {
    if (prevPageId.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      return;
    }
    context.replaceNamed(
      Routes.sdkCreditOnboarding,
      extra: {"profileId": profileId, "prevPageId": prevPageId},
    );
  }
}
