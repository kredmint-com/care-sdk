import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_sdk_package/app/app.dart';
import 'package:loan_sdk_package/app/bloc/app_bloc.dart';
import 'package:loan_sdk_package/app/config/release_env.dart';
import 'package:loan_sdk_package/app/data/models/request/sdk_request.dart';
import 'package:loan_sdk_package/app/route/app_pages.dart';
import 'package:loan_sdk_package/utils/helper/enums.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';

import 'app/data/models/dto/sdk_callback.dart';
import 'app/themes/app_colors.dart';
import 'injection_container.dart';

class LoanSdkPackage {
  static Future<dynamic> open({
    required BuildContext context,
    required SdkRequest sdkRequest,
    Function(
            {required String message,
            required String status,
            required String invoiceNo})?
        onSuccess,
    Function({required String message, required String status})? onFailure,
    Function({required String message, required String status})? onClose,
    String? environment,
  }) async {
    await GetStorage.init("loan-sdk-storage-box");

    Storage.clearStorage();

    await getIt.reset();

    final theme = sdkRequest.theme;

    if (theme?.primaryColor != null) {
      AppColors.buttonBgColor = Color(theme!.primaryColor!);
    }

    if (theme?.secondaryColor != null) {
      AppColors.headingColor = Color(theme!.secondaryColor!);
    }

    AppColors.buttonTextColor = AppColors.black;

    if (environment?.isNotEmpty ?? false) {
      if (environment == ReleaseEnv.uat.name) {
        releaseEv = ReleaseEnv.dev;
      } else if (environment == ReleaseEnv.prod.name) {
        releaseEv = ReleaseEnv.prod;
      }
    }

    setup(
      callbacks: SdkCallbacks(
        onSuccess: onSuccess,
        onFailure: onFailure,
        onClose: onClose,
      ),
    );

    AppPages.router.go(Routes.initial);

    return await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<AppBloc>(),
          child: _SdkContainer(sdkRequest: sdkRequest),
        ),
      ),
    );
  }
}

class _SdkContainer extends StatelessWidget {
  final SdkRequest sdkRequest;

  const _SdkContainer({required this.sdkRequest});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        /// FIRST GIVE CURRENT SCREEN CHANCE
        if (SdkBackHandler.onBackPressed != null) {
          final handled = await SdkBackHandler.onBackPressed!();

          if (handled) {
            return;
          }
        }

        final router = AppPages.router;

        /// DEFAULT SDK BACK
        if (router.canPop()) {
          router.pop();
          return;
        }

        getIt<SdkCallbacks>().onClose?.call(
              message: "Sdk closed",
              status: SdkStatus.SDK_CLOSED.name,
            );

        Navigator.of(context).pop();
      },
      child: Navigator(
        onGenerateRoute: (_) {
          return MaterialPageRoute(builder: (_) => App(sdkRequest: sdkRequest));
        },
      ),
    );
  }
}

class SdkBackHandler {
  static Future<bool> Function()? onBackPressed;
}
