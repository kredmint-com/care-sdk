import 'package:flutter/cupertino.dart';

import 'add_promoter_request.dart';

class OnboardingStepsResponse {
  OnboardingStepsPayload? payload;
  num? sum;
  num? timestamp;

  OnboardingStepsResponse({this.payload, this.sum, this.timestamp});

  OnboardingStepsResponse.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? OnboardingStepsPayload.fromJson(json['payload']) : null;
    sum = json['sum'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['sum'] = sum;
    data['timestamp'] = timestamp;
    return data;
  }

  OnboardingStepsResponse copyWith({
    OnboardingStepsPayload? payload,
    num? sum,
    num? timestamp,
  }) {
    return OnboardingStepsResponse(
      payload: payload ?? this.payload,
      sum: sum ?? this.sum,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class OnboardingStepsPayload {
  StepsPage? page;
  String? pageId;
  bool? confirm;
  bool? allowSkip;
  bool? prePageEnable;
  String? prvPageId;
  String? prvPageName;
  LoiSummary? loiSummary;
  ProcessingFeeData? processingFee;
  DigioKycResponse? digioKycResponse;
  String? pageCategory;
  String? profileId;
  String? product;
  List<StaticPageRes>? staticPageRes;
  Meta? meta;

  OnboardingStepsPayload({
    this.page,
    this.pageId,
    this.confirm,
    this.allowSkip,
    this.prePageEnable,
    this.prvPageId,
    this.prvPageName,
    this.loiSummary,
    this.processingFee,
    this.digioKycResponse,
    this.pageCategory,
    this.profileId,
    this.product,
    this.staticPageRes,
    this.meta,
  });

  OnboardingStepsPayload.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? StepsPage.fromJson(json['page']) : null;
    pageId = json['pageId'];
    confirm = json['confirm'];
    allowSkip = json['allowSkip'];
    prePageEnable = json['prePageEnable'];
    prvPageId = json['prvPageId'];
    prvPageName = json['prvPageName'];
    loiSummary = json["loiSummary"] != null
        ? LoiSummary.fromJson(json["loiSummary"])
        : null;
    processingFee = json["processingFee"] != null
        ? ProcessingFeeData.fromJson(json["processingFee"])
        : null;
    digioKycResponse = json["digioToken"] != null
        ? DigioKycResponse.fromJson(json["digioToken"])
        : null;
    pageCategory = json['pageCategory'];
    profileId = json['profileId'];
    product = json['product'];
    if (json['staticPageRes'] != null) {
      staticPageRes = <StaticPageRes>[];
      if (json['staticPageRes'] is Map<String, dynamic>) {
        staticPageRes!.add(StaticPageRes.fromJson(json['staticPageRes']));
      } else {
        json['staticPageRes'].forEach((v) {
          staticPageRes!.add(StaticPageRes.fromJson(v));
        });
      }
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (page != null) {
      data['page'] = page!.toJson();
    }
    data['pageId'] = pageId;
    data['confirm'] = confirm;
    data['allowSkip'] = allowSkip;
    data['prePageEnable'] = prePageEnable;
    data['prvPageId'] = prvPageId;
    data['prvPageName'] = prvPageName;
    data['pageCategory'] = pageCategory;
    data['profileId'] = profileId;
    data['product'] = product;
    if (staticPageRes != null) {
      data['staticPageRes'] = staticPageRes!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (loiSummary != null) {
      data['loiSummary'] = loiSummary!.toJson();
    }
    if (digioKycResponse != null) {
      data['digioToken'] = digioKycResponse!.toJson();
    }
    if (processingFee != null) {
      data['processingFee'] = processingFee!.toJson();
    }
    return data;
  }

  OnboardingStepsPayload copyWith({
    StepsPage? page,
    String? pageId,
    bool? confirm,
    bool? allowSkip,
    bool? prePageEnable,
    String? prvPageId,
    String? prvPageName,
    String? pageCategory,
    String? profileId,
    String? product,
  }) {
    return OnboardingStepsPayload(
      page: page ?? this.page,
      pageId: pageId ?? this.pageId,
      confirm: confirm ?? this.confirm,
      allowSkip: allowSkip ?? this.allowSkip,
      prePageEnable: prePageEnable ?? this.prePageEnable,
      prvPageId: prvPageId ?? this.prvPageId,
      prvPageName: prvPageName ?? this.prvPageName,
      pageCategory: pageCategory ?? this.pageCategory,
      profileId: profileId ?? this.profileId,
      product: product ?? this.product,
    );
  }
}

class StepsPage {
  String? id;
  String? code;
  Heading? heading;
  String? type;
  String? name;
  List<Fields>? fields;
  String? status;
  String? category;

  StepsPage({
    this.id,
    this.code,
    this.heading,
    this.type,
    this.name,
    this.fields,
    this.status,
    this.category,
  });

  StepsPage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    heading =
        json['heading'] != null ? Heading.fromJson(json['heading']) : null;
    type = json['type'];
    name = json['name'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
    status = json['status'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    if (heading != null) {
      data['heading'] = heading!.toJson();
    }
    data['type'] = type;
    data['name'] = name;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['category'] = category;
    return data;
  }

  StepsPage copyWith({
    String? id,
    String? code,
    Heading? heading,
    String? type,
    String? name,
    List<Fields>? fields,
    String? status,
    String? category,
  }) {
    return StepsPage(
      id: id ?? this.id,
      code: code ?? this.code,
      heading: heading ?? this.heading,
      type: type ?? this.type,
      name: name ?? this.name,
      fields: fields ?? this.fields,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }
}

class Heading {
  String? title;
  String? subTitle;
  String? pageLogo;
  String? appLogo;

  Heading({this.title, this.subTitle, this.pageLogo, this.appLogo});

  Heading.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    pageLogo = json['pageLogo'];
    appLogo = json["appLogo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['pageLogo'] = pageLogo;
    data["appLogo"] = appLogo;
    return data;
  }

  Heading copyWith({String? title, String? subTitle, String? pageLogo}) {
    return Heading(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      pageLogo: pageLogo ?? this.pageLogo,
    );
  }
}

class Fields {
  String? id;
  String? fieldId;
  bool? mandatory;
  String? type;
  String? subType;
  bool? cloneable;
  String? name;
  String? label;
  String? placeholder;
  num? sequence;
  String? regex;
  String? regexMessage;
  List<Option>? option;
  List<Option>? filteredOption;
  num? docCount;
  num? minDocCount;
  bool? editable;
  bool? underwritingField;
  bool? globalField;
  TextEditingController? textEditingController;
  bool? checkboxValue;
  GlobalKey<FormFieldState<String>>? fieldKey;
  dynamic value;
  bool? readOnly;
  bool? hidden;

  Fields({
    this.id,
    this.fieldId,
    this.mandatory,
    this.type,
    this.subType,
    this.cloneable,
    this.name,
    this.label,
    this.placeholder,
    this.sequence,
    this.regex,
    this.regexMessage,
    this.option,
    this.filteredOption,
    this.docCount,
    this.minDocCount,
    this.editable,
    this.underwritingField,
    this.globalField,
    this.textEditingController,
    this.checkboxValue,
    this.value,
    this.readOnly,
    this.fieldKey,
    this.hidden,
  });

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldId = json['fieldId'];
    mandatory = json['mandatory'];
    type = json['type'];
    cloneable = json['cloneable'];
    name = json['name'];
    label = json['label'];
    placeholder = json['placeholder'];
    sequence = json['sequence'];
    regex = json['regex'];
    regexMessage = json['regexMessage'];
    if (json['option'] != null) {
      option = <Option>[];
      filteredOption = <Option>[];
      json['option'].forEach((v) {
        option!.add(Option.fromJson(v));
        filteredOption!.add(Option.fromJson(v));
      });
    }
    docCount = json['docCount'];
    minDocCount = json['minDocCount'];
    editable = json['editable'];
    underwritingField = json['underwritingField'];
    globalField = json['globalField'];
    textEditingController = TextEditingController();
    checkboxValue = false;
    value = json['value'];
    subType = "";
    fieldKey = GlobalKey();
    readOnly = false;
    hidden = json['hidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fieldId'] = fieldId;
    data['mandatory'] = mandatory;
    data['type'] = type;
    data['cloneable'] = cloneable;
    data['name'] = name;
    data['label'] = label;
    data['placeholder'] = placeholder;
    data['sequence'] = sequence;
    data['regex'] = regex;
    data['regexMessage'] = regexMessage;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    data['docCount'] = docCount;
    data['minDocCount'] = minDocCount;
    data['editable'] = editable;
    data['underwritingField'] = underwritingField;
    data['globalField'] = globalField;
    data["value"] = value;
    data["subType"] = subType;
    data["readOnly"] = readOnly;
    data['hidden'] = hidden;
    return data;
  }

  Fields copyWith({
    String? id,
    String? fieldId,
    bool? mandatory,
    String? type,
    String? subType,
    bool? cloneable,
    String? name,
    String? label,
    String? placeholder,
    num? sequence,
    String? regex,
    String? regexMessage,
    List<Option>? option,
    List<Option>? filteredOption,
    num? docCount,
    num? minDocCount,
    bool? editable,
    bool? underwritingField,
    bool? globalField,
    TextEditingController? textEditingController,
    bool? checkboxValue,
    dynamic value,
    bool? readOnly,
    GlobalKey<FormFieldState<String>>? fieldKey,
  }) {
    return Fields(
      id: id ?? this.id,
      fieldId: fieldId ?? this.fieldId,
      mandatory: mandatory ?? this.mandatory,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      cloneable: cloneable ?? this.cloneable,
      name: name ?? this.name,
      label: label ?? this.label,
      placeholder: placeholder ?? this.placeholder,
      sequence: sequence ?? this.sequence,
      regex: regex ?? this.regex,
      regexMessage: regexMessage ?? this.regexMessage,
      option: option ?? this.option,
      docCount: docCount ?? this.docCount,
      minDocCount: minDocCount ?? this.minDocCount,
      editable: editable ?? this.editable,
      underwritingField: underwritingField ?? this.underwritingField,
      globalField: globalField ?? this.globalField,
      textEditingController:
          textEditingController ?? this.textEditingController,
      checkboxValue: checkboxValue ?? this.checkboxValue,
      value: value ?? this.value,
      readOnly: readOnly ?? this.readOnly,
      fieldKey: fieldKey ?? this.fieldKey,
      filteredOption: filteredOption ?? this.filteredOption,
    );
  }
}

class Option {
  String? name;
  String? value;

  Option({this.name, this.value});

  Option.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = {};
    data['name'] = name ?? "";
    data['value'] = value ?? "";
    return data;
  }

  Option copyWith({String? name, String? value}) {
    return Option(name: name ?? this.name, value: value ?? this.value);
  }
}

class Meta {
  String? gst;
  String? pan;
  String? mobile;

  Meta({this.gst, this.pan, this.mobile});

  Meta.fromJson(Map<String, dynamic> json) {
    gst = json['gst'];
    pan = json['pan'];
    mobile = json["mobile"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gst'] = gst;
    data['pan'] = pan;
    data["mobile"] = mobile;
    return data;
  }
}

class StaticPageRes {
  dynamic id;
  String? aadharNumber;
  String? email;
  String? gender;
  String? mobile;
  String? name;
  String? pan;
  Address? address;
  Address? permanentAddress;
  bool? isSameAsCurrentAddress;
  String? url;
  String? userId;
  String? relativeUrl;
  String? residence;
  dynamic dob;
  num? tenure;
  num? roi;
  num? emiAmt;
  num? interest;
  num? totalAmount;
  num? amount;
  Weekly? weekly;

  StaticPageRes({
    this.id,
    this.aadharNumber,
    this.email,
    this.gender,
    this.mobile,
    this.name,
    this.pan,
    this.address,
    this.permanentAddress,
    this.isSameAsCurrentAddress,
    this.url,
    this.userId,
    this.relativeUrl,
    this.residence,
    this.dob,
    this.tenure,
    this.roi,
    this.emiAmt,
    this.interest,
    this.totalAmount,
    this.amount,
    this.weekly,
  });

  StaticPageRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aadharNumber = json['aadharNumber'];
    email = json['email'];
    gender = json['gender'];
    mobile = json['mobile'];
    name = json['name'];
    pan = json['pan'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    permanentAddress = json['permanentAddress'] != null
        ? Address.fromJson(json['permanentAddress'])
        : null;
    isSameAsCurrentAddress = json['isSameAsCurrentAddress'];
    url = json["url"];
    userId = json["userId"];
    relativeUrl = json["relativeUrl"];
    residence = json["residence"];
    dob = json["dob"];
    tenure = json["tenure"];
    roi = json["roi"];
    emiAmt = json["emiAmt"];
    interest = json["interest"];
    totalAmount = json["totalAmount"];
    amount = json["amount"];
    weekly = json["weekly"] == null ? null : Weekly.fromJson(json["weekly"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aadharNumber'] = aadharNumber;
    data['email'] = email;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['name'] = name;
    data['pan'] = pan;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (permanentAddress != null) {
      data['permanentAddress'] = permanentAddress!.toJson();
    }
    data['isSameAsCurrentAddress'] = isSameAsCurrentAddress;
    data["url"] = url;
    data["userId"] = userId;
    data["relativeUrl"] = relativeUrl;
    data["residence"] = residence;
    data["dob"] = dob;
    if (weekly != null) {
      data["weekly"] = weekly!.toJson();
    }
    return data;
  }
}

class Weekly {
  num? tenure;
  num? emiAmount;
  num? interest;
  num? totalAmount;

  Weekly({this.tenure, this.emiAmount, this.interest, this.totalAmount});

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
        tenure: json["tenure"],
        emiAmount: json["emiAmount"],
        interest: json["interest"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "tenure": tenure,
        "emiAmount": emiAmount,
        "interest": interest,
        "totalAmount": totalAmount,
      };
}

class LoiSummary {
  String? id;
  String? lenderId;
  String? lenderName;
  String? lenderAddress;
  String? borrowerName;
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
  bool? disableAutoDebit;
  bool? dailyDeduction;
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
  List<String>? repayFrequencies;
  String? businessType;
  String? businessCategory;

  LoiSummary({
    this.id,
    this.lenderId,
    this.lenderName,
    this.lenderAddress,
    this.borrowerName,
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
    this.disableAutoDebit,
    this.dailyDeduction,
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
    this.repayFrequencies,
    this.businessType,
    this.businessCategory,
  });

  LoiSummary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lenderId = json['lenderId'];
    lenderName = json['lenderName'];
    lenderAddress = json['lenderAddress'];
    borrowerName = json['borrowerName'];
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
    disableAutoDebit = json['disableAutoDebit'];
    dailyDeduction = json['dailyDeduction'];
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
    businessCategory = json['businessCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lenderId'] = lenderId;
    data['lenderName'] = lenderName;
    data['lenderAddress'] = lenderAddress;
    data['borrowerName'] = borrowerName;
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
    data['disableAutoDebit'] = disableAutoDebit;
    data['dailyDeduction'] = dailyDeduction;
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
    data['repayFrequencies'] = repayFrequencies;
    data['businessType'] = businessType;
    data['businessCategory'] = businessCategory;
    return data;
  }
}

class ProcessingFeeData {
  num? creditLimit;
  num? processingFee;
  num? totalPayable;
  num? gstAmount;
  num? gst;
  num? emiAmt;
  bool? enablePayNow;
  String? description;
  PgOrderRequest? pgOrderRequest;
  bool? pgEnable;
  int? tenure;
  String? tenureType;

  ProcessingFeeData({
    this.creditLimit,
    this.processingFee,
    this.totalPayable,
    this.gstAmount,
    this.gst,
    this.emiAmt,
    this.enablePayNow,
    this.description,
    this.pgOrderRequest,
    this.pgEnable,
    this.tenure,
    this.tenureType,
  });

  ProcessingFeeData.fromJson(Map<String, dynamic> json) {
    creditLimit = json['creditLimit'];
    processingFee = json['processingFee'];
    totalPayable = json['totalPayable'];
    gstAmount = json['gstAmount'];
    gst = json['gst'];
    emiAmt = json["emiAmt"];
    enablePayNow = json['enablePayNow'];
    description = json['description'];
    pgOrderRequest = json['pgOrderRequest'] != null
        ? PgOrderRequest.fromJson(json['pgOrderRequest'])
        : null;
    pgEnable = json['pgEnable'];
    tenure = json["tenure"];
    tenureType = json["tenureType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creditLimit'] = creditLimit;
    data['processingFee'] = processingFee;
    data['totalPayable'] = totalPayable;
    data['gstAmount'] = gstAmount;
    data['gst'] = gst;
    data["emiAmt"] = emiAmt;
    data['enablePayNow'] = enablePayNow;
    data['description'] = description;
    if (pgOrderRequest != null) {
      data['pgOrderRequest'] = pgOrderRequest!.toJson();
    }
    data['tenure'] = tenure;
    data['tenureType'] = tenureType;
    return data;
  }
}

class PgOrderRequest {
  String? userId;
  String? paymentType;
  num? amount;
  String? lenderId;
  bool? paymentInProgress;

  PgOrderRequest({
    this.userId,
    this.paymentType,
    this.amount,
    this.lenderId,
    this.paymentInProgress,
  });

  PgOrderRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    paymentType = json['paymentType'];
    amount = json['amount'];
    lenderId = json['lenderId'];
    paymentInProgress = json['paymentInProgress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['paymentType'] = paymentType;
    data['amount'] = amount;
    data['lenderId'] = lenderId;
    data['paymentInProgress'] = paymentInProgress;
    return data;
  }
}

class DigioKycResponse {
  String? id;
  String? entityId;
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

  DigioKycResponse({
    this.id,
    this.entityId,
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
    this.templateId,
  });

  DigioKycResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entity_id'];
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
    data['id'] = id;
    data['entity_id'] = entityId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['customer_identifier'] = customerIdentifier;
    data['reference_id'] = referenceId;
    data['transaction_id'] = transactionId;
    data['customer_name'] = customerName;
    data['expire_in_days'] = expireInDays;
    data['reminder_registered'] = reminderRegistered;
    if (accessToken != null) {
      data['access_token'] = accessToken!.toJson();
    }
    data['workflow_name'] = workflowName;
    data['auto_approved'] = autoApproved;
    data['template_id'] = templateId;
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
    data['id'] = id;
    data['entity_id'] = entityId;
    data['valid_till'] = validTill;
    data['created_at'] = createdAt;
    return data;
  }
}
