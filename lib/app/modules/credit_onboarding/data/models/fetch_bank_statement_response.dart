class FetchBankStatementResponse {
  Payload? payload;
  num? sum;
  num? timestamp;

  FetchBankStatementResponse({
    this.payload,
    this.sum,
    this.timestamp,
  });

  FetchBankStatementResponse.fromJson(Map<String, dynamic> json) {
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
  bool? success;
  String? redirectUrl;
  Null errorMsg;
  String? refId;

  Payload({this.success, this.redirectUrl, this.errorMsg, this.refId});

  Payload.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    redirectUrl = json['redirectUrl'];
    errorMsg = json['errorMsg'];
    refId = json['refId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['redirectUrl'] = redirectUrl;
    data['errorMsg'] = errorMsg;
    data['refId'] = refId;
    return data;
  }
}
