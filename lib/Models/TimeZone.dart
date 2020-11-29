// To parse this JSON data, do
//
//     final timeZoneModel = timeZoneModelFromMap(jsonString);

import 'dart:convert';

TimeZoneModel timeZoneModelFromMap(String str) =>
    TimeZoneModel.fromMap(json.decode(str));

String timeZoneModelToMap(TimeZoneModel data) => json.encode(data.toMap());

class TimeZoneModel {
  TimeZoneModel({
    this.success,
    this.data,
    this.message,
  });

  String success;
  List<TimeZone> data;
  String message;

  factory TimeZoneModel.fromMap(Map<String, dynamic> json) => TimeZoneModel(
        success: json["success"],
        data: List<TimeZone>.from(json["data"].map((x) => TimeZone.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
      };
}

class TimeZone {
  TimeZone({
    this.zoneId,
    this.zoneCountryId,
    this.zoneCode,
    this.zoneName,
  });

  int zoneId;
  int zoneCountryId;
  String zoneCode;
  String zoneName;

  factory TimeZone.fromMap(Map<String, dynamic> json) => TimeZone(
        zoneId: json["zone_id"],
        zoneCountryId: json["zone_country_id"],
        zoneCode: json["zone_code"],
        zoneName: json["zone_name"],
      );

  Map<String, dynamic> toMap() => {
        "zone_id": zoneId,
        "zone_country_id": zoneCountryId,
        "zone_code": zoneCode,
        "zone_name": zoneName,
      };
}
