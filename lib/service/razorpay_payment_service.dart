import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentService {
  final razorpay = Razorpay();

  Future<Map<dynamic, dynamic>?> initiatePayment(
      {required Map<String, dynamic> options}) {
    debugPrint("Razorpay options opened");
    final Completer<Map<dynamic, dynamic>> completer = Completer();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      // debugPrint("_handlePaymentSuccess : ${}");
      Map<dynamic, dynamic>? razorPaySuccessResponse = response.data;
      razorPaySuccessResponse?["message"] = "success";
      completer.complete(razorPaySuccessResponse);
    });
    razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      (PaymentFailureResponse response) {
        debugPrint("handlePaymentError : ${response.toString()}");
        completer.complete(
          {
            "errorMessage": response.error,
            "errorCode": response.code,
            "message": response.message,
          },
        );
      },
    );
    razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      (ExternalWalletResponse response) {
        debugPrint("handleExternalWallet : ${response.toString()}");
      },
    );
    razorpay.open(options);
    return completer.future;
  }
}
