// To parse this JSON data, do
//
//     final bankAccountDetailResponse = bankAccountDetailResponseFromJson(jsonString);

import 'dart:convert';

BankAccountDetailResponse bankAccountDetailResponseFromJson(String str) => BankAccountDetailResponse.fromJson(json.decode(str));

String bankAccountDetailResponseToJson(BankAccountDetailResponse data) => json.encode(data.toJson());

class BankAccountDetailResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  String? requestId;
  dynamic error;

  BankAccountDetailResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
    this.error,
  });

  factory BankAccountDetailResponse.fromJson(Map<String, dynamic> json) => BankAccountDetailResponse(
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
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
  String? id;
  String? partnerId;
  String? lenderId;
  String? createdBy;
  String? createdByName;
  String? lastModifiedByName;
  num? creationDate;
  num? lastModifiedDate;
  String? lastModifiedBy;
  String? accountHolderName;
  String? accountNumber;
  String? ifsc;
  String? bankName;
  String? userId;
  String? branchName;
  bool? supplierAutoVerified;
  String? accountCategory;
  String? status;
  bool? primary;
  bool? supplier;
  bool? verified;
  String? seqPrefix;
  num? seqPrefixLength;

  Payload({
    this.id,
    this.partnerId,
    this.lenderId,
    this.createdBy,
    this.createdByName,
    this.lastModifiedByName,
    this.creationDate,
    this.lastModifiedDate,
    this.lastModifiedBy,
    this.accountHolderName,
    this.accountNumber,
    this.ifsc,
    this.bankName,
    this.userId,
    this.branchName,
    this.supplierAutoVerified,
    this.accountCategory,
    this.status,
    this.primary,
    this.supplier,
    this.verified,
    this.seqPrefix,
    this.seqPrefixLength,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    partnerId: json["partnerId"],
    lenderId: json["lenderId"],
    createdBy: json["createdBy"],
    createdByName: json["createdByName"],
    lastModifiedByName: json["lastModifiedByName"],
    creationDate: json["creationDate"],
    lastModifiedDate: json["lastModifiedDate"],
    lastModifiedBy: json["lastModifiedBy"],
    accountHolderName: json["accountHolderName"],
    accountNumber: json["accountNumber"],
    ifsc: json["ifsc"],
    bankName: json["bankName"],
    userId: json["userId"],
    branchName: json["branchName"],
    supplierAutoVerified: json["supplierAutoVerified"],
    accountCategory: json["accountCategory"],
    status: json["status"],
    primary: json["primary"],
    supplier: json["supplier"],
    verified: json["verified"],
    seqPrefix: json["seqPrefix"],
    seqPrefixLength: json["seqPrefixLength"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "partnerId": partnerId,
    "lenderId": lenderId,
    "createdBy": createdBy,
    "createdByName": createdByName,
    "lastModifiedByName": lastModifiedByName,
    "creationDate": creationDate,
    "lastModifiedDate": lastModifiedDate,
    "lastModifiedBy": lastModifiedBy,
    "accountHolderName": accountHolderName,
    "accountNumber": accountNumber,
    "ifsc": ifsc,
    "bankName": bankName,
    "userId": userId,
    "branchName": branchName,
    "supplierAutoVerified": supplierAutoVerified,
    "accountCategory": accountCategory,
    "status": status,
    "primary": primary,
    "supplier": supplier,
    "verified": verified,
    "seqPrefix": seqPrefix,
    "seqPrefixLength": seqPrefixLength,
  };
}
