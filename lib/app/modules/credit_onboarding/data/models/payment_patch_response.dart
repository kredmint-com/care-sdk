class PaymentPatchResponse {
  Payload? payload;
  num? sum;
  num? timestamp;

  PaymentPatchResponse({this.payload, this.sum, this.timestamp});

  PaymentPatchResponse.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? utr;
  num? amount;
  String? modeOfPayment;
  String? transactionRefId;
  num? loanAmount;
  num? interestAmount;
  num? penalAmount;
  String? refNo;
  num? paidAt;
  String? title;
  String? subTitle;

  Payload(
      {this.status,
        this.utr,
        this.amount,
        this.modeOfPayment,
        this.transactionRefId,
        this.loanAmount,
        this.interestAmount,
        this.penalAmount,
        this.refNo,
        this.paidAt,
        this.title,
        this.subTitle});

  Payload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    utr = json['utr'];
    amount = json['amount'];
    modeOfPayment = json['modeOfPayment'];
    transactionRefId = json['transactionRefId'];
    loanAmount = json['loanAmount'];
    interestAmount = json['interestAmount'];
    penalAmount = json['penalAmount'];
    refNo = json['refNo'];
    paidAt = json['paidAt'];
    title = json['title'];
    subTitle = json['subTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['utr'] = utr;
    data['amount'] = amount;
    data['modeOfPayment'] = modeOfPayment;
    data['transactionRefId'] = transactionRefId;
    data['loanAmount'] = loanAmount;
    data['interestAmount'] = interestAmount;
    data['penalAmount'] = penalAmount;
    data['refNo'] = refNo;
    data['paidAt'] = paidAt;
    data['title'] = title;
    data['subTitle'] = subTitle;
    return data;
  }
}
