// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<SliderModel> sliderModelFromMap(String str) =>
    List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromMap(x)));

String sliderModelToMap(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SliderModel {
  SliderModel({
    @required this.slidersId,
    @required this.slidersTitle,
    @required this.slidersUrl,
    @required this.carouselId,
    @required this.slidersImage,
    @required this.slidersGroup,
    @required this.slidersHtmlText,
    @required this.expiresDate,
    @required this.dateAdded,
    @required this.status,
    @required this.type,
    @required this.dateStatusChange,
    @required this.languagesId,
    @required this.path,
    @required this.languageName,
    @required this.product,
    @required this.topseller,
    @required this.category,
    @required this.special,
    @required this.mostliked,
  });

  int slidersId;
  String slidersTitle;
  String slidersUrl;
  int carouselId;
  String slidersImage;
  String slidersGroup;
  String slidersHtmlText;
  DateTime expiresDate;
  DateTime dateAdded;
  int status;
  Type type;
  DateTime dateStatusChange;
  int languagesId;
  String path;
  dynamic languageName;
  int product;
  int topseller;
  int category;
  int special;
  int mostliked;

  factory SliderModel.fromMap(Map<String, dynamic> json) => SliderModel(
        slidersId: json["sliders_id"],
        slidersTitle: json["sliders_title"],
        slidersUrl: json["sliders_url"],
        carouselId: json["carousel_id"],
        slidersImage: json["sliders_image"],
        slidersGroup: json["sliders_group"],
        slidersHtmlText: json["sliders_html_text"],
        expiresDate: DateTime.parse(json["expires_date"]),
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
        type: json["type"],
        dateStatusChange: json["date_status_change"] == null
            ? null
            : DateTime.parse(json["date_status_change"]),
        languagesId: json["languages_id"],
        path: json["path"],
        languageName: json["language_name"],
        product: json["product"],
        topseller: json["topseller"],
        category: json["category"],
        special: json["special"],
        mostliked: json["mostliked"],
      );

  Map<String, dynamic> toMap() => {
        "sliders_id": slidersId,
        "sliders_title": slidersTitle,
        "sliders_url": slidersUrl,
        "carousel_id": carouselId,
        "sliders_image": slidersImage,
        "sliders_group": slidersGroup,
        "sliders_html_text": slidersHtmlText,
        "expires_date": expiresDate.toIso8601String(),
        "date_added": dateAdded.toIso8601String(),
        "status": status,
        "type": type,
        "date_status_change": dateStatusChange == null
            ? null
            : dateStatusChange.toIso8601String(),
        "languages_id": languagesId,
        "path": path,
        "language_name": languageName,
        "product": product,
        "topseller": topseller,
        "category": category,
        "special": special,
        "mostliked": mostliked,
      };
}
