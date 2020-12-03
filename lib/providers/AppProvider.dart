import 'package:flutter/material.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';

class AppProvider with ChangeNotifier {
  // init values and params
  int _splashIndex = 1;
  bool _isLogin = false;
  bool _isConnected = false;
  bool _currentStatus = false;
  bool _isMapSearching = false;
  double _latitude = 0.0;
  double _longitude = 0.0;
  int lang = 1;
  List<String> centerText = [
    "Shope from thousands of brands \n   at Throwaway prices!",
    "Click, List & Sell coll stuff to \n  earn easy cash. ",
    "Click, List & Earn Money Easily  \n    and Quickly! "
  ];

  bool get mapSearchFlag => _isMapSearching;
  double get myLatitude => _latitude;
  double get myLogitude => _longitude;
  int get splashIndex => _splashIndex;

  void setLat(double lat) {
    _latitude = lat;
    notifyListeners();
  }

  void updateSplashIndex(int index) {
    if (index < 0) {
      if (_splashIndex > 1) {
        _splashIndex = _splashIndex - 1;
      }
    } else {
      if (_splashIndex < 3) {
        _splashIndex = _splashIndex + 1;
      }
    }
    notifyListeners();
  }

  void setLong(double long) {
    print("this is lat : $long");
    _longitude = long;
    notifyListeners();
  }

  DatabaseHelper helper = DatabaseHelper();

  bool get isLogin => _isLogin;
  bool get getStatus => _currentStatus;
  bool get checkConnection => _isConnected;
  Locale _appLocale = Locale('en');
  var appLocale;
  Locale get appLocal => _appLocale;

  Future fetchLocale() async {
    if (lang == 0) {
      _appLocale = Locale('en');
      print("lang $_appLocale");
    } else if (lang == 1) {
      _appLocale = Locale('ar');
      print("lang $_appLocale");
    } else {
      _appLocale = Locale('ar');
      print('no lang is specified');
    }
    notifyListeners();
  }

  void changeLanguage(Locale type) async {
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      lang = 1;
    } else {
      _appLocale = Locale("en");
      lang = 0;
    }
    notifyListeners();
  }

  void changeStatus(bool curStat) async {
    _currentStatus = curStat;
    notifyListeners();
  }
}
