// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

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

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
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
  String? panNumber;
  String? channel;
  Token? token;
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
    this.panNumber,
    this.channel,
    this.token,
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
        panNumber: json["panNumber"],
        channel: json["channel"],
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
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
        "panNumber": panNumber,
        "channel": channel,
        "token": token?.toJson(),
        "requestId": requestId,
        "userId": userId,
        "accId": accId,
        "puId": puId,
      };
}

class Token {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  String? expiresIn;
  String? scope;
  String? id;
  List<String>? roles;
  String? version;

  Token({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.id,
    this.roles,
    this.version,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
        scope: json["scope"],
        id: json["id"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
        "scope": scope,
        "id": id,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "version": version,
      };
}
