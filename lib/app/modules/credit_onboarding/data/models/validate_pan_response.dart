class ValidatePanResponse {
  Payload? payload;
  num? sum;
  num? timestamp;

  ValidatePanResponse({this.payload, this.sum, this.timestamp});

  ValidatePanResponse.fromJson(Map<String, dynamic> json) {
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    sum = json['sum'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['sum'] = this.sum;
    data['timestamp'] = this.timestamp;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pan'] = this.pan;
    data['nameMatched'] = this.nameMatched;
    data['entityType'] = this.entityType;
    data['status'] = this.status;
    data['dobProvided'] = this.dobProvided;
    data['dobMatched'] = this.dobMatched;
    data['type'] = this.type;
    data['referenceId'] = this.referenceId;
    data['nameProvided'] = this.nameProvided;
    data['valid'] = this.valid;
    data['message'] = this.message;
    data['aadhaarSeedingStatus'] = this.aadhaarSeedingStatus;
    return data;
  }
}
