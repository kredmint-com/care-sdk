// To parse this JSON data, do
//
//     final syncPanResponse = syncPanResponseFromJson(jsonString);

import 'dart:convert';

SyncPanResponse syncPanResponseFromJson(String str) =>
    SyncPanResponse.fromJson(json.decode(str));

String syncPanResponseToJson(SyncPanResponse data) =>
    json.encode(data.toJson());

class SyncPanResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  String? requestId;
  dynamic error;

  SyncPanResponse({
    this.payload,
    this.sum,
    this.timestamp,
    this.requestId,
    this.error,
  });

  factory SyncPanResponse.fromJson(Map<String, dynamic> json) =>
      SyncPanResponse(
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
  String? message;
  String? pan;
  String? type;
  String? gender;
  String? email;
  Address? address;
  num? referenceId;
  String? verificationId;
  String? nameProvided;
  String? registeredName;
  String? namePanCard;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? maskedAadhaarNumber;
  String? mobileNumber;
  bool? aadhaarLinked;

  Payload({
    this.status,
    this.message,
    this.pan,
    this.type,
    this.gender,
    this.email,
    this.address,
    this.referenceId,
    this.verificationId,
    this.nameProvided,
    this.registeredName,
    this.namePanCard,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.maskedAadhaarNumber,
    this.mobileNumber,
    this.aadhaarLinked,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        status: json["status"],
        message: json["message"],
        pan: json["pan"],
        type: json["type"],
        gender: json["gender"],
        email: json["email"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        referenceId: json["reference_id"],
        verificationId: json["verification_id"],
        nameProvided: json["name_provided"],
        registeredName: json["registered_name"],
        namePanCard: json["name_pan_card"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateOfBirth: json["date_of_birth"],
        maskedAadhaarNumber: json["masked_aadhaar_number"],
        mobileNumber: json["mobile_number"],
        aadhaarLinked: json["aadhaar_linked"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pan": pan,
        "type": type,
        "gender": gender,
        "email": email,
        "address": address?.toJson(),
        "reference_id": referenceId,
        "verification_id": verificationId,
        "name_provided": nameProvided,
        "registered_name": registeredName,
        "name_pan_card": namePanCard,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
        "masked_aadhaar_number": maskedAadhaarNumber,
        "mobile_number": mobileNumber,
        "aadhaar_linked": aadhaarLinked,
      };
}

class Address {
  String? street;
  String? city;
  String? state;
  num? pincode;
  String? country;
  String? fullAddress;

  Address({
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.country,
    this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        country: json["country"],
        fullAddress: json["full_address"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "country": country,
        "full_address": fullAddress,
      };
}
