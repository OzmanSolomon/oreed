import 'dart:convert';

import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/Utiles/databaseHelper.dart';
import 'package:oreed/resources/ApiHandler.dart';

class AuthRepo {
  ////////////////////////////////  Method for LogInWithOtp

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<ApiResponse> login(
      {lang = "en", String email, String password}) async {
    ApiResponse apiResponse;
    try {
      // //print("########################### Back Track to AuthRepo => login try");
      await ApiHandler()
          .postMethodWithoutToken(url: baseuRL + 'processlogin', body: {
        'email': email,
        'password': password,
      }).then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: serverApiResponse.code, msg: serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          var map = jsonDecode(serverApiResponse.object);
          if (map["success"] == "0") {
            apiResponse = new ApiResponse(code: 0, msg: map["message"]);
          } else {
            var data = map["data"][0];
            User user = User.fromMapObject(data);
            await databaseHelper.insertUser(user);
            apiResponse = new ApiResponse(
                code: serverApiResponse.code, msg: serverApiResponse.msg);
          }
        } else {
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        }
      });
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: error.toString());
    }
    return apiResponse;
  }

  Future<ApiResponse> uploadUserImage(
      {lang = "en", String base64Image, int userId}) async {
    ApiResponse apiResponse;

    try {
      print(
          "########################### Back Track to AuthRepo => uploadUserImage");

      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'updatecustomerimage',
          body: {
            'avatar': base64Image,
            "customers_id": userId
          }).then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: serverApiResponse.code, msg: serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          var map = jsonDecode(serverApiResponse.object);
          if (map["success"] == "0") {
            apiResponse = new ApiResponse(code: 0, msg: map["message"]);
          } else {
            var data = map["data"][0];
            User user = User.fromMapObject(data);
            databaseHelper.updateUser(user);
            apiResponse = new ApiResponse(
                code: serverApiResponse.code, msg: serverApiResponse.msg);
          }
        } else {
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        }
      });
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "error unknown");
    }
    return apiResponse;
  }

  Future<ApiResponse> registration(
      {lang = "en", Map<String, dynamic> userRegistration}) async {
    ApiResponse apiResponse;
    try {
      //print("###################### Back Track to AuthRepo => registration");
      print("userRegistration:${userRegistration}");
      await ApiHandler()
          .postMethodWithoutToken(
              url: baseuRL + 'processregistration', body: userRegistration)
          .then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: serverApiResponse.code, msg: serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          var map = jsonDecode(serverApiResponse.object);
          var data = map["data"][0];
          User user = User.fromMapObject(data);
          databaseHelper.insertUser(user);
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        } else {
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        }
      });
    } catch (error) {
      print(
          "########################### Back Track to AuthRepo => registration");
      print(error.toString());
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> processEditProfile(
      {lang = "en", Map<String, dynamic> userRegistration}) async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to AuthRepo => registration");
      print("processEditProfile:${userRegistration}");
      await ApiHandler()
          .postMethodWithoutToken(
              url: baseuRL + 'updatecustomerinfo', body: userRegistration)
          .then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: serverApiResponse.code, msg: serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          var map = jsonDecode(serverApiResponse.object);
          var data = map["data"][0];
          User user = User.fromMapObject(data);
          databaseHelper.updateUser(user);
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        } else {
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        }
      });
    } catch (error) {
      print(
          "########################### Back Track to AuthRepo => registration");
      print(error.toString());
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> processForgotPassword({lang = "en", String email}) async {
    ApiResponse apiResponse;
    print("base URL : $email");
    try {
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + "processforgotpassword",
          body: {
            'email': email,
          }).then((serverApiResponse) async {
        print("base URL : $email");
        apiResponse = new ApiResponse(
            code: serverApiResponse.code, msg: serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          //print("#############______________#############______________");
          print("${serverApiResponse.object}");
          var map = jsonDecode(serverApiResponse.object);
          if (map["success"] == "1") {
            apiResponse = new ApiResponse(code: 1, msg: map["message"]);
          } else {
            apiResponse = new ApiResponse(code: 1, msg: map["message"]);
          }
        } else {
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        }
      });
    } catch (error) {
      print(
          "########################### Back Track to AuthRepo => processForgotPassword");
      print(error.toString());
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> processChangePassword(
      {lang = "en",
      String oldPassword,
      String newPassword,
      String customerId}) async {
    ApiResponse apiResponse;
    try {
      await ApiHandler()
          .postMethodWithoutToken(url: baseuRL + "updatepassword", body: {
        'customers_id': customerId,
        'oldpassword': oldPassword,
        'newpassword': newPassword,
      }).then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: serverApiResponse.code, msg: serverApiResponse.msg);
        if (serverApiResponse.code == 1) {
          print("${serverApiResponse.object}");
          var map = jsonDecode(serverApiResponse.object);
          if (map["success"] == "1") {
            apiResponse = new ApiResponse(code: 1, msg: map["message"]);
          } else {
            apiResponse = new ApiResponse(code: 0, msg: map["message"]);
          }
        } else {
          apiResponse = new ApiResponse(
              code: serverApiResponse.code, msg: serverApiResponse.msg);
        }
      });
    } catch (error) {
      apiResponse =
          new ApiResponse(code: 0, msg: "Something Wrong, Try again later");
    }
    return apiResponse;
  }
}
