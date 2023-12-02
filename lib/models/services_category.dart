// To parse this JSON data, do
//
//     final servicesCategory = servicesCategoryFromJson(jsonString);

import 'dart:convert';

ServicesCategory servicesCategoryFromJson(String str) => ServicesCategory.fromJson(json.decode(str));

String servicesCategoryToJson(ServicesCategory data) => json.encode(data.toJson());

class ServicesCategory {
    ServicesCategory({
        this.responseCode,
        this.responseMessage,
        this.status,
        this.categories,
        this.total,
    });

    int? responseCode;
    String? responseMessage;
    bool? status;
    List<TasayaServicesCategory>? categories;
    int? total;

    factory ServicesCategory.fromJson(Map<String, dynamic> json) => ServicesCategory(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        status: json["status"],
        categories: json["categories"] == null ? [] : List<TasayaServicesCategory>.from(json["categories"]!.map((x) => TasayaServicesCategory.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "status": status,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "total": total,
    };
}

class TasayaServicesCategory {
    TasayaServicesCategory({
        this.id,
        this.name,
        this.image,
        this.description,
        this.v,
        this.icon,
        this.subCategories,
    });

    String? id;
    String? name;
    String? image;
    String? description;
    int? v;
    String? icon;
    List<SubCategory>? subCategories;

    factory TasayaServicesCategory.fromJson(Map<String, dynamic> json) => TasayaServicesCategory(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        v: json["__v"],
        icon: json["icon"],
        subCategories: json["subCategories"] == null ? [] : List<SubCategory>.from(json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "description": description,
        "__v": v,
        "icon": icon,
        "subCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
    };
}

class SubCategory {
    SubCategory({
        this.name,
        this.icon,
        this.description,
        this.id,
    });

    String? name;
    String? icon;
    String? description;
    String? id;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        icon: json["icon"],
        description: json["description"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "description": description,
        "_id": id,
    };
}
