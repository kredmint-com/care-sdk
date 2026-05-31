class ValidatePanResponse {
  Payload? payload;
  num? sum;
  num? timestamp;

  ValidatePanResponse({this.payload, this.sum, this.timestamp});

  ValidatePanResponse.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    sum = json['sum'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['sum'] = sum;
    data['timestamp'] = timestamp;
    return data;
  }
}

class Payload {
  String? pan;
  bool? nameMatched;
  String? entityType;
  String? status;
  String? dobProvided;
  bool? dobMatched;
  String? type;
  String? referenceId;
  String? nameProvided;
  bool? valid;
  String? message;
  String? aadhaarSeedingStatus;

  Payload(
      {this.pan,
      this.nameMatched,
      this.entityType,
      this.status,
      this.dobProvided,
      this.dobMatched,
      this.type,
      this.referenceId,
      this.nameProvided,
      this.valid,
      this.message,
      this.aadhaarSeedingStatus});

  Payload.fromJson(Map<String, dynamic> json) {
    pan = json['pan'];
    nameMatched = json['nameMatched'];
    entityType = json['entityType'];
    status = json['status'];
    dobProvided = json['dobProvided'];
    dobMatched = json['dobMatched'];
    type = json['type'];
    referenceId = json['referenceId'];
    nameProvided = json['nameProvided'];
    valid = json['valid'];
    message = json['message'];
    aadhaarSeedingStatus = json['aadhaarSeedingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pan'] = pan;
    data['nameMatched'] = nameMatched;
    data['entityType'] = entityType;
    data['status'] = status;
    data['dobProvided'] = dobProvided;
    data['dobMatched'] = dobMatched;
    data['type'] = type;
    data['referenceId'] = referenceId;
    data['nameProvided'] = nameProvided;
    data['valid'] = valid;
    data['message'] = message;
    data['aadhaarSeedingStatus'] = aadhaarSeedingStatus;
    return data;
  }
}
