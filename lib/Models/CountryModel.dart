// To parse this JSON data, do
//
//     final countryModel = countryModelFromMap(jsonString);

import 'dart:convert';

CountryModel countryModelFromMap(String str) =>
    CountryModel.fromMap(json.decode(str));

String countryModelToMap(CountryModel data) => json.encode(data.toMap());

class CountryModel {
  CountryModel({
    this.success,
    this.countries,
    this.message,
  });

  String success;
  List<Country> countries;
  String message;

  factory CountryModel.fromMap(Map<String, dynamic> json) => CountryModel(
        success: json["success"],
        countries:
            List<Country>.from(json["data"].map((x) => Country.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(countries.map((x) => x.toMap())),
        "message": message,
      };
}

class Country {
  Country({
    this.countriesId,
    this.countriesName,
    this.countriesIsoCode2,
    this.countriesIsoCode3,
    this.addressFormatId,
    this.countryCode,
  });

  int countriesId;
  String countriesName;
  String countriesIsoCode2;
  String countriesIsoCode3;
  int addressFormatId;
  dynamic countryCode;

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        countriesId: json["countries_id"],
        countriesName: json["countries_name"],
        countriesIsoCode2: json["countries_iso_code_2"],
        countriesIsoCode3: json["countries_iso_code_3"],
        addressFormatId: json["address_format_id"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toMap() => {
        "countries_id": countriesId,
        "countries_name": countriesName,
        "countries_iso_code_2": countriesIsoCode2,
        "countries_iso_code_3": countriesIsoCode3,
        "address_format_id": addressFormatId,
        "country_code": countryCode,
      };
}
