// To parse this JSON data, do
//
//     final productsModel = productsModelFromMap(jsonString);

import 'dart:convert';

ProductsModel productsModelFromMap(String str) =>
    ProductsModel.fromMap(json.decode(str));

String productsModelToMap(ProductsModel data) => json.encode(data.toMap());

class ProductsModel {
  ProductsModel({
    this.success,
    this.product,
    this.message,
    this.totalRecord,
  });

  String success;
  List<Product> product;
  String message;
  int totalRecord;

  factory ProductsModel.fromMap(Map<String, dynamic> json) => ProductsModel(
        success: json["success"],
        product: List<Product>.from(
            json["product_data"].map((x) => Product.fromMap(x))),
        message: json["message"],
        totalRecord: json["total_record"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "product_data": List<dynamic>.from(product.map((x) => x.toMap())),
        "message": message,
        "total_record": totalRecord,
      };
}

class Product {
  Product({
    this.productsId,
    this.productsFlashImage,
    this.productsQuantity,
    this.productsModel,
    this.productsImage,
    this.productsPrice,
    this.productsWeight,
    this.productsWeightUnit,
    this.productsStatus,
    this.isCurrent,
    this.manufacturersId,
    this.productsOrdered,
    this.lowLimit,
    this.isOriginal,
    this.productsSlug,
    this.productsType,
    this.productsMinOrder,
    this.productsMaxStock,
    this.currency,
    this.id,
    this.languageId,
    this.productsName,
    this.productsDescription,
    this.productsUrl,
    this.productsViewed,
    this.manufacturerName,
    this.manufacturerImage,
    this.manufacturersUrl,
    this.discountPrice,
    this.flashStartDate,
    this.flashExpiresDate,
    this.flashPrice,
    this.images,
    this.categories,
    this.rating,
    this.totalUserRated,
    this.fiveRatio,
    this.fourRatio,
    this.threeRatio,
    this.twoRatio,
    this.oneRatio,
    this.reviewedCustomers,
    this.defaultStock,
    this.attributes,
  });

  int productsId;
  String productsFlashImage;
  int productsQuantity;
  String productsModel;
  String productsImage;
  String productsPrice;
  String productsWeight;
  String productsWeightUnit;
  int productsStatus;
  int isCurrent;
  int manufacturersId;
  int productsOrdered;
  int lowLimit;
  int isOriginal;
  String productsSlug;
  int productsType;
  int productsMinOrder;
  int productsMaxStock;
  dynamic currency;
  int id;
  int languageId;
  String productsName;
  String productsDescription;
  dynamic productsUrl;
  int productsViewed;
  String manufacturerName;
  dynamic manufacturerImage;
  dynamic manufacturersUrl;
  dynamic discountPrice;
  dynamic flashStartDate;
  dynamic flashExpiresDate;
  dynamic flashPrice;
  List<ImageList> images;
  List<Category> categories;
  String rating;
  int totalUserRated;
  int fiveRatio;
  int fourRatio;
  int threeRatio;
  int twoRatio;
  int oneRatio;
  List<ReviewedCustomer> reviewedCustomers;
  int defaultStock;
  List<Attribute> attributes;

  // "flash_start_date": 1601858700,
  // "flash_expires_date": 1623977100,
  // "flash_price": "100.00",
  //

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productsId: json["products_id"],
        productsFlashImage:
            json["products_image"] == null ? null : json["products_image"],
        productsQuantity: json["products_quantity"],
        productsModel:
            json["products_model"] == null ? null : json["products_model"],
        productsImage: json["products_image"],
        productsPrice:
            json["products_price"] == null ? "0.0" : json["products_price"],
        productsWeight: json["products_weight"],
        productsWeightUnit: json["products_weight_unit"] == null
            ? null
            : json["products_weight_unit"],
        productsStatus: json["products_status"],
        isCurrent: json["is_current"],
        manufacturersId:
            json["manufacturers_id"] == null ? null : json["manufacturers_id"],
        productsOrdered: json["products_ordered"],
        lowLimit: json["low_limit"],
        isOriginal: json["is_original"] == null ? null : json["is_original"],
        productsSlug: json["products_slug"],
        productsType: json["products_type"],
        productsMinOrder: json["products_min_order"],
        productsMaxStock: json["products_max_stock"] == null
            ? null
            : json["products_max_stock"],
        currency: json["currency"],
        id: json["id"],
        languageId: json["language_id"],
        productsName: json["products_name"],
        productsDescription: json["products_description"],
        productsUrl: json["products_url"],
        productsViewed: json["products_viewed"],
        manufacturerName: json["manufacturer_name"] == null
            ? null
            : json["manufacturer_name"],
        manufacturerImage: json["manufacturer_image"],
        manufacturersUrl: json["manufacturers_url"],
        discountPrice:
            json["discount_price"] == null ? null : json["discount_price"],
        flashStartDate:
            json["flash_start_date"] == null ? null : json["flash_start_date"],
        flashExpiresDate: json["flash_expires_date"] == null
            ? null
            : json["flash_expires_date"],
        flashPrice: json["flash_price"] == null ? "0.0" : json["flash_price"],
        images: json["images"] != null
            ? List<ImageList>.from(
                json["images"].map((x) => ImageList.fromMap(x)))
            : [],
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromMap(x)))
            : [],
        rating: json["rating"],
        totalUserRated: json["total_user_rated"],
        fiveRatio: json["five_ratio"],
        fourRatio: json["four_ratio"],
        threeRatio: json["three_ratio"],
        twoRatio: json["two_ratio"],
        oneRatio: json["one_ratio"],
        reviewedCustomers: json["reviewed_customers"] != null
            ? List<ReviewedCustomer>.from(json["reviewed_customers"]
                .map((x) => ReviewedCustomer.fromMap(x)))
            : [],
        defaultStock: json["defaultStock"],
        attributes: json["attributes"] != null
            ? List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "products_id": productsId,
        "products_quantity": productsQuantity,
        "products_model": productsModel == null ? null : productsModel,
        "products_image": productsImage,
        "products_price": productsPrice,
        "products_weight": productsWeight,
        "products_weight_unit":
            productsWeightUnit == null ? null : productsWeightUnit,
        "products_status": productsStatus,
        "is_current": isCurrent,
        "manufacturers_id": manufacturersId == null ? null : manufacturersId,
        "products_ordered": productsOrdered,
        "low_limit": lowLimit,
        "is_original": isOriginal == null ? null : isOriginal,
        "products_slug": productsSlug,
        "products_type": productsType,
        "products_min_order": productsMinOrder,
        "products_max_stock":
            productsMaxStock == null ? null : productsMaxStock,
        "currency": currency,
        "id": id,
        "language_id": languageId,
        "products_name": productsName,
        "products_description": productsDescription,
        "products_url": productsUrl,
        "products_viewed": productsViewed,
        "manufacturer_image": manufacturerImage,
        "manufacturers_url": manufacturersUrl,
        "discount_price": discountPrice == null ? 0.0 : discountPrice,
        "flash_start_date": flashStartDate == null ? null : flashStartDate,
        "flash_expires_date":
            flashExpiresDate == null ? null : flashExpiresDate,
        "flash_price": flashPrice == null ? null : flashPrice,
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
        "rating": rating,
        "total_user_rated": totalUserRated,
        "five_ratio": fiveRatio,
        "four_ratio": fourRatio,
        "three_ratio": threeRatio,
        "two_ratio": twoRatio,
        "one_ratio": oneRatio,
        "reviewed_customers":
            List<dynamic>.from(reviewedCustomers.map((x) => x.toMap())),
        "defaultStock": defaultStock,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}

class Attribute {
  int productsOptionsId;
  String productsOptions;
  int productsAttributesId;
  int productsOptionsValuesId;
  String productsOptionsValues;
  String optionsValuesPrice;
  String pricePrefix;

  Attribute(
      {this.productsOptionsId,
      this.productsOptions,
      this.productsAttributesId,
      this.productsOptionsValuesId,
      this.productsOptionsValues,
      this.optionsValuesPrice,
      this.pricePrefix});

  Attribute.fromJson(Map<String, dynamic> json) {
    productsOptionsId = json['products_options_id'];
    productsOptions = json['products_options'];
    productsAttributesId = json['products_attributes_id'];
    productsOptionsValuesId = json['products_options_values_id'];
    productsOptionsValues = json['products_options_values'];
    optionsValuesPrice = json['options_values_price'];
    pricePrefix = json['price_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_options_id'] = this.productsOptionsId;
    data['products_options'] = this.productsOptions;
    data['products_attributes_id'] = this.productsAttributesId;
    data['products_options_values_id'] = this.productsOptionsValuesId;
    data['products_options_values'] = this.productsOptionsValues;
    data['options_values_price'] = this.optionsValuesPrice;
    data['price_prefix'] = this.pricePrefix;
    return data;
  }
}

class Option {
  Option({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Option.fromMap(Map<String, dynamic> json) => Option(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Value {
  Value({
    this.productsAttributesId,
    this.id,
    this.value,
    this.price,
    this.pricePrefix,
  });

  int productsAttributesId;
  int id;
  String value;
  String price;
  PricePrefix pricePrefix;

  factory Value.fromMap(Map<String, dynamic> json) => Value(
        productsAttributesId: json["products_attributes_id"],
        id: json["id"],
        value: json["value"],
        price: json["price"],
        pricePrefix: pricePrefixValues.map[json["price_prefix"]],
      );

  Map<String, dynamic> toMap() => {
        "products_attributes_id": productsAttributesId,
        "id": id,
        "value": value,
        "price": price,
        "price_prefix": pricePrefixValues.reverse[pricePrefix],
      };
}

enum PricePrefix { EMPTY, PRICE_PREFIX }

final pricePrefixValues =
    EnumValues({"+": PricePrefix.EMPTY, "-": PricePrefix.PRICE_PREFIX});

class Category {
  Category({
    this.categoriesId,
    this.categoriesName,
    this.categoriesImage,
    this.categoriesIcon,
    this.parentId,
  });

  int categoriesId;
  String categoriesName;
  String categoriesImage;
  String categoriesIcon;
  int parentId;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        categoriesId: json["categories_id"],
        categoriesName: json["categories_name"],
        categoriesImage: json["categories_image"],
        categoriesIcon: json["categories_icon"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toMap() => {
        "categories_id": categoriesId,
        "categories_name": categoriesName,
        "categories_image": categoriesImage,
        "categories_icon": categoriesIcon,
        "parent_id": parentId,
      };
}

class ImageList {
  ImageList({
    this.id,
    this.productsId,
    this.image,
    this.htmlcontent,
    this.sortOrder,
  });

  int id;
  int productsId;
  String image;
  String htmlcontent;
  int sortOrder;

  factory ImageList.fromMap(Map<String, dynamic> json) => ImageList(
        id: json["id"],
        productsId: json["products_id"],
        image: json["image"],
        htmlcontent: json["htmlcontent"] == null ? null : json["htmlcontent"],
        sortOrder: json["sort_order"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "products_id": productsId,
        "image": image,
        "htmlcontent": htmlcontent == null ? null : htmlcontent,
        "sort_order": sortOrder,
      };
}

class ReviewedCustomer {
  ReviewedCustomer({
    this.reviewsId,
    this.productsId,
    this.customersId,
    this.customersName,
    this.reviewsRating,
    this.reviewsStatus,
    this.reviewsRead,
    this.createdAt,
    this.updatedAt,
    this.comments,
    this.image,
  });

  int reviewsId;
  int productsId;
  int customersId;
  String customersName;
  int reviewsRating;
  int reviewsStatus;
  int reviewsRead;
  DateTime createdAt;
  dynamic updatedAt;
  String comments;
  dynamic image;

  factory ReviewedCustomer.fromMap(Map<String, dynamic> json) =>
      ReviewedCustomer(
        reviewsId: json["reviews_id"],
        productsId: json["products_id"],
        customersId: json["customers_id"],
        customersName: json["customers_name"],
        reviewsRating: json["reviews_rating"],
        reviewsStatus: json["reviews_status"],
        reviewsRead: json["reviews_read"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        comments: json["comments"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "reviews_id": reviewsId,
        "products_id": productsId,
        "customers_id": customersId,
        "customers_name": customersName,
        "reviews_rating": reviewsRating,
        "reviews_status": reviewsStatus,
        "reviews_read": reviewsRead,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "comments": comments,
        "image": image,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
