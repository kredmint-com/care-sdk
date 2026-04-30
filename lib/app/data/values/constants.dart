import 'package:flutter/material.dart';
// import 'package:flutter_alice/alice.dart';

class Timeouts {
  Timeouts._privateConstructor();

  static const CONNECT_TIMEOUT = 30000;
  static const RECEIVE_TIMEOUT = 30000;
}

class Constants {
  static int resentOtpCount = 30;
  // static Alice alice = Alice(
  //   showNotification: true,
  //   navigatorKey: GlobalKeys.navigationKey,
  // );

  static const String packageName = "loan_sdk_package";
}

class GlobalKeys {
  GlobalKeys._privateConstructor();

  static final navigationKey = GlobalKey<NavigatorState>();
}
