// To parse this JSON data, do
//
//     final restuarantList = restuarantListFromJson(jsonString);

import 'dart:convert';

RestuarantList restuarantListFromJson(String str) =>
    RestuarantList.fromJson(json.decode(str));

String restuarantListToJson(RestuarantList data) => json.encode(data.toJson());

class RestuarantList {
  RestuarantList({
    this.status,
    this.data,
  });

  bool? status;
  List<Datum>? data;

  factory RestuarantList.fromJson(Map<String, dynamic> json) => RestuarantList(
        status: json["status"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.shopId,
    this.vendorId,
    this.filterId,
    this.filterDetails,
    this.shopName,
    this.ownerName,
    this.deliveryMode,
    this.tax,
    this.shopBanners,
    this.deliveryCharge,
    this.shopTitle,
    this.address1,
    this.address2,
    this.pincode,
    this.mapAddress,
    this.shopImage,
    this.shopDescription,
    this.profileStatus,
    this.bankDetails,
    this.shopCategory,
    this.shopSubCategory,
    this.createDate,
    this.adminAproval,
    this.isPopular,
    this.storeStatus,
    this.delieveryStatus,
  });

  String? shopId;
  String? vendorId;
  String? filterId;
  String? filterDetails;
  String? shopName;
  String? ownerName;
  String? deliveryMode;
  String? tax;
  String? shopBanners;
  String? deliveryCharge;
  String? shopTitle;
  String? address1;
  String? address2;
  String? pincode;
  String? mapAddress;
  String? shopImage;
  String? shopDescription;
  String? profileStatus;
  String? bankDetails;
  String? shopCategory;
  String? shopSubCategory;
  String? createDate;
  String? adminAproval;
  String? isPopular;
  String? storeStatus;
  String? delieveryStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        shopId: json["shop_id"],
        vendorId: json["vendor_id"],
        filterId: json["filter_id"],
        filterDetails: json["filter_details"],
        shopName: json["shop_name"],
        ownerName: json["owner_name"],
        deliveryMode: json["delivery_mode"],
        tax: json["tax"],
        shopBanners: json["shop_banners"],
        deliveryCharge: json["delivery_charge"],
        shopTitle: json["shop_title"],
        address1: json["address1"],
        address2: json["address2"],
        pincode: json["pincode"],
        mapAddress: json["map_address"],
        shopImage: json["shop_image"],
        shopDescription: json["shop_description"],
        profileStatus: json["profile_status"],
        bankDetails: json["bank_details"],
        shopCategory: json["shop_category"],
        shopSubCategory: json["shop_sub_category"],
        createDate: json["create_date"],
        adminAproval: json["admin_aproval"],
        isPopular: json["is_popular"],
        storeStatus: json["store_status"],
        delieveryStatus: json["delievery_status"],
      );

  Map<String, dynamic> toJson() => {
        "shop_id": shopId,
        "vendor_id": vendorId,
        "filter_id": filterId,
        "filter_details": filterDetails,
        "shop_name": shopName,
        "owner_name": ownerName,
        "delivery_mode": deliveryMode,
        "tax": tax,
        "shop_banners": shopBanners,
        "delivery_charge": deliveryCharge,
        "shop_title": shopTitle,
        "address1": address1,
        "address2": address2,
        "pincode": pincode,
        "map_address": mapAddress,
        "shop_image": shopImage,
        "shop_description": shopDescription,
        "profile_status": profileStatus,
        "bank_details": bankDetails,
        "shop_category": shopCategory,
        "shop_sub_category": shopSubCategory,
        "create_date": createDate,
        "admin_aproval": adminAproval,
        "is_popular": isPopular,
        "store_status": storeStatus,
        "delievery_status": delieveryStatus,
      };
}
