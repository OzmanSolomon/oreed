// To parse this JSON data, do
//
//     final shippingAddressModel = shippingAddressModelFromMap(jsonString);

import 'dart:convert';

ShippingAddressModel shippingAddressModelFromMap(String str) =>
    ShippingAddressModel.fromMap(json.decode(str));

String shippingAddressModelToMap(ShippingAddressModel data) =>
    json.encode(data.toMap());

class ShippingAddressModel {
  ShippingAddressModel({
    this.success,
    this.myAddresses,
    this.message,
  });

  String success;
  List<MyAddresses> myAddresses;
  String message;

  factory ShippingAddressModel.fromMap(Map<String, dynamic> json) =>
      ShippingAddressModel(
        success: json["success"],
        myAddresses: List<MyAddresses>.from(
            json["data"].map((x) => MyAddresses.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(myAddresses.map((x) => x.toMap())),
        "message": message,
      };
}

class MyAddresses {
  MyAddresses({
    this.defaultAddress,
    this.addressId,
    this.gender,
    this.company,
    this.firstname,
    this.lastname,
    this.street,
    this.suburb,
    this.postcode,
    this.city,
    this.state,
    this.latitude,
    this.longitude,
    this.countriesId,
    this.countryName,
    this.zoneId,
    this.zoneCode,
    this.zoneName,
  });

  int defaultAddress;
  int addressId;
  String gender;
  dynamic company;
  String firstname;
  String lastname;
  String street;
  dynamic suburb;
  String postcode;
  String city;
  String state;
  dynamic latitude;
  dynamic longitude;
  int countriesId;
  String countryName;
  int zoneId;
  String zoneCode;
  String zoneName;

  factory MyAddresses.fromMap(Map<String, dynamic> json) => MyAddresses(
        defaultAddress: json["default_address"],
        addressId: json["address_id"],
        gender: json["gender"],
        company: json["company"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        street: json["street"],
        suburb: json["suburb"],
        postcode: json["postcode"],
        city: json["city"],
        state: json["state"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        countriesId: json["countries_id"],
        countryName: json["country_name"],
        zoneId: json["zone_id"],
        zoneCode: json["zone_code"],
        zoneName: json["zone_name"],
      );

  Map<String, dynamic> toMap() => {
        "default_address": defaultAddress,
        "address_id": addressId,
        "gender": gender,
        "company": company,
        "firstname": firstname,
        "lastname": lastname,
        "street": street,
        "suburb": suburb,
        "postcode": postcode,
        "city": city,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
        "countries_id": countriesId,
        "country_name": countryName,
        "zone_id": zoneId,
        "zone_code": zoneCode,
        "zone_name": zoneName,
      };
}
