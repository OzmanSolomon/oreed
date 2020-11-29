import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/Utiles/databaseHelper.dart';
import 'package:oreed/resources/ApiHandler.dart';

class ConfigurationRepo {
  ////////////////////////////////  Method for LogInWithOtp

  DatabaseHelper databaseHelper = DatabaseHelper();
  Future<ApiResponse> getSliders() async {
    ApiResponse apiResponse;
    try {
      await ApiHandler()
          .getMethodWithoutToken(baseuRL + 'sliders')
          .then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: 1, msg: "Success", object: serverApiResponse.object);
      });
      //print("########____________Sliders ${apiResponse.object}");
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: error.toString());
    }
    return apiResponse;
  }

  Future<ApiResponse> getBrands() async {
    ApiResponse apiResponse;
    try {
      await ApiHandler()
          .getMethodWithoutToken(baseuRL + 'manufacturers')
          .then((serverApiResponse) async {
        apiResponse = new ApiResponse(
            code: 1, msg: "Success", object: serverApiResponse.object);
      });
      //print("########____________Sliders ${apiResponse.object}");
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: error.toString());
    }
    return apiResponse;
  }
}
