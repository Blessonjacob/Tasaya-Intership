// To parse this JSON data, do
//
//     final serviceOrder = serviceOrderFromJson(jsonString);

import 'dart:convert';

ServiceOrder serviceOrderFromJson(String str) => ServiceOrder.fromJson(json.decode(str));

String serviceOrderToJson(ServiceOrder data) => json.encode(data.toJson());

String bookserviceToJson(Order data) => json.encode(data.toJson());

class ServiceOrder {
  ServiceOrder({
    this.responseCode,
    this.responseMessage,
    this.status,
    this.order,
  });

  int? responseCode;
  String? responseMessage;
  bool? status;
  Order? order;

  factory ServiceOrder.fromJson(Map<String, dynamic> json) => ServiceOrder(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        status: json["status"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "status": status,
        "order": order?.toJson(),
      };
}

class Order {
  Order({
    this.user,
    this.orderItems,
    this.shippingAddress,
    this.paymentMethod,
    this.paymentResult,
    this.totalPrice,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  User? user;
  List<OrderItem>? orderItems;
  ShippingAddress? shippingAddress;
  String? paymentMethod;
  PaymentResult? paymentResult;
  int? totalPrice;
  bool? isPaid;
  DateTime? paidAt;
  bool? isDelivered;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        orderItems: json["orderItems"] == null ? [] : List<OrderItem>.from(json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
        shippingAddress: json["shippingAddress"] == null ? null : ShippingAddress.fromJson(json["shippingAddress"]),
        paymentMethod: json["paymentMethod"],
        paymentResult: json["paymentResult"] == null ? null : PaymentResult.fromJson(json["paymentResult"]),
        totalPrice: json["totalPrice"],
        isPaid: json["isPaid"],
        paidAt: json["paidAt"] == null ? null : DateTime.parse(json["paidAt"]),
        isDelivered: json["isDelivered"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "orderItems": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "shippingAddress": shippingAddress?.toJson(),
        "paymentMethod": paymentMethod,
        "paymentResult": paymentResult?.toJson(),
        "totalPrice": totalPrice,
        "isPaid": isPaid,
        "paidAt": paidAt?.toIso8601String(),
        "isDelivered": isDelivered,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class OrderItem {
  OrderItem({
    this.name,
    this.image,
    this.price,
    this.product,
    this.id,
  });

  String? name;
  String? image;
  String? price;
  String? product;
  String? id;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        image: json["image"],
        price: json["price"],
        product: json["product"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "price": price,
        "product": product,
        "_id": id,
      };
}

class PaymentResult {
  PaymentResult({
    this.id,
    this.status,
    this.updateTime,
    this.emailAddress,
  });

  String? id;
  String? status;
  String? updateTime;
  String? emailAddress;

  factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        id: json["id"],
        status: json["status"],
        updateTime: json["update_time"],
        emailAddress: json["email_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "update_time": updateTime,
        "email_address": emailAddress,
      };
}

class ShippingAddress {
  ShippingAddress({
    this.addressLine,
    this.latitude,
    this.longitude,
  });

  String? addressLine;
  double? latitude;
  double? longitude;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
        addressLine: json["addressLine"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "addressLine": addressLine,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class User {
  User({
    this.customerId,
    this.name,
  });

  String? customerId;
  String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        customerId: json["customer_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "name": name,
      };
}
