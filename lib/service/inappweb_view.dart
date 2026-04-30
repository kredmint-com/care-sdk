// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loan_sdk_package/service/razorpay_payment_service.dart';
// import 'package:loan_sdk_package/utils/helper/string_extension.dart';
// import '../app/themes/app_colors.dart';
// import '../app/themes/styles.dart';
// import '../injection_container.dart';
// import '../utils/helper/enums.dart';
// import '../utils/storage/storage_utils.dart' as storage;
// import '../widgets/common_widget.dart';
// import 'cashfree_payment_service.dart';
// import 'digio_service.dart';
// import 'easebuzz_payment_service.dart';
//
// class WebviewService extends StatefulWidget {
//   const WebviewService({
//     super.key,
//     required this.url,
//     this.title = "",
//     this.webviewKey = "",
//     this.comingFromPerfios = false,
//     this.showAppBar = true,
//   });
//
//   final String url;
//   final String title;
//   final String webviewKey;
//   final bool comingFromPerfios;
//   final bool showAppBar;
//
//   @override
//   State<WebviewService> createState() => _WebviewServiceState();
// }
//
// class _WebviewServiceState extends State<WebviewService> {
//   final GlobalKey webViewKey = GlobalKey();
//
//   InAppWebViewController? webViewController;
//
//   InAppWebViewSettings settings = InAppWebViewSettings(
//     isInspectable: kDebugMode,
//     mediaPlaybackRequiresUserGesture: false,
//     allowsInlineMediaPlayback: true,
//     iframeAllow: "camera; microphone",
//     transparentBackground: true,
//     useHybridComposition: true,
//     allowsBackForwardNavigationGestures: true,
//   );
//
//   final CookieManager cookieManager = CookieManager.instance();
//   bool isLoading = true;
//   late PullToRefreshController pullToRefreshController;
//   bool perfios = false;
//
//   @override
//   void initState() {
//     super.initState();
//     debugPrint("In app web view title : ${widget.title}");
//     perfios = widget.comingFromPerfios;
//     pullToRefreshController = PullToRefreshController(
//       settings: PullToRefreshSettings(
//         color: AppColors.primaryColor(),
//       ),
//       onRefresh: () async {
//         if (webViewController != null) {
//           if (Platform.isAndroid) {
//             webViewController?.reload();
//           } else if (Platform.isIOS) {
//             var url = await webViewController?.getUrl();
//             if (url != null) {
//               webViewController?.loadUrl(urlRequest: URLRequest(url: url));
//             }
//           }
//         }
//       },
//     );
//   }
//
//   void logoutUser() async {
//     // storage.Storage.clearUser();
//     // if (AppPages.router.routerDelegate.state.path != Routes.phoneNumber) {
//     //   AppPages.router.goNamed(Routes.phoneNumber);
//     // }
//   }
//
//   Future<bool> handleBackPress() async {
//     bool canGoBack = (await webViewController?.canGoBack()) ?? false;
//     if (canGoBack) {
//       webViewController?.goBack();
//       return false;
//     }
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: handleBackPress,
//       child: Scaffold(
//         floatingActionButton: Visibility(
//           visible: widget.title == "history",
//           child: FloatingActionButton(
//             onPressed: () {
//               webViewController?.reload();
//             },
//             child: Icon(Icons.refresh),
//           ),
//         ),
//         appBar: (widget.showAppBar && widget.title != "history")
//             ? CommonWidget().customAppBar(
//                 title: (widget.title.isNotEmpty)
//                     ? widget.title.removeUnderscoreAndCapitalize()
//                     : "",
//                 backgroundColor: AppColors.blue22,
//                 titleStyle: Styles.tsWhiteMedium12(),
//                 leadingIconColor: AppColors.white,
//               )
//             : null,
//         body: Stack(
//           children: [
//             SafeArea(
//                 child: SizedBox(
//               height: size.height,
//               width: size.width,
//               child: InAppWebView(
//                 pullToRefreshController: pullToRefreshController,
//                 key: ValueKey(webViewKey),
//                 onConsoleMessage: (_, message) {
//                   debugPrint("Console message received : $message");
//                 },
//                 initialUrlRequest: URLRequest(url: WebUri(widget.url)),
//                 initialSettings: settings,
//                 onWebViewCreated: (controller) async {
//                   debugPrint(
//                       "On web view created : ${widget.url}");
//                   webViewController = controller;
//                   webViewController?.addJavaScriptHandler(
//                     handlerName: "javascriptSide",
//                     callback: (args) async {
//                       bool digioUrlFound = false;
//                       debugPrint("Link Received : ${args[0]}");
//                       String initiatePaymentLink = args[0]["link"] ?? "";
//                       String digioUrl = args[0]["digioUrl"] ?? "";
//                       bool isLogout = args[0]["logout"] ?? false;
//                       Map<String, dynamic>? pgData = args[0]["pgData"];
//                       debugPrint("Pg data found : ${pgData}");
//                       bool proceedToDashboard =
//                           (args[0]["proceedToDashboard"]) ?? false;
//                       if (isLogout) {
//                         debugPrint("Is logout : ${widget.url}");
//                         logoutUser();
//                       }
//                       if (initiatePaymentLink.isNotEmpty) {
//                         // launchUrl(Uri.parse("${widget.url}$initiatePaymentLink"));
//                       } else if (proceedToDashboard) {
//                         debugPrint("Proceed to dashboard called");
//                         // context
//                         //     .read<DashboardBloc>()
//                         //     .add(OnUpdateBottomBarIndex(val: 0));
//                       } else if (digioUrl.isNotEmpty) {
//                         debugPrint("Digio url found :$digioUrl");
//                         Uri uri = Uri.parse(digioUrl);
//                         // debugPrint("Query document id : ${uri.queryParameters['documentId'] ?? ""}");
//                         bool isKyc =
//                             uri.queryParameters['isKyc']?.isNotEmpty ?? false;
//                         String requestId = "";
//                         String identifier = "";
//                         String tokenId = "";
//                         if (isKyc) {
//                           requestId = uri.queryParameters['requestId'] ?? "";
//                           identifier = uri.queryParameters['identifier'] ?? "";
//                           tokenId = uri.queryParameters['tokenId'] ?? "";
//                         } else {
//                           requestId = args[0]["documentId"] ?? "";
//                           // debugPrint("Document id : ${requestId}");
//                         }
//                         if (requestId.isNotEmpty) {
//                           debugPrint(
//                               "Digio new data : $requestId ... $identifier ... $tokenId....${storage.Storage.getSdkUser()?.phoneNumber}");
//                           Map<String, dynamic> digioResult =
//                               await DigioService().startKyc(
//                             documentId: requestId,
//                             identifier:
//                                 // "8860533811",
//                                 identifier.isNotEmpty
//                                     ? identifier
//                                     : storage.Storage.getSdkUser()?.phoneNumber ??
//                                         "",
//                             tokenId: tokenId,
//                           );
//                           return digioResult;
//                         }
//                       } else if (pgData?["pgName"] != null
//                           // &&
//                           // pgData?["orderId"] != null &&
//                           // pgData?["pgSessionId"] != null
//                           ) {
//                         if (pgData?["pgName"] == Pg.CASH_FREE.name) {
//                           final response =
//                               getIt<CashfreePaymentService>().initiatePayment(
//                             orderId: pgData?["pgOptions"]?["orderId"] ?? "",
//                             paymentSessionId:
//                                 pgData?["pgOptions"]?["pgSessionId"] ?? "",
//                           );
//                           return response;
//                         } else if ((pgData?["pgName"] == Pg.ORA.name) ||
//                             (pgData?["pgName"] == Pg.Razorpay.name)) {
//                           final response =
//                               getIt<RazorpayPaymentService>().initiatePayment(
//                             options: pgData?["pgOptions"],
//                           );
//                           return response;
//                         } else if ((pgData?["pgName"] == Pg.ZEAL.name) ||
//                             (pgData?["pgName"] == Pg.EaseBuzz.name)) {
//                           final response =
//                               getIt<EaseBuzzPaymentService>().initiatePayment(
//                             accessKey: pgData?["pgOptions"]?["accessKey"],
//                           );
//                           return response;
//                         }
//                       }
//                     },
//                   );
//                 },
//                 onLoadStop: (controller, url) async {
//                   if ((perfios) &&
//                       url
//                           .toString()
//                           .contains("https://merchant-v2.kredmint.in/login/")) {
//                     setState(() {
//                       perfios = false;
//                     });
//                     context.pop("true");
//                   }
//                   setState(() {
//                     isLoading = false;
//                   });
//                   pullToRefreshController.endRefreshing();
//
//                   // Force scroll space if content is too short
//                   // await controller.evaluateJavascript(source: """
//                   //   if (document.body.scrollHeight <= window.innerHeight) {
//                   //     var pad = document.createElement('div');
//                   //     pad.style.height = '50px';
//                   //     pad.style.background = 'transparent';
//                   //     document.body.appendChild(pad);
//                   //   }
//                   // """);
//                 },
//                 onUpdateVisitedHistory: (controller, url, androidIsReload) {
//                   debugPrint(
//                       "Visited history updated: $url"); // ✅ Also captures new URLs
//                 },
//                 onPermissionRequest: (controller, request) async {
//                   return PermissionResponse(
//                     resources: request.resources,
//                     action: PermissionResponseAction.GRANT,
//                   );
//                 },
//               ),
//             )),
//             if (isLoading)
//               Center(
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
