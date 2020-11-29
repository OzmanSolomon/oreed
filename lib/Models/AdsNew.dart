// To parse this JSON data, do
//
//     final ads = adsFromMap(jsonString);

import 'dart:convert';

class Ads {
  Ads({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory Ads.fromJson(String str) => Ads.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ads.fromMap(Map<String, dynamic> json) => Ads(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
      };
}
