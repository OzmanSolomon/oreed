import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Models/TimeZone.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/resources/ApiHandler.dart';

class CountryRepo {
  ////////////////////////////////  Method for LogInWithOtp

  // Future<ApiResponse> fetchCountryList() async {
  //   ApiResponse apiResponse;
  //   try {
  //     //print("########################### Back Track to CountryRepo => login");
  //     await ApiHandler()
  //         .postMethodWithoutToken(url: baseuRL + 'getcountries')
  //         .then((serverApiResponse) async {
  //       if (serverApiResponse.code == 1) {
  //         var countryResponse = countryModelFromMap(serverApiResponse.object);
  //         if (countryResponse.success == "1") {
  //           apiResponse = new ApiResponse(
  //               code: 1,
  //               msg: countryResponse.message,
  //               object: countryResponse.countries);
  //         } else {
  //           apiResponse = new ApiResponse(
  //               code: int.parse(countryResponse.success),
  //               msg: countryResponse.message);
  //         }
  //       } else {
  //         apiResponse =
  //             new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
  //       }
  //     });
  //   } catch (error) {
  //     apiResponse = new ApiResponse(code: 0, msg: "Network Error");
  //   }
  //   return apiResponse;
  // }

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
}
