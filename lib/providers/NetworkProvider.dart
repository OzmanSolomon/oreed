import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkProvider with ChangeNotifier {
  String _msg;
  ConnectivityResult _previousResult;
  String get msg => _msg;
  ConnectivityResult get previousResult => _previousResult;

  void checkCon() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      _msg = "Connected throgh data network";
      // I am connected to a mobile network.
//      try {
//        //now check if we can connect to google hence we are online -:)
//        final result = await InternetAddress.lookup('google.com');
//        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//          // print('connected');
//
//          _previousResult = ConnectivityResult.mobile;
//        }
//      } on SocketException catch (_) {
//        // print('not connected');
//
//        _msg =
//            "you are experiencing bad internet connection,check your Mobile NetWork";
//      }

      _previousResult = ConnectivityResult.mobile;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      _previousResult = ConnectivityResult.wifi;
      _msg = "Connected throgh wifi network";
//      try {
//        //now check if we can connect to google(cuz it is always online) hence we are online -:)
//        final result = await InternetAddress.lookup('google.com');
//        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//          // print('connected');
//
//          _previousResult = ConnectivityResult.wifi;
//        }
//      } on SocketException catch (_) {
//        // print('not connected WiFi!');
//
      //  _msg =
      //      "you are experiencing bad internet connection,check your WiFi NetWork";
//      }
    } else {
      _previousResult = ConnectivityResult.none;
      _msg = "Please: Connect throgh data or wifi network";
    }

    try {
      notifyListeners();
    } catch (exeption) {}
  }
}
