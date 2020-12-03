import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/CategoryModel.dart';
import 'package:oreeed/Models/TimeZone.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/resources/ApiHandler.dart';

class BrandMenuCategoryRepo {
  ////////////////////////////////  Method for LogInWithOtp

  Future<ApiResponse> fetchCategoryList() async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'get_categories',
          body: {"language_id": 1}).then((serverApiResponse) async {
        final categoryModel = categoryModelFromMap(serverApiResponse.object);
        if (serverApiResponse.code == 1) {
          if (categoryModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: categoryModel.message,
                object: categoryModel.categoryList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(categoryModel.success),
                msg: categoryModel.message);
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

  Future<ApiResponse> fetchMenuList() async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'allcategories',
          body: {"language_id": 1}).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final categoryModel = categoryModelFromMap(serverApiResponse.object);
          if (categoryModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: categoryModel.message,
                object: categoryModel.categoryList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(categoryModel.success),
                msg: categoryModel.message);
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

  Future<ApiResponse> fetchWeekPromotionList() async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'allcategories',
          body: {"language_id": 1}).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final categoryModel = categoryModelFromMap(serverApiResponse.object);
          if (categoryModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: categoryModel.message,
                object: categoryModel.categoryList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(categoryModel.success),
                msg: categoryModel.message);
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

  Future<ApiResponse> fetchFlashSaleList() async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'allcategories',
          body: {"language_id": 1}).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final categoryModel = categoryModelFromMap(serverApiResponse.object);
          if (categoryModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: categoryModel.message,
                object: categoryModel.categoryList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(categoryModel.success),
                msg: categoryModel.message);
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

  Future<ApiResponse> fetchRecommendedList() async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'allcategories',
          body: {"language_id": 1}).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final categoryModel = categoryModelFromMap(serverApiResponse.object);
          if (categoryModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: categoryModel.message,
                object: categoryModel.categoryList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(categoryModel.success),
                msg: categoryModel.message);
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
          "########################### Back Track to BrandMenuCategoryRepo => fetchTimeZoneList");
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
