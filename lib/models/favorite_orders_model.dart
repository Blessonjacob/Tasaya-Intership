// To parse this JSON data, do
//
//     final favoriteOrders = favoriteOrdersFromJson(jsonString);

import 'dart:convert';

FavoriteOrders favoriteOrdersFromJson(String str) => FavoriteOrders.fromJson(json.decode(str));

String favoriteOrdersToJson(FavoriteOrders data) => json.encode(data.toJson());

class FavoriteOrders {
  FavoriteOrders({
    this.data,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  List<FavOrderData>? data;
  String? responseCode;
  String? result;
  String? responseMsg;

  factory FavoriteOrders.fromJson(Map<String, dynamic> json) => FavoriteOrders(
        data: json["Data"] == null ? null : List<FavOrderData>.from(json["Data"].map((x) => FavOrderData.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class FavOrderData {
  FavOrderData({
    this.id,
    this.oid,
    this.status,
    this.orderDate,
    this.adminAcceptStatus,
    this.total,
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
  dynamic riderStatus;
  String? riderName;
  String? riderMobile;

  factory FavOrderData.fromJson(Map<String, dynamic> json) => FavOrderData(
        id: json["id"],
        oid: json["oid"],
        status: json["status"],
        orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
        adminAcceptStatus: json["admin_accept_status"],
        total: json["total"],
        riderStatus: json["rider_status"],
        riderName: json["rider_name"],
        riderMobile: json["rider_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "oid": oid,
        "status": status,
        "order_date": orderDate == null
            ? null
            : "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "admin_accept_status": adminAcceptStatus,
        "total": total,
        "rider_status": riderStatus,
        "rider_name": riderName,
        "rider_mobile": riderMobile,
      };
}
