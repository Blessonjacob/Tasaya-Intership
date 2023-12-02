// To parse this JSON data, do
//
//     final couponList = couponListFromJson(jsonString);

import 'dart:convert';

CouponList couponListFromJson(String str) => CouponList.fromJson(json.decode(str));

String couponListToJson(CouponList data) => json.encode(data.toJson());

class CouponList {
  CouponList({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Coupons>? data;

  factory CouponList.fromJson(Map<String, dynamic> json) => CouponList(
        status: json["status"],
        message: json["Message"],
        data: json["Data"] == null ? null : List<Coupons>.from(json["Data"].map((x) => Coupons.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Coupons {
  Coupons({
    this.couponId,
    this.name,
    this.description,
    this.discountPercentage,
    this.discountAmount,
    this.minumumTotal,
    this.couponCode,
    this.applyStatus,
  });

  String? couponId;
  String? name;
  String? description;
  String? discountPercentage;
  String? discountAmount;
  String? minumumTotal;
  String? couponCode;
  String? applyStatus;

  factory Coupons.fromJson(Map<String, dynamic> json) => Coupons(
        couponId: json["coupon_id"],
        name: json["name"],
        description: json["description"],
        discountPercentage: json["discount_percentage"],
        discountAmount: json["discount_amount"],
        minumumTotal: json["minumum_total"],
        couponCode: json["coupon_code"],
        applyStatus: json["apply_status"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId,
        "name": name,
        "description": description,
        "discount_percentage": discountPercentage,
        "discount_amount": discountAmount,
        "minumum_total": minumumTotal,
        "coupon_code": couponCode,
        "apply_status": applyStatus,
      };
}
