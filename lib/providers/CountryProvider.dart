import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oreed/Models/CountryModel.dart';
import 'package:oreed/Models/TimeZone.dart';
import 'package:oreed/Services/CountryRepo.dart';

class CountryProvider with ChangeNotifier {
  CountryProvider() {
    fetchTimeZoneList();
  }
  List<DropdownMenuItem<Country>> _dropdownMenuCountries = [];
  List<DropdownMenuItem<TimeZone>> _dropdownTimeZones = [];

  Country _selectedCountry;
  TimeZone _selectedTimeZone;

  bool _isLoadingCountry = false;
  bool _isLoadingTimeZone = false;

  Country get currentCountry => _selectedCountry;
  TimeZone get currentTimeZone => _selectedTimeZone;

  List<DropdownMenuItem<Country>> get countryList => _dropdownMenuCountries;
  List<DropdownMenuItem<TimeZone>> get timeZoneList => _dropdownTimeZones;

  bool get isLoadingCountry => _isLoadingCountry;
  bool get isLoadingTimeZone => _isLoadingTimeZone;

  void setCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void setTimeZone(TimeZone timeZone) {
    _selectedTimeZone = timeZone;
    notifyListeners();
  }

  void setIsLoadingCountry(bool value) {
    _isLoadingCountry = value;
    notifyListeners();
  }

  void setIsLoadingTimeZone(bool value) {
    _isLoadingTimeZone = value;
    notifyListeners();
  }

  void setIsLoadingTimeZones(bool value) {
    _isLoadingTimeZone = value;
    notifyListeners();
  }

  void emptyTimeZonesList() {
    _dropdownTimeZones.clear();
    _selectedTimeZone = null;
    _dropdownTimeZones = [];
    notifyListeners();
  }

  void fetchTimeZoneList() async {
    _isLoadingTimeZone = true;
    try {
      String countryId = currentCountry == null
          ? "199"
          : currentCountry.countriesId.toString();
      CountryRepo().fetchTimeZoneList(countryId).then((apiResponse) {
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              for (TimeZone timeZone in apiResponse.object) {
                _dropdownTimeZones.add(
                  DropdownMenuItem(
                    child: Text(timeZone.zoneName),
                    value: timeZone,
                  ),
                );
              }
              _isLoadingTimeZone = false;
              notifyListeners();
              break;
            default:
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _isLoadingTimeZone = false;

      print("Exception:$Exception");
      notifyListeners();
    }
  }
}

class Model {
  String name;
  String password;
  String cPassword;
  String address;
  String phone;
  String email;
  int gender;
  int countryId;
  int timeZone;
  File avatar;
  String avatarStr;
  String fcmToken;
  String zoneId;
  List<dynamic> other;

  Model({
    this.password,
    this.cPassword,
    this.address = "sudan ",
    this.phone = "+24900000000",
    this.name = "adamoxy",
    this.gender = 1,
    this.countryId = 199,
    this.timeZone = 1,
    this.email = "geust@email.com",
    this.avatar,
    this.avatarStr,
    this.fcmToken,
    this.zoneId,
    this.other,
  });

  Map<String, dynamic> toMap() => {
        "customers_firstname": name,
        "customers_lastname": name,
        "email": email,
        "password": password,
        "country_code": "199", //countryId,
        "customers_telephone": phone,
        "gender_id": gender,
        "zone_country_id": zoneId,
        "token": fcmToken,
      };
}
