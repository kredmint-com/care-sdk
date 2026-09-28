import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_pages.dart';

class CreditCommonMethod {
  static Future<bool> onBackPress({
    required String prevPageId,
    required String profileId,
    required BuildContext context,
    String? proposalId,
  }) async {
    if (prevPageId.isNotEmpty) {
      context.replaceNamed(
        Routes.sdkCreditOnboarding,
        extra: {
          "profileId": profileId,
          "prevPageId": prevPageId,
          "proposalId": proposalId,
        },
      );
    }
    return true;
  }
}
