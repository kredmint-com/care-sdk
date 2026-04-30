// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

SdkUserModel userModelFromJson(String str) =>
    SdkUserModel.fromJson(json.decode(str));

String userModelToJson(SdkUserModel data) => json.encode(data.toJson());

class SdkUserModel {
  String? accessToken;
  String? orderAccessToken;
  String? tokenType;
  String? refreshToken;
  num? expiresIn;
  String? scope;
  String? id;
  String? orderUserId;
  String? accountId;
  List<Profile>? profiles;
  String? version;
  List<String>? roles;
  String? fullName;
  String? phoneNumber;
  String? userProfileId;

  SdkUserModel({
    this.accessToken,
    this.orderAccessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.id,
    this.orderUserId,
    this.accountId,
    this.profiles,
    this.version,
    this.roles,
    this.fullName,
    this.phoneNumber,
    this.userProfileId,
  });

  SdkUserModel copyWith({
    String? accessToken,
    String? orderAccessToken,
    String? tokenType,
    String? refreshToken,
    num? expiresIn,
    String? scope,
    String? id,
    String? orderUserId,
    String? accountId,
    List<Profile>? profiles,
    String? version,
    List<String>? roles,
    String? fullName,
    String? phoneNumber,
    String? userProfileId,
  }) => SdkUserModel(
    accessToken: accessToken ?? this.accessToken,
    orderAccessToken: orderAccessToken ?? this.orderAccessToken,
    tokenType: tokenType ?? this.tokenType,
    refreshToken: refreshToken ?? this.refreshToken,
    expiresIn: expiresIn ?? this.expiresIn,
    scope: scope ?? this.scope,
    id: id ?? this.id,
    orderUserId: orderUserId ?? this.orderUserId,
    accountId: accountId ?? this.accountId,
    profiles: profiles ?? this.profiles,
    version: version ?? this.version,
    roles: roles ?? this.roles,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    userProfileId: userProfileId ?? this.userProfileId,
  );

  factory SdkUserModel.fromJson(Map<String, dynamic> json) => SdkUserModel(
    accessToken: json["access_token"],
    orderAccessToken: json["orderAccessToken"],
    tokenType: json["token_type"],
    refreshToken: json["refresh_token"],
    expiresIn: json["expires_in"],
    scope: json["scope"],
    id: json["id"],
    orderUserId: json["orderUserId"],
    accountId: json["accountId"],
    profiles:
        json["profiles"] == null
            ? []
            : List<Profile>.from(
              json["profiles"]!.map((x) => Profile.fromJson(x)),
            ),
    version: json["version"],
    roles:
        json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "orderAccessToken": orderAccessToken,
    "token_type": tokenType,
    "refresh_token": refreshToken,
    "expires_in": expiresIn,
    "scope": scope,
    "id": id,
    "orderUserId": orderUserId,
    "accountId": accountId,
    "profiles":
        profiles == null
            ? []
            : List<dynamic>.from(profiles!.map((x) => x.toJson())),
    "version": version,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "fullName": fullName,
    "phoneNumber": phoneNumber,
  };
}

class Profile {
  String? id;
  String? lenderId;
  String? anchorId;

  Profile({this.id, this.lenderId, this.anchorId});

  Profile copyWith({String? id, String? lenderId, String? anchorId}) => Profile(
    id: id ?? this.id,
    lenderId: lenderId ?? this.lenderId,
    anchorId: anchorId ?? this.anchorId,
  );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    lenderId: json["lenderId"],
    anchorId: json["anchorId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lenderId": lenderId,
    "anchorId": anchorId,
  };
}
