import 'package:flutter/material.dart';
import 'package:oreeed/Services/CheckOutRepo.dart';
import 'package:oreeed/UI/CartUIComponent/CheckOut.dart';
import 'package:oreeed/UI/GenralWidgets/ServerProcessLoader.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';

class CheckOutProvider with ChangeNotifier {
  DeliveryAddress model = DeliveryAddress();

  List<DeliveryAddress> _deliveryAddress = [];

  List<DeliveryAddress> get deliveryAddress => _deliveryAddress ?? [];

  void addNewShippingAddress({GlobalKey<ScaffoldState> scaffoldKey}) async {
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(true);
          }),
    );
    try {
      CheckOutRepo()
          .addNewShippingAddress(address: model)
          .then((apiResponse) async {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          if (apiResponse.code == 1) {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
            Navigator.of(scaffoldKey.currentContext).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => new CheckOut()));
          } else {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      Navigator.pop(scaffoldKey.currentContext);
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: "apiResponse",
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }

  void reSetUser() {
    model = new DeliveryAddress();
    notifyListeners();
  }

  void setUserId(String strValue) {
    model.userId = strValue;
    notifyListeners();
  }

  void setFirstName(String strValue) {
    model.firstName = strValue;
    notifyListeners();
  }

  void setLastName(String strValue) {
    model.lastName = strValue;
    notifyListeners();
  }

  void setReceiverPhone(String strValue) {
    model.reciverPhone = strValue;
    notifyListeners();
  }

  void setStreetAddress(String strValue) {
    model.streetAddress = strValue;
    notifyListeners();
  }

  void setPostCode(String strValue) {
    model.postCode = strValue;
    notifyListeners();
  }

  void setCity(String strValue) {
    model.city = strValue;
    notifyListeners();
  }

  void setCountryId(String strValue) {
    model.countryId = strValue;
    notifyListeners();
  }

  void setZoneId(String strValue) {
    model.zoneId = strValue;
    notifyListeners();
  }

  void setIsDefault(String strValue) {
    model.isDefault = strValue;
    notifyListeners();
  }
}

class DeliveryAddress {
  String lang;
  String userId;
  String reciverPhone;
  String firstName;
  String lastName;
  String streetAddress;
  String postCode;
  String city;
  String countryId;
  String zoneId;
  String isDefault;

  DeliveryAddress({
    this.lang,
    this.userId,
    this.reciverPhone,
    this.firstName,
    this.lastName,
    this.streetAddress,
    this.postCode,
    this.city,
    this.countryId,
    this.zoneId,
    this.isDefault,
  });

  Map<String, dynamic> toMap() => {
        "language_id": 1,
        "customers_id": userId,
        "entry_reciverPhone": reciverPhone ?? "",
        "entry_firstname": firstName ?? "",
        "entry_lastname": lastName ?? "",
        "entry_street_address": streetAddress ?? "",
        "entry_postcode": postCode ?? "",
        "entry_city": city ?? "",
        "entry_country_id": countryId ?? "",
        "entry_zone_id": zoneId ?? "",
        "is_default": isDefault ?? "",
      };
}
