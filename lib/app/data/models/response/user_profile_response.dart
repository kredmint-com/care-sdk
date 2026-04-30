// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) => UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) => json.encode(data.toJson());

class UserProfileResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  String? requestId;

  UserProfileResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
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

class Payload {
  bool? show;
  String? landingType;
  num? availableCreditLimit;
  num? creditLimit;
  num? totalOutstanding;
  num? lockedAmt;
  String? channel;
  String? requestId;
  String? userId;
  String? accId;
  String? puId;

  Payload({
    this.show,
    this.landingType,
    this.availableCreditLimit,
    this.creditLimit,
    this.totalOutstanding,
    this.lockedAmt,
    this.channel,
    this.requestId,
    this.userId,
    this.accId,
    this.puId,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    show: json["show"],
    landingType: json["landingType"],
    availableCreditLimit: json["availableCreditLimit"],
    creditLimit: json["creditLimit"],
    totalOutstanding: json["totalOutstanding"],
    lockedAmt: json["lockedAmt"],
    channel: json["channel"],
    requestId: json["requestId"],
    userId: json["userId"],
    accId: json["accId"],
    puId: json["puId"],
  );

  Map<String, dynamic> toJson() => {
    "show": show,
    "landingType": landingType,
    "availableCreditLimit": availableCreditLimit,
    "creditLimit": creditLimit,
    "totalOutstanding": totalOutstanding,
    "lockedAmt": lockedAmt,
    "channel": channel,
    "requestId": requestId,
    "userId": userId,
    "accId": accId,
    "puId": puId,
  };
}
