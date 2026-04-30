// To parse this json? data, do
//
//     final paymentSdkResponse = paymentSdkResponseFromJson(jsonString);

import 'dart:convert';

PaymentSdkResponse paymentSdkResponseFromJson(String str) =>
    PaymentSdkResponse.fromJson(json.decode(str));

String paymentSdkResponseToJson(PaymentSdkResponse data) =>
    json.encode(data.toJson());

class PaymentSdkResponse {
  String? result;
  PaymentResponse? paymentResponse;

  PaymentSdkResponse({
    this.result,
    this.paymentResponse,
  });

  factory PaymentSdkResponse.fromJson(Map<String, dynamic>? json) =>
      PaymentSdkResponse(
        result: json?["result"],
        paymentResponse: json?["payment_response"] == null
            ? null
            : PaymentResponse.fromJson(
                json?["payment_response"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "payment_response": paymentResponse?.toJson(),
      };
}

class PaymentResponse {
  String? mUdf6;
  String? mUdf5;
  String? mUdf7;
  String? cardCategory;
  String? udf10;
  String? mCountry;
  String? mode;
  String? mState;
  String? mProductInfo;
  String? mCity;
  String? errorMessage;
  String? paymentSource;
  String? mUdf2;
  String? mUdf1;
  String? mUdf4;
  String? bankcode;
  String? txnid;
  String? mUdf3;
  String? surl;
  String? netAmountDebit;
  String? authCode;
  String? phone;
  String? errorCode;
  String? productinfo;
  String? hash;
  String? status;
  String? firstname;
  String? responseCode;
  num? flag;
  String? merchantLogo;
  String? mAddress1;
  String? error;
  DateTime? addedon;
  String? udf9;
  String? mAddress2;
  String? udf7;
  String? issuingBank;
  String? cashBackPercentage;
  String? udf8;
  String? deductionPercentage;
  String? bankName;
  String? bankRefNum;
  String? email;
  String? key;
  String? upiVa;
  String? mPhone;
  String? amount;
  String? unmappedstatus;
  String? easepayid;
  String? udf5;
  String? udf6;
  String? udf3;
  String? udf4;
  String? udf1;
  String? cardType;
  String? udf2;
  String? cardnum;
  String? mName;
  String? furl;
  String? pgType;
  String? nameOnCard;

  PaymentResponse({
    this.mUdf6,
    this.mUdf5,
    this.mUdf7,
    this.cardCategory,
    this.udf10,
    this.mCountry,
    this.mode,
    this.mState,
    this.mProductInfo,
    this.mCity,
    this.errorMessage,
    this.paymentSource,
    this.mUdf2,
    this.mUdf1,
    this.mUdf4,
    this.bankcode,
    this.txnid,
    this.mUdf3,
    this.surl,
    this.netAmountDebit,
    this.authCode,
    this.phone,
    this.errorCode,
    this.productinfo,
    this.hash,
    this.status,
    this.firstname,
    this.responseCode,
    this.flag,
    this.merchantLogo,
    this.mAddress1,
    this.error,
    this.addedon,
    this.udf9,
    this.mAddress2,
    this.udf7,
    this.issuingBank,
    this.cashBackPercentage,
    this.udf8,
    this.deductionPercentage,
    this.bankName,
    this.bankRefNum,
    this.email,
    this.key,
    this.upiVa,
    this.mPhone,
    this.amount,
    this.unmappedstatus,
    this.easepayid,
    this.udf5,
    this.udf6,
    this.udf3,
    this.udf4,
    this.udf1,
    this.cardType,
    this.udf2,
    this.cardnum,
    this.mName,
    this.furl,
    this.pgType,
    this.nameOnCard,
  });

  factory PaymentResponse.fromJson(Map<dynamic, dynamic>? json) =>
      PaymentResponse(
        mUdf6: json?["m_udf6"],
        mUdf5: json?["m_udf5"],
        mUdf7: json?["m_udf7"],
        cardCategory: json?["cardCategory"],
        udf10: json?["udf10"],
        mCountry: json?["m_country"],
        mode: json?["mode"],
        mState: json?["m_state"],
        mProductInfo: json?["m_product_info"],
        mCity: json?["m_city"],
        errorMessage: json?["error_Message"],
        paymentSource: json?["payment_source"],
        mUdf2: json?["m_udf2"],
        mUdf1: json?["m_udf1"],
        mUdf4: json?["m_udf4"],
        bankcode: json?["bankcode"],
        txnid: json?["txnid"],
        mUdf3: json?["m_udf3"],
        surl: json?["surl"],
        netAmountDebit: json?["net_amount_debit"],
        authCode: json?["auth_code"],
        phone: json?["phone"],
        errorCode: json?["error_code"],
        productinfo: json?["productinfo"],
        hash: json?["hash"],
        status: json?["status"],
        firstname: json?["firstname"],
        responseCode: json?["response_code"],
        flag: json?["flag"],
        merchantLogo: json?["merchant_logo"],
        mAddress1: json?["m_address1"],
        error: json?["error"],
        addedon:
            json?["addedon"] == null ? null : DateTime.parse(json?["addedon"]),
        udf9: json?["udf9"],
        mAddress2: json?["m_address2"],
        udf7: json?["udf7"],
        issuingBank: json?["issuing_bank"],
        cashBackPercentage: json?["cash_back_percentage"],
        udf8: json?["udf8"],
        deductionPercentage: json?["deduction_percentage"],
        bankName: json?["bank_name"],
        bankRefNum: json?["bank_ref_num"],
        email: json?["email"],
        key: json?["key"],
        upiVa: json?["upi_va"],
        mPhone: json?["m_phone"],
        amount: json?["amount"],
        unmappedstatus: json?["unmappedstatus"],
        easepayid: json?["easepayid"],
        udf5: json?["udf5"],
        udf6: json?["udf6"],
        udf3: json?["udf3"],
        udf4: json?["udf4"],
        udf1: json?["udf1"],
        cardType: json?["card_type"],
        udf2: json?["udf2"],
        cardnum: json?["cardnum"],
        mName: json?["m_name"],
        furl: json?["furl"],
        pgType: json?["PG_TYPE"],
        nameOnCard: json?["name_on_card"],
      );

  Map<String, dynamic> toJson() => {
        "m_udf6": mUdf6,
        "m_udf5": mUdf5,
        "m_udf7": mUdf7,
        "cardCategory": cardCategory,
        "udf10": udf10,
        "m_country": mCountry,
        "mode": mode,
        "m_state": mState,
        "m_product_info": mProductInfo,
        "m_city": mCity,
        "error_Message": errorMessage,
        "payment_source": paymentSource,
        "m_udf2": mUdf2,
        "m_udf1": mUdf1,
        "m_udf4": mUdf4,
        "bankcode": bankcode,
        "txnid": txnid,
        "m_udf3": mUdf3,
        "surl": surl,
        "net_amount_debit": netAmountDebit,
        "auth_code": authCode,
        "phone": phone,
        "error_code": errorCode,
        "productinfo": productinfo,
        "hash": hash,
        "status": status,
        "firstname": firstname,
        "response_code": responseCode,
        "flag": flag,
        "merchant_logo": merchantLogo,
        "m_address1": mAddress1,
        "error": error,
        "addedon": addedon?.toIso8601String(),
        "udf9": udf9,
        "m_address2": mAddress2,
        "udf7": udf7,
        "issuing_bank": issuingBank,
        "cash_back_percentage": cashBackPercentage,
        "udf8": udf8,
        "deduction_percentage": deductionPercentage,
        "bank_name": bankName,
        "bank_ref_num": bankRefNum,
        "email": email,
        "key": key,
        "upi_va": upiVa,
        "m_phone": mPhone,
        "amount": amount,
        "unmappedstatus": unmappedstatus,
        "easepayid": easepayid,
        "udf5": udf5,
        "udf6": udf6,
        "udf3": udf3,
        "udf4": udf4,
        "udf1": udf1,
        "card_type": cardType,
        "udf2": udf2,
        "cardnum": cardnum,
        "m_name": mName,
        "furl": furl,
        "PG_TYPE": pgType,
        "name_on_card": nameOnCard,
      };
}
