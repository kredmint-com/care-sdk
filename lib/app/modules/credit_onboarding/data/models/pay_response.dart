class PayResponse {
  PayData? payload;
  num? sum;
  num? timestamp;

  PayResponse({
    this.payload,
    this.sum,
    this.timestamp,
  });

  PayResponse.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? PayData.fromJson(json['payload']) : null;
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

class PayData {
  bool? success;
  String? pgSessionId;
  String? orderId;
  String? pgName;
  num? orderAmount;
  num? orderAmountInRs;
  String? key;
  String? name;
  PayMeta? meta;

  PayData({
    this.success,
    this.pgSessionId,
    this.orderId,
    this.pgName,
    this.orderAmount,
    this.orderAmountInRs,
    this.key,
    this.name,
    this.meta,
  });

  PayData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    pgSessionId = json['pgSessionId'];
    orderId = json['orderId'];
    pgName = json['pgName'];
    orderAmount = json['orderAmount'];
    orderAmountInRs = json["orderAmountInRs"];
    key = json['key'];
    name = json['name'];
    meta = json['meta'] != null ? PayMeta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['pgSessionId'] = pgSessionId;
    data['orderId'] = orderId;
    data['pgName'] = pgName;
    data['orderAmount'] = orderAmount;
    data["orderAmountInRs"] = orderAmountInRs;
    data['key'] = key;
    data['name'] = name;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class PayMeta {
  String? name;
  String? description;
  String? key;

  PayMeta({this.name, this.description});

  PayMeta.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data["key"] = key;
    return data;
  }
}
