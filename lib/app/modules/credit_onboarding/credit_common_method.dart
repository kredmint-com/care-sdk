import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../injection_container.dart';
import '../../../utils/helper/enums.dart';
import '../../data/models/dto/sdk_callback.dart';
import '../../route/app_pages.dart';

class CreditCommonMethod {
  static Future<bool> onBackPress({
    required String prevPageId,
    required String profileId,
    required BuildContext context,
  }) async {
    debugPrint("onBackPress called : $prevPageId");
    if (prevPageId.isEmpty) {
      getIt<SdkCallbacks>().onClose?.call(
        message: "Sdk closed",
        status: SdkStatus.SDK_CLOSED.name,
      );
      Navigator.of(context, rootNavigator: true).pop();
    }else {
      context.replaceNamed(
        Routes.sdkCreditOnboarding,
        extra: {"profileId": profileId, "prevPageId": prevPageId},
      );
    }
    return true;
  }
}
