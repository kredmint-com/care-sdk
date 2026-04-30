// To parse this JSON data, do
//
//     final mandateVerifyResponse = mandateVerifyResponseFromJson(jsonString);

import 'dart:convert';

MandateVerifyResponse mandateVerifyResponseFromJson(String str) => MandateVerifyResponse.fromJson(json.decode(str));

String mandateVerifyResponseToJson(MandateVerifyResponse data) => json.encode(data.toJson());

class MandateVerifyResponse {
  String? payload;
  num? sum;
  num? timestamp;
  String? requestId;
  dynamic error;

  MandateVerifyResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
    this.error,
  });

  factory MandateVerifyResponse.fromJson(Map<String, dynamic> json) => MandateVerifyResponse(
    payload: json["payload"],
    sum: json["sum"],
    timestamp: json["timestamp"],
    requestId: json["requestId"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "payload": payload,
    "sum": sum,
    "timestamp": timestamp,
    "requestId": requestId,
    "error": error,
  };
}
