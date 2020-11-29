// To parse this JSON data, do
//
//     final userAccountInfo = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromMap(json.decode(str));

String userAccountInfoToJson(UserProfile data) => json.encode(data.toMap());

class UserProfile {
  int responseCode;
  String responseStatus;
  String responseMessage;
  Data data;

  UserProfile({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.data,
  });

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "ResponseCode": responseCode,
        "ResponseStatus": responseStatus,
        "ResponseMessage": responseMessage,
        "data": data.toMap(),
      };
}

class Data {
  int id;
  String userName;
  String fullName;
  String phoneNumber;
  String email;
  String image;
  String birthday;
  int genderId;
  int userTypeId;
  int code;
  String lang;
  String address;
  int verified;
  String emailToken;
  int isActive;
  String deletedAt;
  String fcmToken;

  Data({
    this.id = 1,
    this.userName = "johne doue",
    this.fullName = "johnason",
    this.phoneNumber = "+2499+++++++",
    this.email = "email@mail.com",
    this.image = "user_avatar.png",
    this.birthday = "1956-01-01",
    this.genderId = 1,
    this.userTypeId = 1,
    this.code = 1234,
    this.lang = "ar",
    this.address = "sudan , khartoum",
    this.verified = 1,
    this.emailToken = "token",
    this.isActive = 1,
    this.deletedAt = "",
    this.fcmToken = "longtextidfromfirebasecloundmsg",
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        userName: json["user_name"].toString(),
        fullName: json["full_name"].toString(),
        phoneNumber: json["phone_number"].toString(),
        email: json["email"].toString(),
        image: json["image"].toString(),
        birthday: json["birthday"],
        genderId: json["gender_id"],
        userTypeId: json["user_type_id"],
        code: json["code"],
        lang: json["lang"].toString(),
        address: json["address"].toString(),
        verified: json["verified"],
        emailToken: json["email_token"].toString(),
        isActive: json["is_active"],
        deletedAt: json["deleted_at"].toString(),
        fcmToken: json["fcmToken"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_name": userName,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "image": image,
        "birthday": birthday,
        "gender_id": genderId,
        "user_type_id": userTypeId,
        "code": code,
        "lang": lang,
        "address": address,
        "verified": verified,
        "email_token": emailToken,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "fcmToken": fcmToken,
      };
}
