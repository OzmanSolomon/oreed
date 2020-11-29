// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromMap(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromMap(String str) =>
    CategoryModel.fromMap(json.decode(str));

String categoryModelToMap(CategoryModel data) => json.encode(data.toMap());

class CategoryModel {
  CategoryModel({
    this.success,
    this.categoryList,
    this.message,
    this.categories,
  });

  String success;
  List<Category> categoryList;
  String message;
  int categories;

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        success: json["success"],
        categoryList:
            List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
        message: json["message"],
        categories: json["categories"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(categoryList.map((x) => x.toMap())),
        "message": message,
        "categories": categories,
      };
}

class Category {
  Category({
    this.categoriesId,
    this.categoriesName,
    this.parentId,
    this.image,
    this.icon,
    this.totalProducts,
    this.childCategories,
  });

  int categoriesId;
  String categoriesName;
  int parentId;
  String image;
  String icon;
  int totalProducts;
  List<ChildCategory> childCategories;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        categoriesId: json["categories_id"],
        categoriesName: json["categories_name"],
        parentId: json["parent_id"],
        image: json["image"],
        icon: json["icon"],
        totalProducts:
            json["total_products"] == null ? null : json["total_products"],
        childCategories: json["child_categories"] == null
            ? []
            : json['child_categories'] == "null"
                ? []
                : !json.containsKey('child_categories')
                    ? []
                    : List<ChildCategory>.from(json["child_categories"]
                        .map((x) => ChildCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "categories_id": categoriesId,
        "categories_name": categoriesName,
        "parent_id": parentId,
        "image": image,
        "icon": icon,
        "total_products": totalProducts == null ? null : totalProducts,
        "child_categories": childCategories == null
            ? []
            : List<dynamic>.from(childCategories.map((x) => x.toMap())),
      };
}

class ChildCategory {
  ChildCategory({
    this.categoriesId,
    this.categoriesName,
    this.parentId,
    this.image,
    this.icon,
  });

  int categoriesId;
  String categoriesName;
  int parentId;
  String image;
  String icon;

  factory ChildCategory.fromMap(Map<String, dynamic> json) => ChildCategory(
        categoriesId: json["categories_id"],
        categoriesName: json["categories_name"],
        parentId: json["parent_id"],
        image: json["image"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "categories_id": categoriesId,
        "categories_name": categoriesName,
        "parent_id": parentId,
        "image": image,
        "icon": icon,
      };
}
