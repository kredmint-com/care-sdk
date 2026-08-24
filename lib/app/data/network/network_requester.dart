import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:flutter_alice/alice.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../service/navigation_service.dart';
import '../../../utils/helper/exception_handler.dart';
import '../../../utils/storage/storage_utils.dart';
import '../../config/app_config.dart';
import '../values/constants.dart';

/// =======================
/// FAILED REQUEST MODEL
/// =======================
class FailedRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;

  FailedRequest({required this.requestOptions, required this.completer});
}

class NetworkRequester {
  late Dio _dio;

  PackageInfo? packageInfo;
  String deviceId = "";

  Completer<void>? _refreshCompleter;

  /// 🔴 Failed requests handling
  final List<FailedRequest> _failedRequestsQueue = [];
  final bool _isNoInternetDialogShowing = false;
  bool _isRetrying = false;

  /// 🔒 REQUEST QUEUE (NEW)
  Future<void> _lastQueuedTask = Future.value();

  // Alice? alice;

  NetworkRequester() {
    prepareRequest(url: "");
    getHeaderInfo();
    // if (AppConfig.enableAlice) {
    //   alice = Alice(navigatorKey: NavigationService.navigatorKey);
    // }
  }

  /// =======================
  /// HEADER INFO
  /// =======================
  Future<void> getHeaderInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    // deviceId = await CommonMethod().getDeviceId() ?? "";
  }

  /// =======================
  /// INTERNAL QUEUE HANDLER
  /// =======================
  Future<T> _enqueue<T>(Future<T> Function() task) {
    final completer = Completer<T>();

    _lastQueuedTask = _lastQueuedTask.then((_) async {
      try {
        final result = await task();
        completer.complete(result);
      } catch (e, st) {
        completer.completeError(e, st);
      }
    });

    return completer.future;
  }

  /// =======================
  /// REQUEST PREPARATION
  /// =======================
  Future<void> prepareRequest({
    String? basicAuthorizationToken,
    String? contentType,
    required String url,
  }) async {
    if (packageInfo == null || deviceId.isEmpty) {
      await getHeaderInfo();
    }

    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: Timeouts.CONNECT_TIMEOUT),
        receiveTimeout: const Duration(milliseconds: Timeouts.RECEIVE_TIMEOUT),
        responseType: ResponseType.json,
        headers: getHeaders(
          basicAuthorizationToken: basicAuthorizationToken,
          contentType: contentType,
          url: url,
        ),
      ),
    );

    _dio.interceptors.clear();

    // _dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestBody: true,
    //     requestHeader: true,
    //     responseBody: true,
    //     responseHeader: true,
    //     error: true,
    //     logPrint: _printLog,
    //   ),
    // );

    // if (AppConfig.enableAlice) {
    //   _dio.interceptors.add(Constants.alice.getDioInterceptor());
    // }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          /// 🔴 NO INTERNET
          if (error.type == DioExceptionType.connectionError ||
              error.error is SocketException) {
            final completer = Completer<Response>();
            _addToFailedQueue(error.requestOptions, completer);
            // _showNoInternetDialog();
            return handler.resolve(await completer.future);
          }

          /// 🔁 TOKEN REFRESH
          final response = error.response;
          final requestOptions = error.requestOptions;

          // if (response?.statusCode == 401) {
          //   if (_refreshCompleter != null) {
          //     await _refreshCompleter!.future;
          //   } else {
          //     _refreshCompleter = Completer<void>();
          //     final success = await _handleTokenRefresh();
          //     _refreshCompleter!.complete();
          //     _refreshCompleter = null;
          //
          //     if (!success) {
          //       return handler.reject(error);
          //     }
          //   }
          //
          //   requestOptions.headers["Authorization"] =
          //   "Bearer ${Storage.getUser()?.accessToken}";
          //
          //   try {
          //     final response = await _dio.fetch(requestOptions);
          //     return handler.resolve(response);
          //   } catch (e) {
          //     return handler.reject(e as DioException);
          //   }
          // }

          return handler.next(error);
        },
      ),
    );
  }

  /// =======================
  /// FAILED REQUEST QUEUE
  /// =======================
  void _addToFailedQueue(
    RequestOptions request,
    Completer<Response> completer,
  ) {
    final exists = _failedRequestsQueue.any(
      (r) =>
          r.requestOptions.path == request.path &&
          r.requestOptions.method == request.method,
    );

    if (!exists) {
      _failedRequestsQueue.add(
        FailedRequest(requestOptions: request, completer: completer),
      );
    }
  }

  Future<void> retryAllFailedRequests() async {
    if (_isRetrying || _failedRequestsQueue.isEmpty) return;

    _isRetrying = true;
    final requests = List<FailedRequest>.from(_failedRequestsQueue);
    _failedRequestsQueue.clear();

    for (final failed in requests) {
      try {
        await prepareRequest(url: failed.requestOptions.path);
        final response = await _dio.fetch(failed.requestOptions);
        failed.completer.complete(response);
      } catch (e) {
        failed.completer.completeError(e);
        _failedRequestsQueue.add(failed);
      }
    }

    _isRetrying = false;
  }

  /// =======================
  /// NO INTERNET DIALOG
  /// =======================
  // void _showNoInternetDialog() {
  //   if (_isNoInternetDialogShowing) return;
  //   _isNoInternetDialogShowing = true;
  //
  //   final context = NavigationService.navigatorKey.currentContext;
  //   if (context == null) return;
  //
  //   CommonWidget().customDialog(
  //     context: context,
  //     heading: "No Internet Connection",
  //     subHeading: "Please check your internet connection and try again.",
  //     onOkTap: () async {
  //       if (await CommonMethod().hasNetwork()) {
  //         context.pop();
  //         _isNoInternetDialogShowing = false;
  //         retryAllFailedRequests();
  //       }
  //     },
  //     okButtonText: "Retry",
  //   );
  // }

  /// =======================
  /// TOKEN REFRESH
  /// =======================
  // Future<bool> _handleTokenRefresh() async {
  //   final refreshToken = Storage.getUser()?.refreshToken;
  //   if (refreshToken == null) return false;
  //
  //   try {
  //     final dioRefresh = Dio(
  //       BaseOptions(
  //         baseUrl: Env.getBaseUrl()[BaseUrlType.auth.name] ?? "",
  //         headers: getHeaders(
  //           basicAuthorizationToken: Env.getKredmintBasicToken(),
  //           url: "",
  //         ),
  //       ),
  //     );
  //
  //     final response = await dioRefresh.post(
  //       Urls.verifyOtp(baseUrlType: BaseUrlType.auth.name),
  //       data: {
  //         "refresh_token": refreshToken,
  //         "grant_type": "refresh_token",
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final newToken = VerifyOtpResponse.fromJson(response.data);
  //       Storage.setUser(
  //         Storage.getUser()?.copyWith(
  //           accessToken: newToken.accessToken,
  //           refreshToken: newToken.refreshToken,
  //         ),
  //       );
  //       return true;
  //     }
  //   } catch (_) {}
  //
  //   _logoutUser();
  //   return false;
  // }

  // void _logoutUser() {
  //   Storage.clearUser();
  //   if (AppPages.router.routerDelegate.state.path != Routes.phoneNumber) {
  //     AppPages.router.goNamed(Routes.phoneNumber);
  //   }
  // }

  /// =======================
  /// HTTP METHODS (QUEUED)
  /// =======================
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
    String? basicAuthorizationToken,
    bool showException = true,
  }) {
    return _enqueue(() async {
      try {
        await prepareRequest(
          basicAuthorizationToken: basicAuthorizationToken,
          url: path,
        );
        final response = await _dio.get(path, queryParameters: query);
        return response.data;
      } on DioException catch (e) {
        return ExceptionHandler.handleError(
          error: e,
          path: path,
          showException: showException,
        );
      }
    });
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? basicAuthorizationToken,
  }) {
    return _enqueue(() async {
      try {
        await prepareRequest(
          basicAuthorizationToken: basicAuthorizationToken,
          url: path,
        );
        final response = await _dio.post(
          path,
          queryParameters: query,
          data: data,
        );
        return response.data;
      } on DioException catch (e) {
        return ExceptionHandler.handleError(error: e, path: path);
      }
    });
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) {
    return _enqueue(() async {
      try {
        await prepareRequest(url: path);
        final response = await _dio.put(
          path,
          queryParameters: query,
          data: data,
        );
        return response.data;
      } on DioException catch (e) {
        return ExceptionHandler.handleError(error: e, path: path);
      }
    });
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) {
    return _enqueue(() async {
      try {
        await prepareRequest(url: path);
        final response = await _dio.patch(
          path,
          queryParameters: query,
          data: data,
        );
        return response.data;
      } on DioException catch (e) {
        return ExceptionHandler.handleError(error: e, path: path);
      }
    });
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) {
    return _enqueue(() async {
      try {
        await prepareRequest(url: path);
        final response = await _dio.delete(
          path,
          queryParameters: query,
          data: data,
        );
        return response.data;
      } on DioException catch (e) {
        return ExceptionHandler.handleError(error: e, path: path);
      }
    });
  }

  Future<dynamic> postFormData({
    required String path,
    required FormData formData,
    required Map<String, dynamic>? query,
  }) {
    return _enqueue(() async {
      try {
        await prepareRequest(contentType: "multipart/form-data", url: path);
        final response = await _dio.post(
          path,
          data: formData,
          queryParameters: query,
        );
        return response.data;
      } on DioException catch (e) {
        return ExceptionHandler.handleError(error: e, path: path);
      }
    });
  }

  /// =======================
  /// HEADERS
  /// =======================
  Map<String, dynamic> getHeaders({
    bool useRefreshToken = false,
    String? basicAuthorizationToken,
    String? contentType,
    required String url,
  }) {
    Map<String, dynamic> headers = {};

    headers = {
      "Content-Type":
          (contentType?.isNotEmpty ?? false) ? contentType : "application/json",
      "dt": "MOBILE",
      "os": Platform.isAndroid ? "ANDROID" : "IOS",
      "Authorization": (basicAuthorizationToken?.isNotEmpty ?? false)
          ? basicAuthorizationToken
          : "Bearer ${Storage.getSdkUser()?.accessToken ?? ""}",
      "did": deviceId,
      "bn": packageInfo?.buildNumber ?? "",
    };

    return headers;
  }

  _printLog(Object object) => log(object.toString());
}
