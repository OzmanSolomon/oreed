import 'dart:convert';

import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/CategoryModel.dart';
import 'package:oreeed/Models/TimeZone.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:oreeed/providers/AuthProvider.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:oreeed/resources/ApiHandler.dart';
import 'package:provider/provider.dart';

ApiResponse categories;
dynamic favs;

class BrandMenuCategoryRepo {
  ////////////////////////////////  Method for LogInWithOtp

  Future fetchFavList(context) async {
    var productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    ApiResponse apiResponse;
    try {
      if (favs == null) {
        DatabaseHelper helper = DatabaseHelper();
        User _user;
        _user = (await helper.getUserList())[0];

        print(
            "########################### Back Track to BrandMenuCategoryRepo => login");
        await ApiHandler().postMethodWithoutToken(
            url: baseuRL + 'customer_liked_products',
            body: {
              "language_id": 1,
              "customer_id": _user.id
            }).then((serverApiResponse) async {
          Map myValue = json.decode(serverApiResponse.object.toString());
          if (myValue['success'] == '1') {
            favs = apiResponse;
            productsProvider.likedProducts = [];
            List myList = myValue['data'] as List;
            myList.forEach((element) {
              productsProvider.likedProducts.add(element);
            });
            productsProvider.likedProducts.toSet().toList();
            favs = productsProvider.likedProducts;
          } else {
            apiResponse =
                new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
            favs = apiResponse;
          }
        });
      }
      return favs;
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
      favs = apiResponse;
    }
    return favs;
  }

  Future<ApiResponse> fetchCategoryList() async {
    ApiResponse apiResponse;
    try {
      if (categories == null) {
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
              categories = apiResponse;
            } else {
              apiResponse = new ApiResponse(
                  code: int.parse(categoryModel.success),
                  msg: categoryModel.message);
              categories = apiResponse;
            }
          } else {
            apiResponse =
                new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
            categories = apiResponse;
          }
        });
      }
      return categories;
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
      categories = apiResponse;
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
