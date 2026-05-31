import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:kyc_workflow/digio_config.dart';
import 'package:kyc_workflow/environment.dart';
import 'package:kyc_workflow/kyc_workflow.dart';

import '../utils/loading/loading_utils.dart';

class DigioService {
  DigioConfig getKycDigioConfig() {
    var digioConfig = DigioConfig();
    digioConfig.theme.primaryColor = "#32a83a";
    digioConfig.logo = "https://www.digio.in/images/digio_blue.png";
    digioConfig.environment = Environment.PRODUCTION;
    return digioConfig;
  }

  // static e_sign.DigioConfig getESignDigioConfig() {
  //   var digioConfig = e_sign.DigioConfig();
  //   digioConfig.theme.primaryColor = "#32a83a";
  //   digioConfig.logo = "https://www.digio.in/images/digio_blue.png";
  //   digioConfig.environment = e_sign_environment.Environment.PRODUCTION;
  //   return digioConfig;
  // }

  Future<Map<String, dynamic>> startKyc({
    required String documentId,
    required String identifier,
    required String tokenId,
  }) async {
    HashMap<String, String> additionalData = HashMap<String, String>();
    additionalData["dg_disable_upi_collect_flow"] =
        "false"; // optional for mandate

    DigioConfig digioConfig = getKycDigioConfig();

    KycWorkflow kycWorkflowPlugin = KycWorkflow(digioConfig);
    LoadingUtils.showLoader();
    final workflowResult = await kycWorkflowPlugin.start(
      documentId,
      identifier,
      tokenId,
      additionalData,
    );
    LoadingUtils.hideLoader();

    Map<String, dynamic> digioResult = {
      "message": workflowResult.message,
      "documentId": workflowResult.documentId,
      "code": workflowResult.code,
      "errorCode": workflowResult.errorCode,
      "permissions": workflowResult.permissions,
      "screen": workflowResult.screen,
      "step": workflowResult.step,
    };
    debugPrint("digio result : ${digioResult.toString()}");
    return digioResult;
  }

// static void startEsign({
//   required String documentId,
//   required String identifier,
//   required String tokenId,
// }) async {
//   e_sign.DigioConfig digioConfig = getESignDigioConfig();
//   final esignPlugin = EsignPlugin(digioConfig);
//   final esignResult =
//       await esignPlugin.start(documentId, identifier, tokenId, null);
//   debugPrint('esignResult : $esignResult');
// }
}
