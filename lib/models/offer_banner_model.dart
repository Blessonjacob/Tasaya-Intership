// To parse this JSON data, do
//
//     final offerBanner = offerBannerFromJson(jsonString);

import 'dart:convert';

OfferBanner offerBannerFromJson(String str) =>
    OfferBanner.fromJson(json.decode(str));

String offerBannerToJson(OfferBanner data) => json.encode(data.toJson());

class OfferBanner {
  OfferBanner({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Banners>? data;

  factory OfferBanner.fromJson(Map<String, dynamic> json) => OfferBanner(
        status: json["status"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : List<Banners>.from(json["Data"].map((x) => Banners.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Banners {
  Banners({
    this.offerBannerId,
    this.offerImage,
    this.offerText,
    this.shopId,
  });

  String? offerBannerId;
  String? offerImage;
  String? offerText;
  String? shopId;

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        offerBannerId: json["offer_banner_id"],
        offerImage: json["offer_image"],
        offerText: json["offer_text"],
        shopId: json["shop_id"],
      );

  Map<String, dynamic> toJson() => {
        "offer_banner_id": offerBannerId,
        "offer_image": offerImage,
        "offer_text": offerText,
        "shop_id": shopId,
      };
}
