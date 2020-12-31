import 'dart:convert';

import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Models/ReviewsModel.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';
import 'package:oreeed/UI/HomeUIComponent/ProductDetails.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:oreeed/resources/ApiHandler.dart';
import 'package:provider/provider.dart';

ApiResponse specialList;
ApiResponse flashSaleList;
ApiResponse favList;

class ProductRepo {
  ////////////////////////////////  Method for LogInWithOtp

  Future<ApiResponse> fetchTopSalesList() async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuFlashCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'top_sales',
          body: {"language_id": 1}).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final productsModel = productsModelFromMap(serverApiResponse.object);
          if (productsModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: productsModel.message,
                object: productsModel.product);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(productsModel.success),
                msg: productsModel.message);
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

  Future<ApiResponse> fetchSpecialList() async {
    ApiResponse apiResponse;
    try {
      if (specialList == null) {
        await ApiHandler().postMethodWithoutToken(
            url: baseuRL + 'specials',
            body: {"language_id": 1}).then((serverApiResponse) async {
          if (serverApiResponse.code == 1) {
            final productsModel =
                productsModelFromMap(serverApiResponse.object);
            if (productsModel.success == "1") {
              apiResponse = new ApiResponse(
                  code: 1,
                  msg: productsModel.message,
                  object: productsModel.product);
              specialList = apiResponse;
            } else {
              apiResponse = new ApiResponse(
                  code: int.parse(productsModel.success),
                  msg: productsModel.message);
              specialList = apiResponse;
            }
          } else {
            apiResponse =
                new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
            specialList = apiResponse;
          }
        });
      }
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
      specialList = apiResponse;
    }
    return specialList;
  }

  Future<ApiResponse> fetchFlashSaleList() async {
    ApiResponse apiResponse;
    try {
      if (flashSaleList == null) {
        print(
            "####### Back Track to BrandMenuFlashCategoryRepo => fetchFlashSaleList");

        await ApiHandler().postMethodWithoutToken(
            url: baseuRL + 'flash_seals',
            body: {"type": "flashsale"}).then((serverApiResponse) async {
          if (serverApiResponse.code == 1) {
            final productsModel =
                productsModelFromMap(serverApiResponse.object);
            print(
                "########### product ##########${productsModel.product.toString()}");
            //print("######### flashsale ##########");
            //print("######### message ##########${productsModel.message}");
            //print("######### success ########${productsModel.success}");
            //print("######### product #########${serverApiResponse.object}");
            if (productsModel.success == "1") {
              apiResponse = new ApiResponse(
                  code: 1,
                  msg: productsModel.message,
                  object: productsModel.product);
              flashSaleList = apiResponse;
            } else {
              apiResponse = new ApiResponse(
                  code: int.parse(productsModel.success),
                  msg: productsModel.message);
              flashSaleList = apiResponse;
            }
          } else {
            apiResponse =
                new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
            flashSaleList = apiResponse;
          }
        });
      }
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
      flashSaleList = apiResponse;
    }
    return flashSaleList;
  }

  Future<ApiResponse> fetchProductList(String router) async {
    ApiResponse apiResponse;
    try {
      if (favList == null) {
        await ApiHandler().postMethodWithoutToken(
            url: baseuRL + router,
            body: {"language_id": 1}).then((serverApiResponse) async {
          if (serverApiResponse.code == 1) {
            var products = json.decode(serverApiResponse.object.toString());
            final productsModel =
                productsModelFromMap(products['product_data'].toString());
            if (productsModel.success == "1") {
              apiResponse = new ApiResponse(
                  code: 1,
                  msg: productsModel.message,
                  object: productsModel.product);
              favList = apiResponse;
            } else {
              apiResponse = new ApiResponse(
                  code: int.parse(productsModel.success),
                  msg: productsModel.message,
                  object: []);
              favList = apiResponse;
            }
          } else {
            apiResponse = new ApiResponse(
                code: apiResponse.code, msg: apiResponse.msg, object: []);
            favList = apiResponse;
          }
        });
      }
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
      favList = apiResponse;
    }
    return favList;
  }

  Future<ApiResponse> fetchProductByCategory(String id) async {
    ApiResponse apiResponse;
    try {
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + "products_by_category",
          body: {
            "language_id": 1,
            "categories_id": id
          }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final productsModel = productsModelFromMap(serverApiResponse.object);
          if (productsModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: productsModel.message,
                object: productsModel.product);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(productsModel.success),
                msg: productsModel.message,
                object: []);
          }
        } else {
          apiResponse = new ApiResponse(
              code: apiResponse.code, msg: apiResponse.msg, object: []);
        }
      });
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> fetchReviewsList(int id) async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuFlashCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'getreviews',
          body: {
            "language_id": 1,
            "products_id": id
          }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final reviewsModel = reviewsModelFromMap(serverApiResponse.object);
          if (reviewsModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: reviewsModel.message,
                object: reviewsModel.reviewsList);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(reviewsModel.success),
                msg: reviewsModel.message);
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

  Future<ApiResponse> addReview(
      {userName, int userId, int productId, double rating, String body}) async {
    ApiResponse apiResponse;
    try {
      await ApiHandler()
          .postMethodWithoutToken(url: baseuRL + 'givereview', body: {
        "language_id": 1,
        "products_id": productId,
        "customers_name": userName,
        "customers_id": userId,
        "reviews_rating": rating,
        "reviews_read": body
      }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final reviewsModel = jsonDecode(serverApiResponse.object);
          if (reviewsModel['success'] == "1") {
            apiResponse =
                new ApiResponse(code: 1, msg: reviewsModel["message"]);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(reviewsModel['success'].toString()),
                msg: reviewsModel['message']);
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

  Future<ApiResponse> likeProduct(context, int productId, int userId) async {
    ApiResponse apiResponse;
    try {
      var productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      print(
          "########################### Back Track to BrandMenuFlashCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'likeproduct',
          body: {
            "liked_products_id": productId,
            "liked_customers_id": userId
          }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final reviewsModel = json.decode(serverApiResponse.object);
          if (reviewsModel['success'] == "1") {
            List myList = reviewsModel['liked_products_id'] as List;
            productsProvider.likedProducts = [];
            myList.forEach((element) {
              productsProvider.likedProducts.add(element);
            });
            productsProvider.likedProducts.toSet().toList();
            favs = productsProvider.likedProducts;
            apiResponse = new ApiResponse(
                code: 1, msg: reviewsModel['message'], object: favs);
          } else {
            myIds.removeWhere((element) => element == productId);

            apiResponse = new ApiResponse(
                code: int.parse(reviewsModel['success']),
                msg: reviewsModel['message']);
          }
        } else {
          myIds.removeWhere((element) => element == productId);

          apiResponse =
              new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
        }
        return apiResponse;
      });
    } catch (error) {
      myIds.removeWhere((element) => element == productId);

      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }

  Future<ApiResponse> unLikeProduct(context, int productId, int userId) async {
    ApiResponse apiResponse;
    try {
      var productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'unlikeproduct',
          body: {
            "liked_products_id": productId,
            "liked_customers_id": userId
          }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final reviewsModel = json.decode(serverApiResponse.object);
          if (reviewsModel['success'] == "1") {
            List myList = reviewsModel['liked_products_id'] as List;
            productsProvider.likedProducts = [];
            myList.forEach((element) {
              productsProvider.likedProducts.add(element);
            });
            productsProvider.likedProducts.toSet().toList();
            favs = productsProvider.likedProducts;
            apiResponse = new ApiResponse(
                code: 1, msg: reviewsModel['message'], object: favs);
          } else {
            myIds.add(productId);

            apiResponse = new ApiResponse(
                code: int.parse(reviewsModel['success']),
                msg: reviewsModel['message']);
          }
        } else {
          myIds.add(productId);

          apiResponse =
              new ApiResponse(code: apiResponse.code, msg: apiResponse.msg);
        }
        myIds.add(productId);

        return apiResponse;
      });
    } catch (error) {
      apiResponse = new ApiResponse(code: 0, msg: "Network Error");
    }
    return apiResponse;
  }
}
