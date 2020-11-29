import 'dart:convert';

import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Models/MyOrdersModel.dart';
import 'package:oreed/Models/TimeZone.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/providers/CartProvider.dart';
import 'package:oreed/resources/ApiHandler.dart';

class OrdersRepo {
  ////////////////////////////////  Method for LogInWithOtp

  Future<ApiResponse> fetchOrdersList(
      {int userId, String currencyCode = "SDG"}) async {
    ApiResponse apiResponse;
    try {
      //print("################### Back Track to OrdersRepo => fetchOrdersList");
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
      print(
          "########################### Back Track to CountryRepo => fetchTimeZoneList");
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
    print(fullOrder);
    try {
      print(
          "########################### Back Track to OrdersRepo => placeOrder");
      //print("########################### fullOrder ${fullOrder.toMap()}");
      await ApiHandler()
          .postMethodWithoutToken(
              url: baseuRL + 'addtoorder', body: fullOrder.toMap())
          .then((serverApiResponse) async {
        print(
            "***********************************  serverApiResponse  *******");
        print(serverApiResponse.object);
        print(serverApiResponse.code);
        print(serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          var res = json.decode(serverApiResponse.object);
          print(
              "converted To Json localy and manualy !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(res["success"].toString());
          print(res["message"].toString());
          print(res["success"].toString());
          // print(res[0].toString());
          print(res.toString());
          print(
              "converted To Json localy and manualy !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(res.toString());
          print(
              "converted To Json localy and manualy !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(res.toString());
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
      //print("######################################################");
      print("error : ${error}");
      apiResponse =
          new ApiResponse(code: 0, msg: "Something Wrong, Try again later");
    }
    return apiResponse;
  }
}
