import 'package:flutter/material.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';

import '../../app/data/values/strings.dart';
import '../../service/navigation_service.dart';

class LoadingUtils {
  static OverlayEntry? _overlayEntry;

  /// Show loader
  static void showLoader({
    String title = Strings.justAMoment,
    String subtitle = Strings.processingYourRequest,
  }) {
    if (_overlayEntry != null) return;

    final overlayState = NavigationService.navigatorKey.currentState?.overlay;

    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) {
        return Material(
          color: AppColors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 28,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
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
