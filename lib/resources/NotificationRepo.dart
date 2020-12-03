import 'package:http/http.dart' as http;
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/providers/NotificationProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo {
  var client = http.Client();
  String baseuRL = "http://yala-b7r.cremesolutions.com/api/v2/owner/";

  ////////////////////////////////  Method for Fetching All Offers
  Future<ApiResponse> getNotifications([int page = 1, String state]) async {
    ApiResponse apiResponse;
    print("getTrips => state : $state");
    try {
      var appSession = await SharedPreferences.getInstance();
      var token = appSession.get("token");
      final response = await client.get(
          Uri.encodeFull(
            baseuRL + 'notifications',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });
      if (response.statusCode == 200) {
        final notificationObj = notificationObjFromMap(response.body);
        if (notificationObj.responseCode == 1) {
          apiResponse = new ApiResponse(
              code: notificationObj.responseCode,
              msg: notificationObj.responseMessage,
              object: notificationObj.data);
        } else {
          apiResponse = new ApiResponse(
            code: notificationObj.responseCode,
            msg: notificationObj.responseMessage,
          );
        }
      } else {
        apiResponse = new ApiResponse(code: -1, msg: "Server Error !");
      }
    } catch (Exception) {
      apiResponse = new ApiResponse(
          code: 0,
          msg:
              "server connection error "); //"Something Went Wrong try again later.");
    } finally {
      client.close();
    }
    return apiResponse;
  }

  Future<ApiResponse> notificationIsRead(
      String authToken, String fbToken) async {
    ApiResponse apiResponse;
    final client = new http.Client();
    try {
      var appSession = await SharedPreferences.getInstance();
      var token = appSession.get("token");
      final response = await client.post(
          Uri.encodeFull(
            baseuRL + 'read_notification',
          ),
          body: {
            'token': authToken,
          },
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });
      if (response.statusCode == 200) {
        final notificationObj = notificationObjFromMap(response.body);
        if (notificationObj.responseCode == 1) {
          apiResponse = new ApiResponse(
              code: 1,
              msg: notificationObj.responseMessage,
              object: notificationObj.data);
        } else {
          apiResponse = new ApiResponse(
              code: notificationObj.responseCode,
              msg: notificationObj.responseMessage,
              object: null);
        }
      } else {
        apiResponse = new ApiResponse(
            code: response.statusCode, msg: "some Error oucurred");
      }
    } on FormatException {
      apiResponse = new ApiResponse(code: -1, msg: "FormatException");
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "internet Connection Error!");
    }
    return apiResponse;
  }
}
