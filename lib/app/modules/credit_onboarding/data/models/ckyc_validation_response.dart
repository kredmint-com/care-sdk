// To parse this JSON data, do
//
//     final cKycValidationResponse = cKycValidationResponseFromJson(jsonString);

import 'dart:convert';

CKycValidationResponse cKycValidationResponseFromJson(String str) => CKycValidationResponse.fromJson(json.decode(str));

String cKycValidationResponseToJson(CKycValidationResponse data) => json.encode(data.toJson());

class CKycValidationResponse {
  CKycValidationResponsePayload? payload;
  num? sum;
  num? timestamp;
  String? requestId;

  CKycValidationResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
  });

  factory CKycValidationResponse.fromJson(Map<String, dynamic> json) => CKycValidationResponse(
    payload: json["payload"] == null ? null : CKycValidationResponsePayload.fromJson(json["payload"]),
    sum: json["sum"],
    timestamp: json["timestamp"],
    requestId: json["requestId"],
  );

  Map<String, dynamic> toJson() => {
    "payload": payload?.toJson(),
    "sum": sum,
    "timestamp": timestamp,
    "requestId": requestId,
  };
}

class CKycValidationResponsePayload {
  PayloadPayload? payload;
  num? sum;
  num? timestamp;
  String? requestId;

  CKycValidationResponsePayload({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
  });

  factory CKycValidationResponsePayload.fromJson(Map<String, dynamic> json) => CKycValidationResponsePayload(
    payload: json["payload"] == null ? null : PayloadPayload.fromJson(json["payload"]),
    sum: json["sum"],
    timestamp: json["timestamp"],
    requestId: json["requestId"],
  );

  Map<String, dynamic> toJson() => {
    "payload": payload?.toJson(),
    "sum": sum,
    "timestamp": timestamp,
    "requestId": requestId,
  };
}

class PayloadPayload {
  bool? success;

  PayloadPayload({
    this.success,
  });

  factory PayloadPayload.fromJson(Map<String, dynamic> json) => PayloadPayload(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
