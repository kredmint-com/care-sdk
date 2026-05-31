class ValidateIfscResponse {
  Payload? payload;
  num? sum;
  num? timestamp;
  String? requestId;

  ValidateIfscResponse(
      {this.payload, this.sum, this.timestamp, this.requestId});

  ValidateIfscResponse.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    sum = json['sum'];
    timestamp = json['timestamp'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['sum'] = sum;
    data['timestamp'] = timestamp;
    data['requestId'] = requestId;
    return data;
  }
}

class Payload {
  String? response;
  String? type;
  bool? valid;
  String? status;
  String? subCode;
  String? message;
  String? bank;
  String? ifsc;
  String? neft;
  String? imps;
  String? rtgs;
  String? upi;
  String? ft;
  String? card;
  String? micr;
  String? nbin;
  String? address;
  String? city;
  String? state;
  String? branch;
  String? ifscSubcode;
  String? category;
  String? swiftCode;

  Payload(
      {this.response,
      this.type,
      this.valid,
      this.status,
      this.subCode,
      this.message,
      this.bank,
      this.ifsc,
      this.neft,
      this.imps,
      this.rtgs,
      this.upi,
      this.ft,
      this.card,
      this.micr,
      this.nbin,
      this.address,
      this.city,
      this.state,
      this.branch,
      this.ifscSubcode,
      this.category,
      this.swiftCode});

  Payload.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    type = json['type'];
    valid = json['valid'];
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    bank = json['bank'];
    ifsc = json['ifsc'];
    neft = json['neft'];
    imps = json['imps'];
    rtgs = json['rtgs'];
    upi = json['upi'];
    ft = json['ft'];
    card = json['card'];
    micr = json['micr'];
    nbin = json['nbin'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    branch = json['branch'];
    ifscSubcode = json['ifscSubcode'];
    category = json['category'];
    swiftCode = json['swiftCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['response'] = response;
    data['type'] = type;
    data['valid'] = valid;
    data['status'] = status;
    data['subCode'] = subCode;
    data['message'] = message;
    data['bank'] = bank;
    data['ifsc'] = ifsc;
    data['neft'] = neft;
    data['imps'] = imps;
    data['rtgs'] = rtgs;
    data['upi'] = upi;
    data['ft'] = ft;
    data['card'] = card;
    data['micr'] = micr;
    data['nbin'] = nbin;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['branch'] = branch;
    data['ifscSubcode'] = ifscSubcode;
    data['category'] = category;
    data['swiftCode'] = swiftCode;
    return data;
  }
}
