// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel({
    this.success,
    this.data,
    this.message,
  });

  String success;
  List<Datum> data;
  String message;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.roleId,
    this.userName,
    this.firstName,
    this.lastName,
    this.gender,
    this.defaultAddressId,
    this.countryCode,
    this.phone,
    this.email,
    this.password,
    this.avatar,
    this.status,
    this.isSeen,
    this.phoneVerified,
    this.rememberToken,
    this.authIdTiwilo,
    this.dob,
    this.createdAt,
    this.updatedAt,
    this.likedProducts,
  });

  int id;
  int roleId;
  dynamic userName;
  String firstName;
  String lastName;
  dynamic gender;
  int defaultAddressId;
  dynamic countryCode;
  String phone;
  String email;
  String password;
  dynamic avatar;
  String status;
  int isSeen;
  dynamic phoneVerified;
  dynamic rememberToken;
  dynamic authIdTiwilo;
  dynamic dob;
  dynamic createdAt;
  dynamic updatedAt;
  List<LikedProduct> likedProducts;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        roleId: json["role_id"],
        userName: json["user_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        defaultAddressId: json["default_address_id"],
        countryCode: json["country_code"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
        status: json["status"],
        isSeen: json["is_seen"],
        phoneVerified: json["phone_verified"],
        rememberToken: json["remember_token"],
        authIdTiwilo: json["auth_id_tiwilo"],
        dob: DateTime.parse(json["dob"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        likedProducts: List<LikedProduct>.from(
            json["liked_products"].map((x) => LikedProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "role_id": roleId,
        "user_name": userName,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "default_address_id": defaultAddressId,
        "country_code": countryCode,
        "phone": phone,
        "email": email,
        "password": password,
        "avatar": avatar,
        "status": status,
        "is_seen": isSeen,
        "phone_verified": phoneVerified,
        "remember_token": rememberToken,
        "auth_id_tiwilo": authIdTiwilo,
        "dob": dob,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "liked_products":
            List<dynamic>.from(likedProducts.map((x) => x.toMap())),
      };
}

class LikedProduct {
  LikedProduct({
    this.productsId,
  });

  int productsId;

  factory LikedProduct.fromMap(Map<String, dynamic> json) => LikedProduct(
        productsId: json["products_id"],
      );

  Map<String, dynamic> toMap() => {
        "products_id": productsId,
      };
}
