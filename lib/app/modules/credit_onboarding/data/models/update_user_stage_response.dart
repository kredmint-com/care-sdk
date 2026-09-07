class UpdateUserStageResponse {
  Payload? payload;

  UpdateUserStageResponse({this.payload});

  UpdateUserStageResponse.fromJson(Map<String, dynamic> json) {
    payload =
    json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? errorMsg;

  Payload({this.errorMsg});

  Payload.fromJson(Map<String, dynamic> json) {
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorMsg'] = errorMsg;
    return data;
  }
}
