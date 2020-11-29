// To parse this JSON data, do
//
//     final ads = adsFromJson(jsonString);

import 'dart:convert';

Ads adsFromJson(String str) => Ads.fromMap(json.decode(str));

String adsToJson(Ads data) => json.encode(data.toMap());

class Ads {
  int responseCode;
  String responseStatus;
  String responseMessage;
  List<AdsDatum> data;

  Ads({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.data,
  });

  factory Ads.fromMap(Map<String, dynamic> json) => Ads(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        data: List<AdsDatum>.from(json["data"].map((x) => AdsDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ResponseCode": responseCode,
        "ResponseStatus": responseStatus,
        "ResponseMessage": responseMessage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class AdsDatum {
  int id;
  String image;

  AdsDatum({
    this.id,
    this.image,
  });

  factory AdsDatum.fromMap(Map<String, dynamic> json) => AdsDatum(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
      };
}
