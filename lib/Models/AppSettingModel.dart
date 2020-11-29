import 'dart:convert';

AppSettingModel appSettingModelFromMap(String str) =>
    AppSettingModel.fromMap(json.decode(str));

String loginModelToMap(AppSettingModel data) => json.encode(data.toMap());

class AppSettingModel {
  AppSettingModel({
    this.id,
    this.firstTimeLogin,
    this.language,
    this.timeZone,
    this.createdAt,
  });

  int id;
  int firstTimeLogin;
  dynamic language;
  String timeZone;
  String createdAt;

  factory AppSettingModel.fromMap(Map<String, dynamic> json) => AppSettingModel(
        id: json["id"],
        firstTimeLogin: json["first_time_login"],
        language: json["language"],
        timeZone: json["time_zone"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_time_login": firstTimeLogin,
        "language": language,
        "time_zone": timeZone,
        "created_at": createdAt,
      };
}
