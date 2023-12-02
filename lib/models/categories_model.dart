// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

CategoriesList categoriesFromJson(String str) =>
    CategoriesList.fromJson(json.decode(str));

String categoriesToJson(CategoriesList data) => json.encode(data.toJson());

class CategoriesList {
  CategoriesList({
    this.status,
    this.data,
  });

  bool? status;
  List<CategoryList>? data;

  factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
        status: json["status"],
        data: List<CategoryList>.from(json["data"].map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryList {
  CategoryList({
    this.categoryId,
    this.categoryName,
    this.catImage,
  });

  String? categoryId;
  String? categoryName;
  String? catImage;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
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
