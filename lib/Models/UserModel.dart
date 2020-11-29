// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    this.success,
    this.user,
    this.message,
  });

  String success;
  List<User> user;
  String message;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        user: List<User>.from(json["User"].map((x) => User.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "User": List<dynamic>.from(user.map((x) => x.toMap())),
        "message": message,
      };
}

class User {
  User({
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
  });

  int id;
  int roleId;
  String userName;
  String firstName;
  String lastName;
  String gender;
  int defaultAddressId;
  String countryCode;
  String phone;
  String email;
  String password;
  String avatar;
  String status;
  int isSeen;
  String phoneVerified;
  String rememberToken;
  String authIdTiwilo;
  String dob;
  String createdAt;
  String updatedAt;

  factory User.fromMap(Map<String, dynamic> json) => User(
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
        dob: json["dob"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
      };
}
