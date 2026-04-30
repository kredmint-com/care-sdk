class SendReportResponse {
  Payload? payload;
  num? sum;
  num? timestamp;

  SendReportResponse({this.payload, this.sum, this.timestamp});

  SendReportResponse.fromJson(Map<String, dynamic> json) {
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
  String? msg;
  String? refId;

  Payload({this.success, this.msg, this.refId});

  Payload.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    refId = json['refId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    data['refId'] = refId;
    return data;
  }
}
