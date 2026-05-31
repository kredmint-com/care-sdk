import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../app/data/values/strings.dart';
import '../loading/loading_utils.dart';

class APIException implements Exception {
  final String message;

  APIException({required this.message});
}

class ExceptionHandler {
  ExceptionHandler._privateConstructor();

  static APIException handleError({
    required Exception error,
    required String path,
    bool showException = true,
  }) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        // Fluttertoast.showToast(msg: "No internet connection");
        return APIException(message: "No internet connection");
      } else {
        String? errorMessage =
            json.decode(json.encode(error.response?.data))?["errorMessage"];
        String? errorText =
            json.decode(json.encode(error.response?.data))?["error"];
        if ((errorMessage != null || errorText != null) &&
            (error.response?.statusCode != 401) &&
            showException) {
          Fluttertoast.showToast(
            msg: errorMessage ??
                ((errorText == "invalid_grant")
                    ? ErrorMessages.otpIsInvalid
                    : (errorText ?? "")),
          );
        }
        LoadingUtils.hideLoader();
        // AnalyticsService.logApiErrorEvent(
        //   errorCode: error.response?.statusCode?.toString() ?? "",
        //   errorMessage: (error.response?.data == null)
        //       ? ""
        //       : (json.decode(
        //               json.encode(error.response?.data))["errorMessage"] ??
        //           ""),
        //   path: path,
        // );
        return APIException(message: error.response?.statusMessage ?? "");
      }
    } else {
      return APIException(message: ErrorMessages.networkGeneral);
    }
  }
}

class HandleError {
  HandleError._privateConstructor();

  static handleError(APIException? error) {
    Fluttertoast.showToast(msg: error?.message ?? ErrorMessages.networkGeneral);
  }
}
