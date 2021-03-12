// Copyright (c) 2020, adamoxy@cyber-corner.com.
// Please feel free to use with any other application as an Skelton.
// But must refer to the Author.
// All rights reserved. Use of this source code is governed by a
// GNU licences.
// ApiHandler v0.1
import 'package:dio/dio.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/UI/BottomNavigationBar.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHandler {
  /// @description: encapsulation for Get Calls but With authentication token
  /// @methodName: getMethod
  /// @methodType: get
  /// @params: String url
  /// @response: ApiResponse
  /// @body:none
  ///
  Future<User> getCurrentUser() async {
    DatabaseHelper helper = DatabaseHelper();
    User _user;

    if (helper != null) {
      if (await helper.getUserCount() > 0) {
        _user = (await helper.getUserList())[0];
        //print("##################  getCurrentUser  ######################");
        print("current user is ${_user.id}");
        print("current user is ${_user.firstName}");
        print("current user is ${_user.lastName}");
        print("current user is ${_user.dob}");
        print("current user is ${_user.email}");
        print("current user is ${_user.phone}");
        print("current user is ${_user.gender}");
        //print("##################  getCurrentUser ######################");
      }
    }
    return _user;
  }

  Future<ApiResponse> getMethod(String url) async {
    //print("########################   BackTrack To ApiHandler => getMethod ");
    ApiResponse apiResponse;
    Dio dio = new Dio();
    var appSession = await SharedPreferences.getInstance();
    var token = appSession.get("token");
    try {
      var response = await dio.get(
        url,
        options: Options(
          sendTimeout: 5000,
          //receiveTimeout: 3000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );
      consoleLogResponse(response, "putMethodWithoutToken");
      if (response.statusCode == 200) {
        apiResponse = new ApiResponse(
            code: 1,
            msg: "response completed successful",
            object: response.data);
      } else {
        return _responseExceptionWrapper(response);
      }
    } on DioError catch (e) {
      return _dioExceptionWrapper(e);
    } on FormatException {
      throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  /// @description: encapsulation for Get Calls but Without authentication
  /// @methodName: getMethodWithoutToken
  /// @methodType: get
  /// @params: String url
  /// @response: ApiResponse
  /// @body: none

  Future<ApiResponse> getMethodWithoutToken(String url) async {
    print(
        "########################   BackTrack To ApiHandler => getMethodWithoutToken ");
    ApiResponse apiResponse;
    Dio dio = new Dio();
    try {
      var response = await dio.get(
        url,
        options: Options(
          sendTimeout: 5000,
          //receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      consoleLogResponse(response, "putMethodWithoutToken");
      if (response.statusCode == 200) {
        apiResponse = new ApiResponse(
            code: 1,
            msg: "response completed successful",
            object: response.data);
      } else {
        return _responseExceptionWrapper(response);
      }
    } on DioError catch (e) {
      return _dioExceptionWrapper(e);
    } on FormatException {
      throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  /// @description: encapsulation for Post Calls but With authentication token
  /// @methodName: postMethod
  /// @methodType: post
  /// @params: String url ,Map<dynamic, dynamic> body
  /// @response: ApiResponse
  /// @body: none
  Future<ApiResponse> postMethod(String url, body) async {
    //print("########################   BackTrack To ApiHandler => postMethod ");
    ApiResponse apiResponse;
    var appSession = await SharedPreferences.getInstance();
    var token = appSession.get("token");
    globalToken = token;
    print(
        "#######################################  Token @-------------------------");
    print('@$token@');
    Dio dio = new Dio();
    try {
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          sendTimeout: 5000,
          //receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );
      consoleLogResponse(response, "putMethodWithoutToken");
      if (response.statusCode == 200) {
        apiResponse = new ApiResponse(
            code: 1,
            msg: "response completed successful",
            object: response.data);
      } else {
        return _responseExceptionWrapper(response);
      }
    } on DioError catch (e) {
      return _dioExceptionWrapper(e);
    } on FormatException {
      throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  /// @description: encapsulation for Post Calls but WithOut authentication token
  /// @methodName: postMethodWithoutToken
  /// @methodType: post
  /// @params: String url, Map<dynamic,dynamic> body
  /// @response: ApiResponse
  /// @body: none
  Future<ApiResponse> postMethodWithoutToken(
      {String url, Map<dynamic, dynamic> body}) async {
    print(
        "########################   BackTrack To ApiHandler => postMethodWithoutToken ");
    ApiResponse apiResponse;

    Dio dio = new Dio();
    try {
      print("Body : $body");
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          // sendTimeout: 5000,
          //receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print("response: ${response.toString()}");
      consoleLogResponse(response, "PostMethodWithoutToken");
      if (response.statusCode == 200) {
        print(response.data.toString());
        apiResponse = new ApiResponse(
            code: 1,
            msg: "response completed successful",
            object: response.data);
        //print("############____________${response.data}");
      } else {
        return _responseExceptionWrapper(response);
      }
    } on DioError catch (e) {
      return _dioExceptionWrapper(e);
    } on FormatException {
      throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  /// @description: encapsulation for Post Calls but With authentication token
  /// @methodName: putMethod
  /// @methodType: put
  /// @params: String url, Map<dynamic,dynamic> body
  /// @response: ApiResponse
  /// @body: none
  ////////////////////////////////  a method for encapsulation for Get Calls
  Future<ApiResponse> putMethod(
      {String url, Map<dynamic, dynamic> body}) async {
    print(
        "##################################  Back Track to ApiHandler => putMethod");
    ApiResponse apiResponse;
    var appSession = await SharedPreferences.getInstance();
    var token = appSession.get("token");
    Dio dio = new Dio();
    try {
      var response = await dio.put(
        url,
        data: body,
        options: Options(
          sendTimeout: 5000,
          //receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );
      consoleLogResponse(response, "putMethodWithoutToken");
      if (response.statusCode == 200) {
        apiResponse = new ApiResponse(
            code: 1,
            msg: "response completed successful",
            object: response.data);
      } else {
        return _responseExceptionWrapper(response);
      }
    } on DioError catch (e) {
      return _dioExceptionWrapper(e);
    } on FormatException {
      throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  /// @description: encapsulation for Post Calls but WithOut authentication token
  /// @methodName: putMethodWithoutToken
  /// @methodType: put
  /// @params: String url, Map<dynamic,dynamic> body
  /// @response: ApiResponse
  /// @body: none
  ////////////////////////////////  a method for encapsulation for Get Calls
  Future<ApiResponse> putMethodWithoutToken(
      {String url, Map<dynamic, dynamic> body}) async {
    ApiResponse apiResponse;

    Dio dio = new Dio();
    try {
      var response = await dio.put(
        url,
        data: body,
        options: Options(
          // sendTimeout: 5000,
          // //receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      consoleLogResponse(response, "putMethodWithoutToken");
      if (response.statusCode == 200) {
        apiResponse = new ApiResponse(
            code: 1,
            msg: "response completed successful",
            object: response.data);
      } else {
        return _responseExceptionWrapper(response);
      }
    } on DioError catch (e) {
      return _dioExceptionWrapper(e);
    } on FormatException {
      throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  /// this method is only for debugging release please don't forget to delete it or comment it when deploy
  void consoleLogResponse(Response response, String msg) {
    print(
        "########################################  ApiHandler Back Track: $msg");
    //print("####################################### baseUrl");
    print(response.request.baseUrl);
    //print("####################################### statusCode");
    print(response.statusCode);
    //print("####################################### headers");
    print(response.headers);
    //print("####################################### request");
    print(response.toString());
    //print("####################################### data");
    print(response.data);
  }

  /// this method is only for debugging release please don't forget to delete it or comment it when deploy
  ApiResponse _dioExceptionWrapper(DioError exception) {
    switch (exception.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        throw Exception('Exceeded Connection Time');
        break;
      case DioErrorType.SEND_TIMEOUT:
        throw Exception('Exceeded Connection Time');
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        throw Exception('Exceeded receiving Data Time');
        break;
      case DioErrorType.RESPONSE:
        throw Exception('Exceeded Response Time');
        break;
      case DioErrorType.CANCEL:
        throw Exception('Request was Cancelled');
        break;
      case DioErrorType.DEFAULT:
        throw Exception('Unknown Error');
        break;
      default:
        throw Exception('Unknown Error (:- ');
        break;
    }
  }

  /// this method is only for debugging release please don't forget to delete it or comment it when deploy
  ApiResponse _responseExceptionWrapper(Response response) {
    var apiResponse = new ApiResponse();
    if (response.statusCode == 200) {
      apiResponse = new ApiResponse(code: 1, object: response.data);
    } else if (response.statusCode > 299 || response.statusCode < 400) {
      apiResponse =
          new ApiResponse(code: 299, msg: "could not connect to server");
    } else if (response.statusCode > 399 || response.statusCode < 500) {
      apiResponse = new ApiResponse(
          code: 399, msg: "Sorry Bad Request,Pleas Try Again Later");
    } else if (response.statusCode > 499) {
      apiResponse = new ApiResponse(code: 499, msg: "Server Error");
    }
    return apiResponse;
  }
}
