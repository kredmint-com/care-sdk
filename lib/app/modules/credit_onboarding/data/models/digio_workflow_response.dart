class DigioWorkflowResponse {
  String? payload;
  num? sum;
  num? timestamp;
  String? requestId;

  DigioWorkflowResponse(
      {this.payload, this.sum, this.timestamp, this.requestId});

  DigioWorkflowResponse.fromJson(Map<String, dynamic> json) {
    payload = json['payload'];
    sum = json['sum'];
    timestamp = json['timestamp'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payload'] = payload;
    data['sum'] = sum;
    data['timestamp'] = timestamp;
    data['requestId'] = requestId;
    return data;
  }
}
