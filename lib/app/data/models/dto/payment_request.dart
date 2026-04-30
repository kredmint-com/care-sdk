// import 'dart:convert';
//
// PaymentRequest paymentRequestFromJson(String str) =>
//     PaymentRequest.fromJson(json.decode(str));
//
// String paymentRequestToJson(PaymentRequest data) => json.encode(data.toJson());
//
// class PaymentRequest {
//   String? cn;
//   String? op;
//   String? opName;
//   String? cir;
//   String? originalAmt;
//   String? couponCode;
//   String? pvalue;
//   String? ad1;
//   String? ad2;
//   String? userId;
//   String? userBillId;
//   String? ty;
//   String? subTy;
//   Map<String, dynamic>? adParams;
//   BillData? billData;
//   String? kredCoins;
//   num? netPayableAmt;
//   num? couponDiscount;
//   String? billId;
//
//   PaymentRequest({
//     this.cn,
//     this.op,
//     this.opName,
//     this.cir,
//     this.originalAmt,
//     this.couponCode,
//     this.pvalue,
//     this.ad1,
//     this.ad2,
//     this.userId,
//     this.userBillId,
//     this.ty,
//     this.subTy,
//     this.adParams,
//     this.billData,
//     this.kredCoins,
//     this.netPayableAmt,
//     this.couponDiscount,
//     this.billId,
//   });
//
//   factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
//         cn: json["cn"],
//         op: json["op"],
//         opName: json["opName"],
//         cir: json["cir"],
//         originalAmt: json["originalAmt"],
//         couponCode: json["couponCode"],
//         pvalue: json["pvalue"],
//         ad1: json["ad1"],
//         ad2: json["ad2"],
//         userId: json["userId"],
//         userBillId: json["userBillId"],
//         ty: json["ty"],
//         subTy: json["subTy"],
//         adParams: json["adParams"],
//         billData: json["billData"] == null
//             ? null
//             : BillData.fromJson(json["billData"]),
//         kredCoins: json["kredCoins"],
//         netPayableAmt: json["netPayableAmt"],
//         couponDiscount: json["couponDiscount"],
//         billId: json["billId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "cn": cn,
//         "op": op,
//         "opName": opName,
//         "cir": cir,
//         "originalAmt": originalAmt,
//         "couponCode": couponCode,
//         "pvalue": pvalue,
//         "ad1": ad1,
//         "ad2": ad2,
//         "userId": userId,
//         "userBillId": userBillId,
//         "ty": ty,
//         "subTy": subTy,
//         "adParams": adParams,
//         "billData": billData?.toJson(),
//         "kredCoins": kredCoins,
//         "netPayableAmt": netPayableAmt,
//         "couponDiscount": couponDiscount,
//         "billId": billId,
//       };
// }
