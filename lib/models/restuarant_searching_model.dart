// To parse this JSON data, do
//
//     final restuarantSearching = restuarantSearchingFromJson(jsonString);

import 'dart:convert';

RestuarantSearching restuarantSearchingFromJson(String str) => RestuarantSearching.fromJson(json.decode(str));

String restuarantSearchingToJson(RestuarantSearching data) => json.encode(data.toJson());

class RestuarantSearching {
  RestuarantSearching({
    this.status,
    this.data,
    this.pdata,
  });

  bool? status;
  List<Restuarants>? data;
  List<Products>? pdata;

  factory RestuarantSearching.fromJson(Map<String, dynamic> json) => RestuarantSearching(
        status: json["status"],
        data: json["data"] == null ? null : List<Restuarants>.from(json["data"].map((x) => Restuarants.fromJson(x))),
        pdata: json["pdata"] == null ? null : List<Products>.from(json["pdata"].map((x) => Products.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pdata": pdata == null ? null : List<dynamic>.from(pdata!.map((x) => x.toJson())),
      };
}

class Restuarants {
  Restuarants({
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
    this.text,
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
  String? text;

  factory Restuarants.fromJson(Map<String, dynamic> json) => Restuarants(
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
        text: json["text"],
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
        "text": text,
      };
}

class Products {
  Products({
    this.id,
    this.shopId,
    this.categoryId,
    this.productName,
    this.priceDetails,
    this.imageThumb,
    this.imageLargeDetails,
    this.description,
    this.status,
  });

  String? id;
  String? shopId;
  String? categoryId;
  String? productName;
  List<PriceDetail>? priceDetails;
  dynamic imageThumb;
  String? imageLargeDetails;
  String? description;
  String? status;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        shopId: json["shop_id"],
        categoryId: json["category_id"],
        productName: json["product_name"],
        priceDetails: json["price_details"] == null ? null : List<PriceDetail>.from(json["price_details"].map((x) => PriceDetail.fromJson(x))),
        imageThumb: json["image_thumb"],
        imageLargeDetails: json["image_large_details"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "category_id": categoryId,
        "product_name": productName,
        "price_details": priceDetails == null ? null : List<dynamic>.from(priceDetails!.map((x) => x.toJson())),
        "image_thumb": imageThumb,
        "image_large_details": imageLargeDetails,
        "description": description,
        "status": status,
      };
}

class PriceDetail {
  PriceDetail({
    this.productType,
    this.productPrice,
    this.productDiscount,
    this.availableStock,
    this.tasayaCommission,
    this.discountPrice,
  });

  String? productType;
  String? productPrice;
  dynamic productDiscount;
  dynamic availableStock;
  dynamic tasayaCommission;
  int? discountPrice;

  factory PriceDetail.fromJson(Map<String, dynamic> json) => PriceDetail(
        productType: json["product_type"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        availableStock: json["available_stock"],
        tasayaCommission: json["tasaya_commission"],
        discountPrice: json["discount_price"],
      );

  Map<String, dynamic> toJson() => {
        "product_type": productType,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "available_stock": availableStock,
        "tasaya_commission": tasayaCommission,
        "discount_price": discountPrice,
      };
}
