class LoiResponse {
  Payload? payload;
  num? sum;
  num? timestamp;

  LoiResponse({this.payload, this.sum, this.timestamp,});

  LoiResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? lenderId;
  num? creationDate;
  num? lastModifiedDate;
  String? lastModifiedBy;
  String? lenderName;
  String? lenderAddress;
  String? borrowerName;
  String? companyName;
  num? expiryDate;
  num? loanAmount;
  num? tenure;
  num? processingFee;
  num? interestRate;
  num? apr;
  num? penalInterest;
  String? userId;
  bool? active;
  String? status;
  num? recursivePaymentDuration;
  List<num>? paymentDurationOptions;
  bool? disableAutoDebit;
  bool? dailyDeduction;
  List<String>? allowedInvoiceTypes;
  String? durationType;
  num? programLimit;
  String? userType;
  num? liabilityInterestDays;
  bool? subPlan;
  String? primarySecurity;
  String? guaranteePersonal;
  String? securityCheques;
  String? businessCovenants;
  num? minAmount;
  num? stepAmount;
  num? stepTenure;
  String? businessType;
  String? creditType;
  String? businessCategory;
  String? anchorName;
  num? seqPrefixLength;

  Payload(
      {
        this.id,
        this.lenderId,
        this.creationDate,
        this.lastModifiedDate,
        this.lastModifiedBy,
        this.lenderName,
        this.lenderAddress,
        this.borrowerName,
        this.companyName,
        this.expiryDate,
        this.loanAmount,
        this.tenure,
        this.processingFee,
        this.interestRate,
        this.apr,
        this.penalInterest,
        this.userId,
        this.active,
        this.status,
        this.recursivePaymentDuration,
        this.paymentDurationOptions,
        this.disableAutoDebit,
        this.dailyDeduction,
        this.allowedInvoiceTypes,
        this.durationType,
        this.programLimit,
        this.userType,
        this.liabilityInterestDays,
        this.subPlan,
        this.primarySecurity,
        this.guaranteePersonal,
        this.securityCheques,
        this.businessCovenants,
        this.minAmount,
        this.stepAmount,
        this.stepTenure,
        this.businessType,
        this.creditType,
        this.businessCategory,
        this.anchorName,
        this.seqPrefixLength});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lenderId = json['lenderId'];
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lenderName = json['lenderName'];
    lenderAddress = json['lenderAddress'];
    borrowerName = json['borrowerName'];
    companyName = json['companyName'];
    expiryDate = json['expiryDate'];
    loanAmount = json['loanAmount'];
    tenure = json['tenure'];
    processingFee = json['processingFee'];
    interestRate = json['interestRate'];
    apr = json['apr'];
    penalInterest = json['penalInterest'];
    userId = json['userId'];
    active = json['active'];
    status = json['status'];
    recursivePaymentDuration = json['recursivePaymentDuration'];
    paymentDurationOptions = json['paymentDurationOptions'].cast<num>();
    disableAutoDebit = json['disableAutoDebit'];
    dailyDeduction = json['dailyDeduction'];
    allowedInvoiceTypes = json['allowedInvoiceTypes'].cast<String>();
    durationType = json['durationType'];
    programLimit = json['programLimit'];
    userType = json['userType'];
    liabilityInterestDays = json['liabilityInterestDays'];
    subPlan = json['subPlan'];
    primarySecurity = json['primarySecurity'];
    guaranteePersonal = json['guaranteePersonal'];
    securityCheques = json['securityCheques'];
    businessCovenants = json['businessCovenants'];
    minAmount = json['minAmount'];
    stepAmount = json['stepAmount'];
    stepTenure = json['stepTenure'];
    businessType = json['businessType'];
    creditType = json['creditType'];
    businessCategory = json['businessCategory'];
    anchorName = json['anchorName'];
    seqPrefixLength = json['seqPrefixLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lenderId'] = lenderId;
    data['creationDate'] = creationDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lenderName'] = lenderName;
    data['lenderAddress'] = lenderAddress;
    data['borrowerName'] = borrowerName;
    data['companyName'] = companyName;
    data['expiryDate'] = expiryDate;
    data['loanAmount'] = loanAmount;
    data['tenure'] = tenure;
    data['processingFee'] = processingFee;
    data['interestRate'] = interestRate;
    data['apr'] = apr;
    data['penalInterest'] = penalInterest;
    data['userId'] = userId;
    data['active'] = active;
    data['status'] = status;
    data['recursivePaymentDuration'] = recursivePaymentDuration;
    data['paymentDurationOptions'] = paymentDurationOptions;
    data['disableAutoDebit'] = disableAutoDebit;
    data['dailyDeduction'] = dailyDeduction;
    data['allowedInvoiceTypes'] = allowedInvoiceTypes;
    data['durationType'] = durationType;
    data['programLimit'] = programLimit;
    data['userType'] = userType;
    data['liabilityInterestDays'] = liabilityInterestDays;
    data['subPlan'] = subPlan;
    data['primarySecurity'] = primarySecurity;
    data['guaranteePersonal'] = guaranteePersonal;
    data['securityCheques'] = securityCheques;
    data['businessCovenants'] = businessCovenants;
    data['minAmount'] = minAmount;
    data['stepAmount'] = stepAmount;
    data['stepTenure'] = stepTenure;
    data['businessType'] = businessType;
    data['creditType'] = creditType;
    data['businessCategory'] = businessCategory;
    data['anchorName'] = anchorName;
    data['seqPrefixLength'] = seqPrefixLength;
    return data;
  }
}
