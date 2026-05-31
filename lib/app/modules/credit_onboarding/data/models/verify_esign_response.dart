// To parse this JSON data, do
//
//     final esignVerifyResponse = esignVerifyResponseFromJson(jsonString);

import 'dart:convert';

EsignVerifyResponse esignVerifyResponseFromJson(String str) =>
    EsignVerifyResponse.fromJson(json.decode(str));

String esignVerifyResponseToJson(EsignVerifyResponse data) =>
    json.encode(data.toJson());

class EsignVerifyResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  String? requestId;
  dynamic error;

  EsignVerifyResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
    this.error,
  });

  factory EsignVerifyResponse.fromJson(Map<String, dynamic> json) =>
      EsignVerifyResponse(
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        sum: json["sum"],
        timestamp: json["timestamp"],
        requestId: json["requestId"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "payload": payload?.toJson(),
        "sum": sum,
        "timestamp": timestamp,
        "requestId": requestId,
        "error": error,
      };
}

class Payload {
  String? status;
  String? documentId;
  DigioResponse? digioResponse;

  Payload({
    this.status,
    this.documentId,
    this.digioResponse,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        status: json["status"],
        documentId: json["documentId"],
        digioResponse: json["digioResponse"] == null
            ? null
            : DigioResponse.fromJson(json["digioResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "documentId": documentId,
        "digioResponse": digioResponse?.toJson(),
      };
}

class DigioResponse {
  String? digioDocId;
  String? message;
  String? txnId;

  DigioResponse({
    this.digioDocId,
    this.message,
    this.txnId,
  });

  factory DigioResponse.fromJson(Map<String, dynamic> json) => DigioResponse(
        digioDocId: json["digioDocId"],
        message: json["message"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "digioDocId": digioDocId,
        "message": message,
        "txnId": txnId,
      };
}
