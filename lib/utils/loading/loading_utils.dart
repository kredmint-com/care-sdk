import 'package:flutter/material.dart';

import '../../service/navigation_service.dart';

// class LoadingUtils {
//   static bool _isDialogOpen = false;
//
//   /// Show loader
//   static void showLoader() {
//     if (_isDialogOpen) return;
//
//     final context = NavigationService.navigatorKey.currentContext;
//     if (context == null) return;
//
//     _isDialogOpen = true;
//     FocusManager.instance.primaryFocus?.unfocus();
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       useRootNavigator: true, // ✅ ensures correct navigator
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   /// Hide loader
//   static void hideLoader() {
//     if (!_isDialogOpen) return;
//
//     final context = NavigationService.navigatorKey.currentContext;
//     if (context == null) return;
//
//     _isDialogOpen = false;
//
//     // ✅ Always pop from root navigator (same used in show)
//     Navigator.of(context, rootNavigator: true).pop();
//   }
// }

import 'package:flutter/material.dart';

class LoadingUtils {

  static OverlayEntry? _overlayEntry;

  /// Show loader
  static void showLoader() {
    if (_overlayEntry != null) return;

    final overlayState = NavigationService.navigatorKey.currentState?.overlay;

    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) {
        return Material(
          color: Colors.black.withOpacity(0.3),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    overlayState.insert(_overlayEntry!);
  }

  /// Hide loader
  static void hideLoader() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
