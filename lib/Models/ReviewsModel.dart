// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromMap(jsonString);

import 'dart:convert';

ReviewsModel reviewsModelFromMap(String str) =>
    ReviewsModel.fromMap(json.decode(str));

String reviewsModelToMap(ReviewsModel data) => json.encode(data.toMap());

class ReviewsModel {
  ReviewsModel({
    this.success,
    this.reviewsList,
    this.message,
  });

  String success;
  List<ReviewObj> reviewsList;
  String message;

  factory ReviewsModel.fromMap(Map<String, dynamic> json) => ReviewsModel(
        success: json["success"],
        reviewsList:
            List<ReviewObj>.from(json["data"].map((x) => ReviewObj.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(reviewsList.map((x) => x.toMap())),
        "message": message,
      };
}

class ReviewObj {
  ReviewObj({
    this.reviewsId,
    this.productsId,
    this.rating,
    this.createdAt,
    this.comments,
    this.firstName,
    this.lastName,
    this.email,
  });

  int reviewsId;
  int productsId;
  int rating;
  DateTime createdAt;
  String comments;
  String firstName;
  String lastName;
  String email;

  factory ReviewObj.fromMap(Map<String, dynamic> json) => ReviewObj(
        reviewsId: json["reviews_id"],
        productsId: json["products_id"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["created_at"]),
        comments: json["comments"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "reviews_id": reviewsId,
        "products_id": productsId,
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "comments": comments,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      };
}
