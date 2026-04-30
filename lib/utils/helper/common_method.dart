import 'dart:async';
import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:loan_sdk_package/utils/helper/string_extension.dart';
// import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
import '../../app/config/env.dart';
import '../../app/data/values/urls.dart';
import '../../app/modules/credit_onboarding/data/models/address_detail_response.dart';
import '../loading/loading_utils.dart';
import 'exception_handler.dart';

class CommonMethod {
  Future<File> createFileOfPdfUrl({required String imgPath}) async {
    debugPrint("Img path : $imgPath");
    Completer<File> completer = Completer();
    // print("Start download file from internet!");
    try {
      final url = imgPath;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      // print("Download files");
      // print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  // Future<Position?> determinePosition({
  //   bool requestPermission = false,
  //   bool showLoader = true,
  // }) async {
  //   LocationPermission permission;
  //   Position? position;
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     Geolocator.openAppSettings();
  //   } else if (permission == LocationPermission.denied && requestPermission) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.deniedForever) {
  //       Geolocator.openAppSettings();
  //     } else if (permission == LocationPermission.always ||
  //         permission == LocationPermission.whileInUse) {
  //       LoadingUtils.showLoader();
  //       if (await Geolocator.isLocationServiceEnabled()) {
  //         position = await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.high);
  //       } else {
  //         // Fluttertoast.showToast(
  //         //     msg: ErrorMessages.locationServiceAreNotEnabled);
  //       }
  //       LoadingUtils.hideLoader();
  //     }
  //   } else if (permission == LocationPermission.always ||
  //       permission == LocationPermission.whileInUse) {
  //     if (showLoader) {
  //       LoadingUtils.showLoader();
  //     }
  //     if (await Geolocator.isLocationServiceEnabled()) {
  //       position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //     } else {
  //       // Fluttertoast.showToast(msg: ErrorMessages.locationServiceAreNotEnabled);
  //     }
  //     LoadingUtils.hideLoader();
  //   }
  //   return position;
  // }

  Future<Map<String, String>?> getStateCityFromAddressResponse(
      {required AddressDetailResponse? addressDetailResponse}) async {
    if (addressDetailResponse?.status != 'OK' ||
        addressDetailResponse?.results == null ||
        (addressDetailResponse?.results?.isEmpty ?? true)) {
      return null;
    }

    final addressComponents =
        addressDetailResponse?.results?.first.addressComponents;

    String? state;
    String? city;

    if (addressComponents != null) {
      for (var component in addressComponents) {
        List<String>? types = component.types;

        if (types?.contains('administrative_area_level_1') ?? false) {
          state = component.longName;
        }

        if (types?.contains('administrative_area_level_3') ?? false) {
          city = component.longName;
        }
        if (city == null && (types?.contains('locality') ?? false)) {
          city = component.longName;
        }
        if (city == null &&
            (types?.contains('administrative_area_level_2') ?? false)) {
          city = component.longName;
        }
      }
      if (state != null && city != null) {
        return {'state': state, 'city': city};
      }
    }
    return null;
  }

  // Future<XFile> uint8ListToXFile(
  //     {required Uint8List bytes,
  //     String fileName = 'history_detail.png'}) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final file = await File('${tempDir.path}/$fileName').create();
  //   await file.writeAsBytes(bytes);
  //   return XFile(file.path);
  // }

  // Future<String?> getDeviceId() async {
  //   try {
  //     if (Platform.isAndroid) {
  //       const platform = MethodChannel(Env.channelName);
  //       final String? id = await platform.invokeMethod('getAndroidId');
  //
  //       return id;
  //     } else {
  //       final deviceInfo = DeviceInfoPlugin();
  //       final iosInfo = await deviceInfo.iosInfo;
  //       return iosInfo.identifierForVendor;
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint("Failed to get Android ID: '${e.message}'.");
  //     return null;
  //   }
  // }

  // Future<void> downloadMediaFromUrl({
  //   required String fileName,
  //   required String mediaType,
  //   required String url,
  //   required void Function(int, int) onProgressUpdate,
  //   required void Function() onDioException,
  // }) async {
  //   CancelToken cancelToken = CancelToken();
  //   final dio = Dio();
  //   Directory tempDir;
  //
  //   if (Platform.isIOS) {
  //     tempDir = await getApplicationDocumentsDirectory();
  //   } else {
  //     tempDir = Directory('/storage/emulated/0/Download');
  //   }
  //
  //   String savePath = "${tempDir.path}/$fileName.$mediaType";
  //
  //   for (int i = 0; i < 100; i++) {
  //     bool exists = await File(savePath).exists();
  //     if (exists) {
  //       savePath = "${tempDir.path}/$fileName(${i + 1}).$mediaType";
  //     } else {
  //       break;
  //     }
  //   }
  //
  //   LoadingUtils.hideLoader();
  //
  //   try {
  //     await dio.download(
  //       url,
  //       savePath,
  //       cancelToken: cancelToken,
  //       onReceiveProgress: onProgressUpdate,
  //     );
  //     await OpenFile.open(savePath);
  //   } on DioException catch (e) {
  //     onDioException();
  //     ExceptionHandler.handleError(error: e, path: '');
  //   }
  // }

  TextInputType getKeyboardTypeFromRegex(String? regex) {
    if (regex == null || regex.isEmpty) {
      return TextInputType.text;
    }

    try {
      final regExp = RegExp(regex);

      bool acceptsLetters = regExp.hasMatch('a') ||
          regExp.hasMatch('A') ||
          regExp.hasMatch('abc') ||
          regExp.hasMatch('ABC');

      bool acceptsNumbers = regExp.hasMatch('0') ||
          regExp.hasMatch('1') ||
          regExp.hasMatch('9') ||
          regExp.hasMatch('123') ||
          regExp.hasMatch('1234567890') ||
          regExp.hasMatch('9876543210');

      bool acceptsSpecialChars = regExp.hasMatch('1,2') ||
          regExp.hasMatch('1 2') ||
          regExp.hasMatch('1.2') ||
          regExp.hasMatch('1-2');

      if (acceptsLetters) {
        return TextInputType.text;
      } else if (acceptsNumbers && acceptsSpecialChars) {
        return TextInputType.number;
      } else if (acceptsNumbers && !acceptsLetters) {
        return TextInputType.number;
      } else {
        return TextInputType.text;
      }
    } catch (e) {
      return TextInputType.text;
    }
  }

  String millisecondsToMinutes(num milliseconds) {
    double timeInMinute = (milliseconds / (60 * 1000));
    return "${timeInMinute.toString().formatData()} ${timeInMinute > 1 ? "minutes" : "minute"}";
  }

  // Future<bool> hasNetwork() async {
  //   final result = await Connectivity().checkConnectivity();
  //   return !result.contains(ConnectivityResult.none);
  // }

  static String getCompressedUrl({
    required String? originalImageUrl,
    required String imageHeight,
    int dpr = 5,
  }) {
    if (originalImageUrl?.split("/").isEmpty ?? true) {
      return originalImageUrl ?? "";
    }
    return
         "${Urls.getCompressionUrl(dpr: dpr, height: imageHeight)}${originalImageUrl ?? ""}";
  }

  DateTime? parseDate({required String date}) {
    if (date.isEmpty) return null;

    final parts = date.split("-");
    if (parts.length != 3) return null;

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) return null;

    return DateTime(year, month, day);
  }
}
