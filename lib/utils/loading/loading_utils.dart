import 'package:flutter/material.dart';

import '../../service/navigation_service.dart';

class LoadingUtils {
  static bool _isDialogOpen = false;

  /// Show loader
  static void showLoader() {
    if (_isDialogOpen) return;

    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    _isDialogOpen = true;
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true, // ✅ ensures correct navigator
    builder: (_) => const Center(
    child: CircularProgressIndicator(),
    ),
    );

    }

  /// Hide loader
  static void hideLoader() {
    if (!_isDialogOpen) return;

    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    _isDialogOpen = false;

// ✅ Always pop from root navigator (same used in show)
    Navigator.of(context, rootNavigator: true).pop();

  }
}
//
// /// Navigation service for global access
// class NavigationService {
//   static final GlobalKey<NavigatorState> navigatorKey =
//   GlobalKey<NavigatorState>();
// }
