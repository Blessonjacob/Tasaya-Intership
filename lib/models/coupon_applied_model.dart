// To parse this JSON data, do
//
//     final couponApplied = couponAppliedFromJson(jsonString);

import 'dart:convert';

CouponApplied couponAppliedFromJson(String str) => CouponApplied.fromJson(json.decode(str));

String couponAppliedToJson(CouponApplied data) => json.encode(data.toJson());

class CouponApplied {
  CouponApplied({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory CouponApplied.fromJson(Map<String, dynamic> json) => CouponApplied(
        status: json["status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.couponPercentage,
    this.couponPrice,
    this.totalPrice,
  });

  String? couponPercentage;
  double? couponPrice;
  double? totalPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        couponPercentage: json["coupon_percentage"],
        couponPrice: json["coupon_price"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_percentage": couponPercentage,
        "coupon_price": couponPrice,
        "total_price": totalPrice,
      };
}
