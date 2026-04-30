// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../app/config/env.dart';
// import '../app/modules/splash/data/models/app_config_response.dart';
// import '../utils/helper/enums.dart';
//
// class AppUpdateService {
//   Future<AppUpdateAction> checkIfUpdateAvailable({
//     required AppConfigResponse? appConfigResponse,
//   }) async {
//     try {
//       if (appConfigResponse != null) {
//         final appUpdate = appConfigResponse.payload?.appUpdate;
//         if (appUpdate?.flexibleUpdate == true) {
//           return await startFlexibleUpdate();
//         } else if (appUpdate?.forceUpdate == true) {
//           debugPrint("App config response : ${appUpdate?.toJson()}");
//           return await startForceUpdate();
//         } else {
//           // checkUserStatus();
//           return AppUpdateAction.none;
//         }
//       } else {
//         // checkUserStatus();
//         return AppUpdateAction.none;
//       }
//     } catch (e) {
//       debugPrint("Update check failed: $e");
//       // checkUserStatus();
//       return AppUpdateAction.none;
//     }
//   }
//
//   Future<AppUpdateAction> startFlexibleUpdate() async {
//     try {
//       if(Platform.isIOS){
//         return AppUpdateAction.showFlexibleDialog;
//       }
//       AppUpdateInfo? info;
//       try {
//         info = await InAppUpdate.checkForUpdate();
//       } catch (e) {
//         debugPrint("Force Update required 2 : $e");
//       }
//       if (info?.installStatus == InstallStatus.downloaded) {
//         debugPrint("Completing downloaded update...");
//         try {
//           await InAppUpdate.completeFlexibleUpdate();
//         } catch (e) {
//           debugPrint("Error completing update: $e");
//         }
//         return AppUpdateAction.none;
//       }
//
//       if (info?.updateAvailability == UpdateAvailability.updateAvailable) {
//         InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
//           if (appUpdateResult == AppUpdateResult.success) {
//             // InAppUpdate.completeFlexibleUpdate();
//           }
//         }).catchError((e) {
//           debugPrint("startFlexibleUpdate error: $e");
//         });
//
//         return AppUpdateAction.none;
//       } else {
//         return AppUpdateAction.showFlexibleDialog;
//       }
//     } catch (e) {
//       debugPrint("Flexible update failed: $e");
//       // checkUserStatus();
//       return AppUpdateAction.none;
//     }
//   }
//
//   Future<AppUpdateAction> startForceUpdate() async {
//     try {
//       if(Platform.isIOS){
//         return AppUpdateAction.showForceDialog;
//       }
//       AppUpdateInfo? info;
//       // LoadingUtils.showLoader();
//       debugPrint("Force Update required 1");
//       try {
//         info = await InAppUpdate.checkForUpdate();
//       } catch (e) {
//         debugPrint("Force Update required 2 : $e");
//       }
//       // LoadingUtils.hideLoader();
//       if (info?.updateAvailability == UpdateAvailability.updateAvailable) {
//         AppUpdateResult result = await InAppUpdate.performImmediateUpdate();
//         if (result == AppUpdateResult.userDeniedUpdate) {
//           return AppUpdateAction.showForceDialog;
//         } else {
//           return AppUpdateAction.none;
//         }
//       } else {
//         return AppUpdateAction.showForceDialog;
//       }
//     } catch (e) {
//       debugPrint("Force update failed: $e");
//       // checkUserStatus();
//       return AppUpdateAction.none;
//     }
//   }
//
//   Future<void> redirectUserToPlayStore() async {
//     await launchUrl(Uri.parse(Env.playStoreUrl));
//   }
//
//   Future<void> redirectUserToAppStore() async {
//     await launchUrl(Uri.parse(Env.appStoreUrl));
//   }
//
// }
