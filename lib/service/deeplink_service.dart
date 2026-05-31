// import 'package:app_links/app_links.dart';
// import 'package:flutter/cupertino.dart';
//
// class DeepLinkService {
//   final AppLinks _appLinks = AppLinks();
//   Function(String billId)? onDeepLink;
//
//   Future<void> init({required Function(String billId) onDeepLink}) async {
//     this.onDeepLink = onDeepLink;
//     debugPrint("🔗 DeepLinkService init called");
//
//     final initialLink = await _appLinks.getInitialLink();
//     debugPrint("🔗 Initial link (cold start): $initialLink");
//
//     if (initialLink != null) {
//       _handleUri(initialLink);
//       return;
//     }
//
//     _appLinks.uriLinkStream.listen((uri) {
//       debugPrint("🔗 Stream link received (foreground): $uri");
//       _handleUri(uri);
//     });
//   }
//
//   void _handleUri(Uri uri) {
//     final billId = uri.queryParameters['billId'] ??
//         uri.pathSegments.lastOrNull ?? '';
//
//     if (billId.isNotEmpty) {
//       onDeepLink?.call(billId);
//     }
//   }
//
//   void dispose() {
//     onDeepLink = null;
//   }
// }
