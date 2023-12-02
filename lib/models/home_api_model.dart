// To parse this JSON data, do
//
//     final homeApi = homeApiFromJson(jsonString);

import 'dart:convert';

HomeApi homeApiFromJson(String str) => HomeApi.fromJson(json.decode(str));

String homeApiToJson(HomeApi data) => json.encode(data.toJson());

class HomeApi {
  HomeApi({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory HomeApi.fromJson(Map<String, dynamic> json) => HomeApi(
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
    this.popularCategories,
    this.brandShop,
    this.slider,
    this.offerBanner,
    this.popularShop,
    this.appTitle,
    this.currency,
    this.tax,
  });

  List<PopularCategory>? popularCategories;
  List<dynamic>? brandShop;
  List<Slider>? slider;
  List<OfferBanners>? offerBanner;
  List<dynamic>? popularShop;
  String? appTitle;
  String? currency;
  String? tax;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        popularCategories: json["popular_categories"] == null ? null : List<PopularCategory>.from(json["popular_categories"].map((x) => PopularCategory.fromJson(x))),
        brandShop: json["brand_shop"] == null ? null : List<dynamic>.from(json["brand_shop"].map((x) => x)),
        slider: json["slider"] == null ? null : List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
        offerBanner: json["offer_banner"] == null ? null : List<OfferBanners>.from(json["offer_banner"].map((x) => OfferBanners.fromJson(x))),
        popularShop: json["popular_shop"] == null ? null : List<dynamic>.from(json["popular_shop"].map((x) => x)),
        appTitle: json["app_title"],
        currency: json["currency"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "popular_categories": popularCategories == null ? null : List<dynamic>.from(popularCategories!.map((x) => x.toJson())),
        "brand_shop": brandShop == null ? null : List<dynamic>.from(brandShop!.map((x) => x)),
        "slider": slider == null ? null : List<dynamic>.from(slider!.map((x) => x.toJson())),
        "offer_banner": offerBanner == null ? null : List<dynamic>.from(offerBanner!.map((x) => x.toJson())),
        "popular_shop": popularShop == null ? null : List<dynamic>.from(popularShop!.map((x) => x)),
        "app_title": appTitle,
        "currency": currency,
        "tax": tax,
      };
}

class OfferBanners {
  OfferBanners({
    this.offerBannerId,
    this.offerImage,
    this.offerText,
    this.shopId,
    this.storeStatus,
  });

  String? offerBannerId;
  String? offerImage;
  String? offerText;
  String? shopId;
  String? storeStatus;

  factory OfferBanners.fromJson(Map<String, dynamic> json) => OfferBanners(
        offerBannerId: json["offer_banner_id"],
        offerImage: json["offer_image"],
        offerText: json["offer_text"],
        shopId: json["shop_id"],
        storeStatus: json["store_status"],
      );

  Map<String, dynamic> toJson() => {
        "offer_banner_id": offerBannerId,
        "offer_image": offerImage,
        "offer_text": offerText,
        "shop_id": shopId,
        "store_status": storeStatus,
      };
}

class PopularCategory {
  PopularCategory({
    this.categoryId,
    this.categoryName,
    this.catImage,
  });

  String? categoryId;
  String? categoryName;
  String? catImage;

  factory PopularCategory.fromJson(Map<String, dynamic> json) => PopularCategory(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        catImage: json["cat_image"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "cat_image": catImage,
      };
}

class Slider {
  Slider({
    this.sliderId,
    this.sliderImage,
  });

  String? sliderId;
  String? sliderImage;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        sliderId: json["slider_id"],
        sliderImage: json["slider_image"],
      );

  Map<String, dynamic> toJson() => {
        "slider_id": sliderId,
        "slider_image": sliderImage,
      };
}
