import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

class CashfreePaymentService {
  final cfPaymentGatewayService = CFPaymentGatewayService();

  // CashfreePaymentService() {
  //   cfPaymentGatewayService.setCallback(verifyPayment, onError);
  // }

  // void verifyPayment(String orderId) {
  //   debugPrint("Cashfree Verify Payment : $orderId");
  // }
  //
  // void onError(CFErrorResponse errorResponse, String orderId) {
  //   debugPrint(errorResponse.getMessage());
  //   debugPrint("Error while making payment");
  // }

  Future<Map<String, dynamic>?> initiatePayment(
      {required String orderId, required String paymentSessionId}) async {
    try {
      final Completer<Map<String, dynamic>> completer = Completer();
      debugPrint("Cashfree data : $orderId $paymentSessionId");
      var session = createSession(
        orderId: orderId,
        paymentSessionId: paymentSessionId,
      );
      var cfWebCheckout =
          CFWebCheckoutPaymentBuilder().setSession(session!).build();
      cfPaymentGatewayService.setCallback((orderId) {
        debugPrint("Cashfree success : $orderId");
        completer.complete({
          "message": "success",
        });
      }, (CFErrorResponse errorResponse, String orderId) {
        debugPrint("Cashfree error : $orderId");
        completer.complete({
          "message": "failure",
          "errorMessage" : errorResponse.getMessage(),
          "errorCode" : errorResponse.getCode(),
          "errorStatus" : errorResponse.getStatus(),
        });
      });
      cfPaymentGatewayService.doPayment(cfWebCheckout);
      return completer.future;
    } on CFException catch (e) {
      debugPrint("Cashfree exception : ${e.message}");
    }
    return null;
  }

  CFSession? createSession(
      {required String orderId, required String paymentSessionId}) {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.PRODUCTION)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }
}
