// To parse this JSON data, do
//
//     final validateBankResponse = validateBankResponseFromJson(jsonString);

import 'dart:convert';

ValidateBankResponse validateBankResponseFromJson(String str) =>
    ValidateBankResponse.fromJson(json.decode(str));

String validateBankResponseToJson(ValidateBankResponse data) =>
    json.encode(data.toJson());

class ValidateBankResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  String? requestId;
  dynamic error;

  ValidateBankResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
    this.error,
  });

  factory ValidateBankResponse.fromJson(Map<String, dynamic> json) =>
      ValidateBankResponse(
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
  String? accountNumber;
  String? status;
  String? subCode;
  String? message;
  String? accountStatus;
  String? accountStatusCode;
  bool? valid;
  bool? nameMatched;
  String? nameProvided;
  String? nameAtBank;
  String? refId;
  String? bankName;
  String? utr;
  String? city;
  String? branch;
  num? micr;
  String? ifscProvided;
  String? referenceId;
  String? documentType;

  Payload({
    this.accountNumber,
    this.status,
    this.subCode,
    this.message,
    this.accountStatus,
    this.accountStatusCode,
    this.valid,
    this.nameMatched,
    this.nameProvided,
    this.nameAtBank,
    this.refId,
    this.bankName,
    this.utr,
    this.city,
    this.branch,
    this.micr,
    this.ifscProvided,
    this.referenceId,
    this.documentType,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        accountNumber: json["accountNumber"],
        status: json["status"],
        subCode: json["subCode"],
        message: json["message"],
        accountStatus: json["accountStatus"],
        accountStatusCode: json["accountStatusCode"],
        valid: json["valid"],
        nameMatched: json["nameMatched"],
        nameProvided: json["nameProvided"],
        nameAtBank: json["nameAtBank"],
        refId: json["refId"],
        bankName: json["bankName"],
        utr: json["utr"],
        city: json["city"],
        branch: json["branch"],
        micr: json["micr"],
        ifscProvided: json["ifscProvided"],
        referenceId: json["referenceId"],
        documentType: json["documentType"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "status": status,
        "subCode": subCode,
        "message": message,
        "accountStatus": accountStatus,
        "accountStatusCode": accountStatusCode,
        "valid": valid,
        "nameMatched": nameMatched,
        "nameProvided": nameProvided,
        "nameAtBank": nameAtBank,
        "refId": refId,
        "bankName": bankName,
        "utr": utr,
        "city": city,
        "branch": branch,
        "micr": micr,
        "ifscProvided": ifscProvided,
        "referenceId": referenceId,
        "documentType": documentType,
      };
}
