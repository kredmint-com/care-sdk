// import 'package:firebase_analytics/firebase_analytics.dart';
//
// class AnalyticsService {
//   static FirebaseAnalytics? firebaseAnalytics;
//   static FirebaseAnalyticsObserver? observer;
//
//   void init() {
//     firebaseAnalytics = FirebaseAnalytics.instance;
//     if (firebaseAnalytics != null) {
//       observer = FirebaseAnalyticsObserver(analytics: firebaseAnalytics!);
//     }
//   }
//
//   static void setUserAnalyticProperties({required String userId}) {
//     firebaseAnalytics?.setUserId(id: userId);
//   }
//
//   static void logApiErrorEvent({
//     required String errorCode,
//     required String errorMessage,
//     required String path,
//   }) {
//     firebaseAnalytics?.logEvent(
//       name: "api_error_$errorCode",
//       parameters: {
//         "error_message": errorMessage,
//         "error_code": errorCode,
//         "api_url": path,
//       },
//     );
//   }
//
//   static void logEvent({
//     required String eventName,
//     Map<String, Object>? parameters,
//   }) {
//     firebaseAnalytics?.logEvent(
//       name: eventName,
//       parameters: parameters,
//     );
//   }
// }
