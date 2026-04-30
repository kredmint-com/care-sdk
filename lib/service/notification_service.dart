// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import '../app/data/models/dto/user_model.dart';
// import '../app/data/models/response/notification_data_response.dart';
// import '../app/data/values/strings.dart';
// import '../app/data/values/urls.dart';
// import '../app/modules/home/presentation/bloc/home_bloc.dart';
// import '../app/modules/home/presentation/bloc/home_event.dart';
// import '../app/route/app_pages.dart';
// import '../main.dart';
// import '../utils/helper/enums.dart';
// import '../utils/storage/storage_utils.dart';
//
// class NotificationService {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   init() {
//     initializeNotificationService();
//     initializeLocalNotificationService();
//     listenNotification();
//     handleOnTapForFirebaseNotification();
//   }
//
//   void initializeNotificationService() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   void listenNotification() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         debugPrint("Listen notification data : ${message.toMap()}");
//         debugPrint(
//             "Listen notification data 2 : ${message.notification?.toMap()}");
//         Map<String, dynamic> notificationDataMap = message.data;
//         notificationDataMap["title"] = message.notification?.title;
//         notificationDataMap["subtitle"] = message.notification?.body;
//         NotificationDataResponse notificationDataResponse =
//             NotificationDataResponse.fromJson(notificationDataMap);
//         createLocalNotification(notificationData: notificationDataResponse);
//       }
//     });
//   }
//
//   void initializeLocalNotificationService() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin);
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) async {
//         if (notificationResponse.payload?.isNotEmpty ?? false) {
//           NotificationDataResponse notificationData =
//               NotificationDataResponse.fromJson(
//                   json.decode(notificationResponse.payload ?? ""));
//           onNotificationTap(
//             notificationData: notificationData,
//           );
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }
//
//   void onNotificationTap({
//     required NotificationDataResponse notificationData,
//     bool routingFromKilledState = false,
//   }) async {
//     if (Storage.getUser()?.accessToken?.isNotEmpty ?? false) {
//       PackageInfo packageInfo = await PackageInfo.fromPlatform();
//       UserModel? user = Storage.getUser();
//       Timer? timer;
//       timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
//         String currentRoute =
//             AppPages.router.routerDelegate.currentConfiguration.fullPath;
//         if ((!routingFromKilledState
//             ) ||
//             (routingFromKilledState && (currentRoute == Routes.dashboard))) {
//           timer.cancel();
//           debugPrint("On tap data : ${notificationData.id} .. ${notificationData.type}");
//           if (Storage.getUser()?.id?.isNotEmpty ?? false) {
//             if (notificationData.type ==
//                 NotificationActionType.BILL_PAYMENT.name) {
//               BlocProvider.of<HomeBloc>(
//                       NavigationService.navigatorKey.currentContext!)
//                   .add(
//                 OnNotificationReceive(
//                   notificationDataResponse: notificationData,
//                 ),
//               );
//             } else if (notificationData.type ==
//                 NotificationActionType.INCOMPLETE_PROFILE.name) {
//               AppPages.router.pushNamed(Routes.webViewService, extra: {
//                 "url": Urls.onboarding(
//                   token: Storage.getUser()?.accessToken ?? "",
//                   refreshToken: Storage.getUser()?.refreshToken ?? "",
//                   profileId: ((user?.profiles?.isNotEmpty) ?? false)
//                       ? user?.profiles?.first.id ?? ""
//                       : "",
//                   buildNo: packageInfo.buildNumber,
//                   userId: Storage.getUser()?.id ?? "",
//                 ),
//                 "title": notificationData.type,
//               });
//             } else if (notificationData.type ==
//                 NotificationActionType.BOUNCE.name) {
//               AppPages.router.pushNamed(Routes.webViewService, extra: {
//                 "url": Urls.repayment(
//                   userId: Storage.getUser()?.id ?? "",
//                   token: Storage.getUser()?.accessToken ?? "",
//                   refreshToken: Storage.getUser()?.refreshToken ?? "",
//                   loanId: notificationData.invoiceId ?? "",
//                   buildNo: packageInfo.buildNumber,
//                   route: "repayment",
//                 ),
//                 "title": notificationData.type,
//               });
//             } else if (notificationData.type ==
//                 NotificationActionType.INVOICE.name) {
//               AppPages.router.pushNamed(Routes.webViewService, extra: {
//                 "url": Urls.repayment(
//                   userId: Storage.getUser()?.id ?? "",
//                   token: Storage.getUser()?.accessToken ?? "",
//                   refreshToken: Storage.getUser()?.refreshToken ?? "",
//                   loanId: notificationData.invoiceId ?? "",
//                   buildNo: packageInfo.buildNumber,
//                   route: "invoice-details",
//                 ),
//                 "title": Strings.invoiceDetail,
//               });
//             } else if (notificationData.type ==
//                 NotificationActionType.LOAN_APPLICATION.name) {
//               AppPages.router.pushNamed(
//                 Routes.creditOnboarding,
//                 extra: {
//                   "profileId": notificationData.profileId ?? "",
//                 },
//               );
//             }
//           }
//         }
//       });
//     }
//   }
//
//   void createLocalNotification(
//       {required NotificationDataResponse notificationData}) async {
//     NotificationType notificationType =
//         (notificationData.imageUrl?.isNotEmpty ?? false)
//             ? NotificationType.bigPicture
//             : NotificationType.standard;
//     switch (notificationType) {
//       case NotificationType.standard:
//         createStandardNotification(notificationData: notificationData);
//         break;
//       case NotificationType.bigPicture:
//         createBigPictureNotification(notificationData: notificationData);
//     }
//   }
//
//   void createBigPictureNotification(
//       {required NotificationDataResponse notificationData}) async {
//     final response = await Dio().get(notificationData.imageUrl ?? "",
//         options: Options(responseType: ResponseType.bytes));
//
//     BigPictureStyleInformation bigPictureStyleInformation =
//         BigPictureStyleInformation(
//             ByteArrayAndroidBitmap.fromBase64String(
//                 base64Encode(response.data)),
//             largeIcon: ByteArrayAndroidBitmap.fromBase64String(
//                 base64Encode(response.data)));
//
//     final AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             'high_importance_channel', 'Notification channel name',
//             channelDescription: 'Notification channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             icon: 'ic_notification',
//             styleInformation: bigPictureStyleInformation);
//     final NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//       Random().nextInt(1000),
//       notificationData.title ?? "",
//       notificationData.subtitle ?? "",
//       notificationDetails,
//       payload: json.encode(notificationData.toJson()).toString(),
//     );
//   }
//
//   void createStandardNotification(
//       {required NotificationDataResponse notificationData}) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'high_importance_channel',
//       'Notification channel name',
//       channelDescription: 'Notification channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: 'ic_notification',
//     );
//
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//       Random().nextInt(1000),
//       notificationData.title ?? "",
//       notificationData.subtitle ?? "",
//       notificationDetails,
//       payload: json.encode(notificationData.toJson()).toString(),
//     );
//   }
//
//   Future<void> handleOnTapForFirebaseNotification() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//
//     if (initialMessage != null) {
//       // handleMessage(initialMessage);
//       onNotificationTap(
//           notificationData:
//               NotificationDataResponse.fromJson(initialMessage.data),
//           routingFromKilledState: true);
//     }
//
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
//
//   void handleMessage(RemoteMessage message) {
//     onNotificationTap(
//         notificationData: NotificationDataResponse.fromJson(message.data));
//   }
// }
//
// @pragma('vm:entry-point')
// void notificationTapBackground(
//     NotificationResponse notificationResponse) async {
//   debugPrint("notificationTapBackground called");
//   // await Firebase.initializeApp();
//   debugPrint(
//       "notificationTapBackground called 2 : ${notificationResponse.payload?.isNotEmpty}");
//   if (notificationResponse.payload?.isNotEmpty ?? false) {
//     NotificationDataResponse notificationData =
//         NotificationDataResponse.fromJson(
//             json.decode(notificationResponse.payload ?? ""));
//     NotificationService().onNotificationTap(
//       notificationData: notificationData,
//     );
//   }
// }
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
