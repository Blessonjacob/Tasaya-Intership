import 'dart:convert';

import 'package:hive/hive.dart';

part 'products_model.g.dart';

@HiveType(typeId: 1)
class Pname extends HiveObject {
  Pname({
    this.title,
    this.pid,
    this.weight,
    this.cost = 0,
    this.shopId,
    this.qty = 0,
    this.image,
  });
  @HiveField(0)
  String? title;
  @HiveField(1)
  int? pid;
  @HiveField(2)
  String? weight;
  @HiveField(3)
  int cost;
  @HiveField(4)
  int? shopId;
  @HiveField(5)
  int qty;
  @HiveField(6)
  String? image;

  factory Pname.fromJson(Map<String, dynamic> json) => Pname(
        title: json["title"],
        pid: json["pid"],
        weight: json["weight"],
        cost: json["cost"],
        shopId: json["shop_id"],
        qty: json["qty"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "pid": pid,
        "weight": weight,
        "cost": cost,
        "shop_id": shopId,
        "qty": qty,
        "image": image,
      };
}

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);


Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String? title;
    int? pid;
    String? weight;
    int? cost;
    int? shopId;
    int? qty;

    Product({
        this.title,
        this.pid,
        this.weight,
        this.cost,
        this.shopId,
        this.qty,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        pid: json["pid"],
        weight: json["weight"],
        cost: json["cost"],
        shopId: json["shop_id"],
        qty: json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "pid": pid,
        "weight": weight,
        "cost": cost,
        "shop_id": shopId,
        "qty": qty,
    };
}
