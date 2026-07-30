import 'dart:convert';

import 'package:loan_sdk_package/app/config/release_env.dart';

class Env {
  static Map<String, String> getBaseUrl() {
    Map<String, String> baseUrlMap = {};
    if (releaseEv.name == ReleaseEnv.prod.name) {
      baseUrlMap = {
        "auth": "https://auth.kredmint.in",
        "master": "https://master.kredmint.in",
        "user": "https://user.kredmint.in",
        "lead": "https://lead-v2.kredmint.in",
        "underwriting": "https://underwriting.kredmint.in",
        "account": "https://account.kredmint.in",
        "event": "https://event.kredmint.in",
        "zappfresh": "https://api.dms.kredmint.in/oms",
        "client": "https://client.kredmint.in/client-integration",
      };
    } else {
      baseUrlMap = {
        "auth": "https://auth-dev.kredmint.in",
        "master": "https://master-dev.kredmint.in",
        "user": "https://user-dev.kredmint.in",
        "lead": "https://lead-dev-v2.kredmint.in",
        "underwriting": "https://underwriting-dev.kredmint.in",
        "account": "https://account-dev.kredmint.in",
        "zappfresh": "https://api.dms.kredmint.in/oms",
        "event": "https://event-dev.kredmint.in",
        "client": "https://client-dev.kredmint.in/client-integration",
      };
    }
    return baseUrlMap;
  }

  static String generateBasicToken({
    required String clientId,
    required String clientSecret,
  }) {
    String combined = '$clientId:$clientSecret';
    String encoded = base64Encode(utf8.encode(combined));
    return "Basic $encoded";
  }

  static const String fontFamily = "Poppins";
}
