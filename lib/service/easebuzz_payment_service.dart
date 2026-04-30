import 'dart:convert';
import 'dart:developer';
import 'package:easebuzz_flutter/easebuzz_flutter.dart';

import '../app/config/release_env.dart';
import '../app/data/models/dto/payment_sdk_response.dart';
import '../utils/helper/enums.dart';
import '../utils/loading/loading_utils.dart';

class EaseBuzzPaymentService {
  final easebuzzPlugin = EasebuzzFlutter();

  Future<PaymentSdkResponse?> initiatePayment(
      {required String accessKey}) async {
    String payMode = (releaseEv.name  == ReleaseEnv.prod.name) ? PaymentEnv.prod.name : PaymentEnv.test.name;
    PaymentSdkResponse? paymentResponse;
    // try {
    LoadingUtils.showLoader();
    final response = await easebuzzPlugin.payWithEasebuzz(accessKey, payMode);
    LoadingUtils.hideLoader();
    log("Eazz buzz responnse : ${json.encode(response)}.......... $payMode");
    if (response?.isNotEmpty ?? false) {
      paymentResponse =
          PaymentSdkResponse.fromJson(json.decode(response ?? ""));
    }
    // } catch (e) {
    //   debugPrint("Exception , initiatePayment : $e");
    // }
    return paymentResponse;
  }
}

//result["payment_response"]["status"] == "success"
