class CKycInitiatedResponse {
  List<Payload>? payload;
  num? sum;
  num? timestamp;
  String? requestId;

  CKycInitiatedResponse(
      {this.payload, this.sum, this.timestamp, this.requestId});

  CKycInitiatedResponse.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
    sum = json['sum'];
    timestamp = json['timestamp'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    data['sum'] = this.sum;
    data['timestamp'] = this.timestamp;
    data['requestId'] = this.requestId;
    return data;
  }
}

class Payload {
  String? promoterId;
  String? promoterName;
  String? promoterPan;
  String? dob;
  String? mobile;
  String? gender;
  bool? ckycEnable;
  bool? otpVerified;
  bool? otpSent;
  bool? allMatched;
  bool? ckycFailed;
  String? ckycRefId;
  bool? digitalKycEnable;
  bool? digitalKycDone;
  DigioKycInitResponse? digioKycInitResponse;
  bool? manualKycEnable;
  bool? manualKycDone;

  Payload(
      {this.promoterId,
        this.promoterName,
        this.promoterPan,
        this.dob,
        this.mobile,
        this.gender,
        this.ckycEnable,
        this.otpVerified,
        this.otpSent,
        this.allMatched,
        this.ckycFailed,
        this.ckycRefId,
        this.digitalKycEnable,
        this.digitalKycDone,
        this.digioKycInitResponse,
        this.manualKycEnable,
        this.manualKycDone});

  Payload.fromJson(Map<String, dynamic> json) {
    promoterId = json['promoterId'];
    promoterName = json['promoterName'];
    promoterPan = json['promoterPan'];
    dob = json['dob'];
    mobile = json['mobile'];
    gender = json['gender'];
    ckycEnable = json['ckycEnable'];
    otpVerified = json['otpVerified'];
    otpSent = json['otpSent'];
    allMatched = json['allMatched'];
    ckycFailed = json['ckycFailed'];
    ckycRefId = json['ckycRefId'];
    digitalKycEnable = json['digitalKycEnable'];
    digitalKycDone = json['digitalKycDone'];
    digioKycInitResponse = json['digioKycInitResponse'] != null
        ? DigioKycInitResponse.fromJson(json['digioKycInitResponse'])
        : null;
    manualKycEnable = json['manualKycEnable'];
    manualKycDone = json['manualKycDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promoterId'] = this.promoterId;
    data['promoterName'] = this.promoterName;
    data['promoterPan'] = this.promoterPan;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['ckycEnable'] = this.ckycEnable;
    data['otpVerified'] = this.otpVerified;
    data['otpSent'] = this.otpSent;
    data['allMatched'] = this.allMatched;
    data['ckycFailed'] = this.ckycFailed;
    data['ckycRefId'] = this.ckycRefId;
    data['digitalKycEnable'] = this.digitalKycEnable;
    data['digitalKycDone'] = this.digitalKycDone;
    if (this.digioKycInitResponse != null) {
      data['digioKycInitResponse'] = this.digioKycInitResponse!.toJson();
    }
    data['manualKycEnable'] = this.manualKycEnable;
    data['manualKycDone'] = this.manualKycDone;
    return data;
  }
}

class DigioKycInitResponse {
  String? id;
  String? status;
  String? createdAt;
  String? customerIdentifier;
  String? referenceId;
  String? transactionId;
  String? customerName;
  num? expireInDays;
  bool? reminderRegistered;
  AccessToken? accessToken;
  String? workflowName;
  bool? autoApproved;
  String? templateId;

  DigioKycInitResponse(
      {this.id,
        this.status,
        this.createdAt,
        this.customerIdentifier,
        this.referenceId,
        this.transactionId,
        this.customerName,
        this.expireInDays,
        this.reminderRegistered,
        this.accessToken,
        this.workflowName,
        this.autoApproved,
        this.templateId});

  DigioKycInitResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    customerIdentifier = json['customer_identifier'];
    referenceId = json['reference_id'];
    transactionId = json['transaction_id'];
    customerName = json['customer_name'];
    expireInDays = json['expire_in_days'];
    reminderRegistered = json['reminder_registered'];
    accessToken = json['access_token'] != null
        ? AccessToken.fromJson(json['access_token'])
        : null;
    workflowName = json['workflow_name'];
    autoApproved = json['auto_approved'];
    templateId = json['template_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['customer_identifier'] = this.customerIdentifier;
    data['reference_id'] = this.referenceId;
    data['transaction_id'] = this.transactionId;
    data['customer_name'] = this.customerName;
    data['expire_in_days'] = this.expireInDays;
    data['reminder_registered'] = this.reminderRegistered;
    if (this.accessToken != null) {
      data['access_token'] = this.accessToken!.toJson();
    }
    data['workflow_name'] = this.workflowName;
    data['auto_approved'] = this.autoApproved;
    data['template_id'] = this.templateId;
    return data;
  }
}

class AccessToken {
  String? id;
  String? entityId;
  String? validTill;
  String? createdAt;

  AccessToken({this.id, this.entityId, this.validTill, this.createdAt});

  AccessToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entity_id'];
    validTill = json['valid_till'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['entity_id'] = this.entityId;
    data['valid_till'] = this.validTill;
    data['created_at'] = this.createdAt;
    return data;
  }
}
