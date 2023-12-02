// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<NotificationData>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        status: json["status"],
        message: json["Message"],
        data: List<NotificationData>.from(json["Data"].map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationData {
  NotificationData({
    this.notiId,
    this.custId,
    this.notiTitle,
    this.notiDesc,
    this.notiTime,
    this.readStatus,
  });

  String? notiId;
  String? custId;
  String? notiTitle;
  String? notiDesc;
  String? notiTime;
  String? readStatus;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        notiId: json["noti_id"],
        custId: json["cust_id"],
        notiTitle: json["noti_title"],
        notiDesc: json["noti_desc"],
        notiTime: json["noti_time"],
        readStatus: json["read_status"],
      );

  Map<String, dynamic> toJson() => {
        "noti_id": notiId,
        "cust_id": custId,
        "noti_title": notiTitle,
        "noti_desc": notiDesc,
        "noti_time": notiTime,
        "read_status": readStatus,
      };
}
