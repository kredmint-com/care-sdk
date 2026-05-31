class ValidateGstResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  dynamic error;

  ValidateGstResponse({this.payload, this.sum, this.timestamp, this.error});

  ValidateGstResponse.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    sum = json['sum'];
    timestamp = json['timestamp'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['sum'] = sum;
    data['timestamp'] = timestamp;
    data['error'] = error;
    return data;
  }
}

class Payload {
  String? gstin;
  String? type;
  bool? valid;
  bool? nameMatched;
  String? legalName;
  String? businessType;
  String? centerJurisdiction;
  String? stateJurisdiction;
  String? status;
  String? gstInStatus;
  String? dateOfRegistration;
  String? lastUpdateDate;
  String? tradeName;
  PrincipalAddress? principalAddress;
  List<String>? natureOfBusinessActivities;

  Payload(
      {this.gstin,
      this.type,
      this.valid,
      this.nameMatched,
      this.legalName,
      this.businessType,
      this.centerJurisdiction,
      this.stateJurisdiction,
      this.status,
      this.gstInStatus,
      this.dateOfRegistration,
      this.lastUpdateDate,
      this.tradeName,
      this.principalAddress,
      this.natureOfBusinessActivities});

  Payload.fromJson(Map<String, dynamic> json) {
    gstin = json['gstin'];
    type = json['type'];
    valid = json['valid'];
    nameMatched = json['nameMatched'];
    legalName = json['legalName'];
    businessType = json['businessType'];
    centerJurisdiction = json['centerJurisdiction'];
    stateJurisdiction = json['stateJurisdiction'];
    status = json['status'];
    gstInStatus = json['gstInStatus'];
    dateOfRegistration = json['dateOfRegistration'];
    lastUpdateDate = json['lastUpdateDate'];
    tradeName = json['tradeName'];
    principalAddress = json['principalAddress'] != null
        ? PrincipalAddress.fromJson(json['principalAddress'])
        : null;
    natureOfBusinessActivities =
        json['natureOfBusinessActivities']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstin'] = gstin;
    data['type'] = type;
    data['valid'] = valid;
    data['nameMatched'] = nameMatched;
    data['legalName'] = legalName;
    data['businessType'] = businessType;
    data['centerJurisdiction'] = centerJurisdiction;
    data['stateJurisdiction'] = stateJurisdiction;
    data['status'] = status;
    data['gstInStatus'] = gstInStatus;
    data['dateOfRegistration'] = dateOfRegistration;
    data['lastUpdateDate'] = lastUpdateDate;
    data['tradeName'] = tradeName;
    if (principalAddress != null) {
      data['principalAddress'] = principalAddress!.toJson();
    }
    data['natureOfBusinessActivities'] = natureOfBusinessActivities;
    return data;
  }
}

class PrincipalAddress {
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? state;
  String? city;
  String? pincode;
  dynamic addressType;
  dynamic beatType;
  String? addressLines;

  PrincipalAddress(
      {this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.state,
      this.city,
      this.pincode,
      this.addressType,
      this.beatType,
      this.addressLines});

  PrincipalAddress.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    addressLine3 = json['addressLine3'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    addressType = json['addressType'];
    beatType = json['beatType'];
    addressLines = json['addressLines'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['addressLine3'] = addressLine3;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    data['addressType'] = addressType;
    data['beatType'] = beatType;
    data['addressLines'] = addressLines;
    return data;
  }
}
