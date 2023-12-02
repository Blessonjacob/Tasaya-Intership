// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    this.productinfo,
    this.subTotal,
    this.orderid,
    this.shopName,
    this.address,
    this.addressType,
    this.customerName,
    this.customerMobile,
    this.totalAmt,
    this.pMethod,
    this.status,
    this.orderDate,
    this.couponDiscount,
    this.timesloat,
    this.israted,
    this.adminAcceptStatus,
    this.dCharge,
    this.tax,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  List<Productinfo>? productinfo;
  int? subTotal;
  String? orderid;
  String? shopName;
  String? address;
  String? addressType;
  String? customerName;
  String? customerMobile;
  String? totalAmt;
  String? pMethod;
  String? status;
  String? orderDate;
  int? couponDiscount;
  String? timesloat;
  String? israted;
  String? adminAcceptStatus;
  int? dCharge;
  String? tax;
  String? responseCode;
  String? result;
  String? responseMsg;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
        productinfo: json["productinfo"] == null ? null : List<Productinfo>.from(json["productinfo"].map((x) => Productinfo.fromJson(x))),
        subTotal: json["Sub_total"],
        orderid: json["orderid"],
        shopName: json["shop_name"],
        address: json["address"],
        addressType: json["address_type"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        totalAmt: json["total_amt"],
        pMethod: json["p_method"],
        status: json["status"],
        orderDate: json["order_date"],
        couponDiscount: json["coupon_discount"],
        timesloat: json["timesloat"],
        israted: json["Israted"],
        adminAcceptStatus: json["admin_accept_status"],
        dCharge: json["d_charge"],
        tax: json["tax"],
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "productinfo": productinfo == null ? null : List<dynamic>.from(productinfo!.map((x) => x.toJson())),
        "Sub_total": subTotal,
        "orderid": orderid,
        "shop_name": shopName,
        "address": address,
        "address_type": addressType,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "total_amt": totalAmt,
        "p_method": pMethod,
        "status": status,
        "order_date": orderDate,
        "coupon_discount": couponDiscount,
        "timesloat": timesloat,
        "Israted": israted,
        "admin_accept_status": adminAcceptStatus,
        "d_charge": dCharge,
        "tax": tax,
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Productinfo {
  Productinfo({
    this.productName,
    this.productPrice,
    this.productWeight,
    this.productQty,
    this.productImage,
    this.discount,
  });

  String? productName;
  String? productPrice;
  String? productWeight;
  String? productQty;
  String? productImage;
  dynamic discount;

  factory Productinfo.fromJson(Map<String, dynamic> json) => Productinfo(
        productName: json["product_name"],
        productPrice: json["product_price"],
        productWeight: json["product_weight"],
        productQty: json["product_qty"],
        productImage: json["product_image"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_price": productPrice,
        "product_weight": productWeight,
        "product_qty": productQty,
        "product_image": productImage,
        "discount": discount,
      };
}
