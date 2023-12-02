// To parse this JSON data, do
//
//     final orderHistory = orderHistoryFromJson(jsonString);

import 'dart:convert';

OrderHistory orderHistoryFromJson(String str) =>
    OrderHistory.fromJson(json.decode(str));

String orderHistoryToJson(OrderHistory data) => json.encode(data.toJson());

class OrderHistory {
  OrderHistory({
    this.data,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  List<OrderList>? data;
  String? responseCode;
  String? result;
  String? responseMsg;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        data: List<OrderList>.from(
            json["Data"].map((x) => OrderList.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class OrderList {
  OrderList({
    this.id,
    this.oid,
    this.status,
    this.orderDate,
    this.adminAcceptStatus,
    this.total,
    this.isInFavlist,
    this.riderStatus,
    this.riderName,
    this.riderMobile,
  });

  String? id;
  String? oid;
  String? status;
  DateTime? orderDate;
  String? adminAcceptStatus;
  String? total;
  int? isInFavlist;
  dynamic riderStatus;
  String? riderName;
  String? riderMobile;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        oid: json["oid"],
        status: json["status"],
        orderDate: DateTime.parse(json["order_date"]),
        adminAcceptStatus: json["admin_accept_status"],
        total: json["total"],
        isInFavlist: json["is_in_favlist"],
        riderStatus: json["rider_status"],
        riderName: json["rider_name"],
        riderMobile: json["rider_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "oid": oid,
        "status": status,
        "order_date":
            "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "admin_accept_status": adminAcceptStatus,
        "total": total,
        "is_in_favlist": isInFavlist,
        "rider_status": riderStatus,
        "rider_name": riderName,
        "rider_mobile": riderMobile,
      };
}
