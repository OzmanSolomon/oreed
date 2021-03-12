import 'dart:convert';

import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/MyOrdersModel.dart';
import 'package:oreeed/Models/TimeZone.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:oreeed/resources/ApiHandler.dart';

class OrdersRepo {
  Future<ApiResponse> fetchOrdersList(
      {int userId, String currencyCode = "SDG"}) async {
    ApiResponse apiResponse;
    try {
      await ApiHandler()
          .postMethodWithoutToken(url: baseuRL + 'getorders', body: {
        "customers_id": userId, //userId,
        "language_id": "1",
        "currency_code": currencyCode
      }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          var jsonContent = json.decode(serverApiResponse.object);
          final myOrdersModel = MyOrdersModel(
            success: jsonContent["success"],
            orderList: List<MyOrders>.from(
                jsonContent["data"].map((x) => MyOrders.fromMap(x))),
            message: jsonContent["message"],
          );
          if (myOrdersModel.success.toString() == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: myOrdersModel.message,
                object: myOrdersModel.orderList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(myOrdersModel.success),
                msg: myOrdersModel.message);
          }
        } else {
          apiResponse =
              new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
        }
      });
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> fetchTimeZoneList(String countryId) async {
    ApiResponse apiResponse;
    try {
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'getzones',
          body: {"zone_country_id": countryId}).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final timeZoneModel = timeZoneModelFromMap(serverApiResponse.object);
          if (timeZoneModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: timeZoneModel.message,
                object: timeZoneModel.data);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(timeZoneModel.success),
                msg: timeZoneModel.message);
          }
        } else {
          apiResponse =
              new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
        }
      });
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> placeOrder({FullOrder fullOrder}) async {
    ApiResponse apiResponse;
    try {
      print(json.encode(fullOrder.toMap().toString()));
      await ApiHandler()
          .postMethodWithoutToken(
              url: baseuRL + 'addtoorder', body: fullOrder.toMap())
          .then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          var res = json.decode(serverApiResponse.object);
          if (res["success"] == "1") {
            apiResponse = new ApiResponse(
                code: 1, msg: res["message"], object: res["data"]);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(res["success"]), msg: res["message"]);
          }
        } else {
          apiResponse =
              new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
        }
      });
    } catch (error) {
      print(fullOrder.toMap());
      apiResponse = new ApiResponse(
          code: 0,
          msg: error.message != null
              ? "${error.message}"
              : "Something Wrong, Try again later");
    }
    return apiResponse;
  }
}
