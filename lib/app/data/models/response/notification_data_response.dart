import 'dart:convert';

NotificationDataResponse notificationDataResponseFromJson(String str) =>
    NotificationDataResponse.fromJson(json.decode(str));

String notificationDataResponseToJson(NotificationDataResponse data) =>
    json.encode(data.toJson());

class NotificationDataResponse {
  String? id;
  String? billId;
  String? title;
  String? subtitle;
  String? imageUrl;
  String? type;
  String? param;
  String? workFlowName;
  String? sessionId;
  String? invoiceId;
  String? profileId;

  NotificationDataResponse({
    this.id,
    this.billId,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.type,
    this.param,
    this.workFlowName,
    this.sessionId,
    this.invoiceId,
    this.profileId,
  });

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      NotificationDataResponse(
        id: json["id"],
        billId: json["billId"],
        title: json["title"],
        subtitle: json["subtitle"],
        imageUrl: json["imageUrl"],
        type: json["type"],
        param: json["param"],
        workFlowName: json["workFlowName"],
        sessionId: json["sessionId"],
        invoiceId: json["invoiceId"],
        profileId: json["profileId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "billId": billId,
        "title": title,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "type": type,
        "param": param,
        "workFlowName": workFlowName,
        "sessionId": sessionId,
        "invoiceId": invoiceId,
        "profileId": profileId,
      };
}
