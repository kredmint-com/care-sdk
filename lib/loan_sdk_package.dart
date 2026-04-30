import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_sdk_package/app/app.dart';
import 'package:loan_sdk_package/app/bloc/app_bloc.dart';
import 'package:loan_sdk_package/app/data/models/dto/user_model.dart';
import 'package:loan_sdk_package/app/data/models/request/sdk_request.dart';
import 'package:loan_sdk_package/app/route/app_pages.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';
import 'injection_container.dart';
// import 'package:permission_handler/permission_handler.dart';

class LoanSdkPackage {
  static Future<void> open({
    required BuildContext context,
    required SdkRequest sdkRequest,
    Function(String message)? onSuccess,
  }) async {
    await GetStorage.init("loan-sdk-storage-box");
    await getIt.reset();
    setup();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppPages.router.go(Routes.initial);
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => getIt<AppBloc>(),
                child: App(sdkRequest: sdkRequest),
              ),
        ),
      );
    });
  }
}
