// To parse this JSON data, do
//
//     final shopDetails = shopDetailsFromJson(jsonString);

import 'dart:convert';

ShopDetails shopDetailsFromJson(String str) => ShopDetails.fromJson(json.decode(str));

String shopDetailsToJson(ShopDetails data) => json.encode(data.toJson());

class ShopDetails {
  ShopDetails({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory ShopDetails.fromJson(Map<String, dynamic> json) => ShopDetails(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.shopDetails,
  });

  ShopDetailsClass? shopDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shopDetails: json["shop_details"] == null ? null : ShopDetailsClass.fromJson(json["shop_details"]),
      );

  Map<String, dynamic> toJson() => {
        "shop_details": shopDetails == null ? null : shopDetails!.toJson(),
      };
}

class ShopDetailsClass {
  ShopDetailsClass({
    this.shopId,
    this.vendorId,
    this.filterId,
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
    this.vendorName,
    this.rating,
    this.categories,
  });

  String? shopId;
  String? vendorId;
  String? filterId;
  String? shopName;
  String? ownerName;
  String? deliveryMode;
  String? tax;
  List<String>? shopBanners;
  String? deliveryCharge;
  String? shopTitle;
  String? address1;
  String? address2;
  String? pincode;
  String? mapAddress;
  String? shopImage;
  String? shopDescription;
  String? profileStatus;
  BankDetails? bankDetails;
  String? shopCategory;
  String? shopSubCategory;
  String? createDate;
  String? adminAproval;
  String? isPopular;
  String? storeStatus;
  String? delieveryStatus;
  String? vendorName;
  dynamic rating;
  List<Category>? categories;

  factory ShopDetailsClass.fromJson(Map<String, dynamic> json) => ShopDetailsClass(
        shopId: json["shop_id"],
        vendorId: json["vendor_id"],
        filterId: json["filter_id"],
        shopName: json["shop_name"],
        ownerName: json["owner_name"],
        deliveryMode: json["delivery_mode"],
        tax: json["tax"],
        shopBanners: json["shop_banners"] == null ? null : List<String>.from(json["shop_banners"].map((x) => x)),
        deliveryCharge: json["delivery_charge"],
        shopTitle: json["shop_title"],
        address1: json["address1"],
        address2: json["address2"],
        pincode: json["pincode"],
        mapAddress: json["map_address"],
        shopImage: json["shop_image"],
        shopDescription: json["shop_description"],
        profileStatus: json["profile_status"],
        bankDetails: json["bank_details"] == null ? null : BankDetails.fromJson(json["bank_details"]),
        shopCategory: json["shop_category"],
        shopSubCategory: json["shop_sub_category"],
        createDate: json["create_date"],
        adminAproval: json["admin_aproval"],
        isPopular: json["is_popular"],
        storeStatus: json["store_status"],
        delieveryStatus: json["delievery_status"],
        vendorName: json["vendor_name"],
        rating: json["rating"],
        categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shop_id": shopId,
        "vendor_id": vendorId,
        "filter_id": filterId,
        "shop_name": shopName,
        "owner_name": ownerName,
        "delivery_mode": deliveryMode,
        "tax": tax,
        "shop_banners": shopBanners == null ? null : List<dynamic>.from(shopBanners!.map((x) => x)),
        "delivery_charge": deliveryCharge,
        "shop_title": shopTitle,
        "address1": address1,
        "address2": address2,
        "pincode": pincode,
        "map_address": mapAddress,
        "shop_image": shopImage,
        "shop_description": shopDescription,
        "profile_status": profileStatus,
        "bank_details": bankDetails == null ? null : bankDetails!.toJson(),
        "shop_category": shopCategory,
        "shop_sub_category": shopSubCategory,
        "create_date": createDate,
        "admin_aproval": adminAproval,
        "is_popular": isPopular,
        "store_status": storeStatus,
        "delievery_status": delieveryStatus,
        "vendor_name": vendorName,
        "rating": rating,
        "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class BankDetails {
  BankDetails({
    this.accountHolderName,
    this.accountNumber,
    this.varifyAccountNumber,
    this.ifscCode,
    this.registeredMobileNumber,
  });

  String? accountHolderName;
  String? accountNumber;
  String? varifyAccountNumber;
  String? ifscCode;
  String? registeredMobileNumber;

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        varifyAccountNumber: json["varify_account_number"],
        ifscCode: json["ifsc_code"],
        registeredMobileNumber: json["registered_mobile_number"],
      );

  Map<String, dynamic> toJson() => {
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "varify_account_number": varifyAccountNumber,
        "ifsc_code": ifscCode,
        "registered_mobile_number": registeredMobileNumber,
      };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.catImage,
    this.products,
  });

  dynamic categoryId;
  String? categoryName;
  String? catImage;
  List<Product>? products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        catImage: json["cat_image"],
        products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "cat_image": catImage,
        "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.productId,
    this.shopId,
    this.productName,
    this.categoryId,
    this.price,
    this.image,
    this.shopName,
    this.tax,
    this.deliveryCharge,
  });

  String? productId;
  String? shopId;
  String? productName;
  String? categoryId;
  List<Price>? price;
  String? image;
  String? shopName;
  String? tax;
  String? deliveryCharge;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        shopId: json["shop_id"],
        productName: json["product_name"],
        categoryId: json["category_id"],
        price: json["price"] == null ? null : List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
        image: json["image"],
        shopName: json["shop_name"],
        tax: json["tax"],
        deliveryCharge: json["delivery_charge"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "shop_id": shopId,
        "product_name": productName,
        "category_id": categoryId,
        "price": price == null ? null : List<dynamic>.from(price!.map((x) => x.toJson())),
        "image": image,
        "shop_name": shopName,
        "tax": tax,
        "delivery_charge": deliveryCharge,
      };
}

class Price {
  Price({
    this.productType,
    this.productPrice,
    this.productDiscount,
    this.tasayaCommission,
    this.availableStock,
    this.discountPrice,
  });

  String? productType;
  String? productPrice;
  dynamic productDiscount;
  dynamic tasayaCommission;
  dynamic availableStock;
  int? discountPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        productType: json["product_type"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        tasayaCommission: json["tasaya_commission"],
        availableStock: json["available_stock"],
        discountPrice: json["discount_price"],
      );

  Map<String, dynamic> toJson() => {
        "product_type": productType,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "tasaya_commission": tasayaCommission,
        "available_stock": availableStock,
        "discount_price": discountPrice,
      };
}
