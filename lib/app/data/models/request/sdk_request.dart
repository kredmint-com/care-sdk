import 'dart:convert';

SdkRequest sdkRequestFromJson(String str) => SdkRequest.fromJson(json.decode(str));

String sdkRequestToJson(SdkRequest data) => json.encode(data.toJson());

class SdkRequest {
  String? username;
  String? source;
  String? program;
  String? requestId;
  String? puId;
  String? anchorId;
  String? channel;
  String? version;
  UserContext? userContext;
  ClientMeta? clientMeta;

  SdkRequest({
    this.username,
    this.source,
    this.program,
    this.requestId,
    this.puId,
    this.anchorId,
    this.channel,
    this.version,
    this.userContext,
    this.clientMeta,
  });

  factory SdkRequest.fromJson(Map<String, dynamic> json) => SdkRequest(
    username: json["username"],
    source: json["source"],
    program: json["program"],
    requestId: json["requestId"],
    puId: json["puId"],
    anchorId: json["anchorId"],
    channel: json["channel"],
    version: json["version"],
    userContext: json["userContext"] == null ? null : UserContext.fromJson(json["userContext"]),
    clientMeta: json["clientMeta"] == null ? null : ClientMeta.fromJson(json["clientMeta"]),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "source": source,
    "program": program,
    "requestId": requestId,
    "puId": puId,
    "anchorId": anchorId,
    "channel": channel,
    "version": version,
    "userContext": userContext?.toJson(),
    "clientMeta": clientMeta?.toJson(),
  };
}

class ClientMeta {
  String? productNo;
  String? productName;
  num? sumInsured;

  ClientMeta({
    this.productNo,
    this.productName,
    this.sumInsured,
  });

  factory ClientMeta.fromJson(Map<String, dynamic> json) => ClientMeta(
    productNo: json["productNo"],
    productName: json["productName"],
    sumInsured: json["sumInsured"],
  );

  Map<String, dynamic> toJson() => {
    "productNo": productNo,
    "productName": productName,
    "sumInsured": sumInsured,
  };
}

class UserContext {
  String? pan;
  String? name;
  String? gender;
  String? email;
  DateTime? dob;
  Address? address;

  UserContext({
    this.pan,
    this.name,
    this.gender,
    this.email,
    this.dob,
    this.address,
  });

  factory UserContext.fromJson(Map<String, dynamic> json) => UserContext(
    pan: json["pan"],
    name: json["name"],
    gender: json["gender"],
    email: json["email"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "pan": pan,
    "name": name,
    "gender": gender,
    "email": email,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "address": address?.toJson(),
  };
}

class Address {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pincode;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.pincode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "state": state,
    "pincode": pincode,
  };
}
