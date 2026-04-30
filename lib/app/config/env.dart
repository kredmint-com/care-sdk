// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
        "master": "https://master-dev.kredmint.in/master",
        "user": "https://user-dev.kredmint.in",
        "lead": "https://lead-dev-v2.kredmint.in",
        "underwriting": "https://underwriting-dev.kredmint.in",
        "account": "https://account-dev.kredmint.in",
        "zappfresh": "https://api.dms.kredmint.in/oms",
        "event": "https://event-dev.kredmint.in",
      };
    }
    return baseUrlMap;
  }

  static String getKredmintBasicToken() {
    String basicToken = "";
    if (releaseEv.name == ReleaseEnv.prod.name) {
      basicToken = "Basic b2F1dGhfY2xpZW50X2lkOnNlY3JldC1hcHA=";
    } else {
      basicToken =
          "Basic cVlTZWRUbGMxOHdrRGR2WGhMTnpUc3V1RU8wZzY2OmowcGRJT3FYNERreVRodzZCbWxGSlg2QnhjR2s3cw==";
    }
    return basicToken;
  }

  static const String fontFamily = "PlusJakartaSans";
  static const String placesApiKey = "AIzaSyC5dquFJ9uVZVR-qyxXfVN2NvOgCTqTZl0";
}
