import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Models/ShippingAddressModel.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:oreeed/providers/CheckOutProvider.dart';
import 'package:oreeed/resources/ApiHandler.dart';

class CheckOutRepo {
  ////////////////////////////////  Method for LogInWithOtp
  ///
  ///

  Future<ApiResponse> fetchAddressList(
      {String lang = "1", String userId = "15"}) async {
    ApiResponse apiResponse;
    try {
      print(
          "########################### Back Track to BrandMenuCategoryRepo => login");
      await ApiHandler().postMethodWithoutToken(
          url: baseuRL + 'getalladdress',
          body: {
            "customers_id": userId
          }).then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final shippingAddressModel =
              shippingAddressModelFromMap(serverApiResponse.object);

          if (shippingAddressModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: shippingAddressModel.message,
                object: shippingAddressModel.myAddresses);
                
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(shippingAddressModel.success),
                msg: shippingAddressModel.message);
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

  Future<ApiResponse> checkout(FullOrder fullOrder) async {
    ApiResponse apiResponse;
    try {
      print(
          "################# Back Track to BrandMenuCategoryRepo => addNewShippingAddress");
      await ApiHandler()
          .postMethodWithoutToken(
              url: baseuRL + 'addtoorder', body: fullOrder.toMap())
          .then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final fullOrderModel = productsModelFromMap(serverApiResponse.object);
          if (fullOrderModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: fullOrderModel.message,
                object: fullOrderModel.product);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(fullOrderModel.success),
                msg: fullOrderModel.message);
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

  Future<ApiResponse> addNewShippingAddress({DeliveryAddress address}) async {
    ApiResponse apiResponse;
    try {
      print(
          "################# Back Track to BrandMenuCategoryRepo => addNewShippingAddress");
      await ApiHandler()
          .postMethodWithoutToken(
              url: baseuRL + 'addshippingaddress', body: address.toMap())
          .then((serverApiResponse) async {
        if (serverApiResponse.code == 1) {
          final shippingAddressModel =
              shippingAddressModelFromMap(serverApiResponse.object);
          if (shippingAddressModel.success == "1") {
            apiResponse = new ApiResponse(
                code: 1,
                msg: shippingAddressModel.message,
                object: shippingAddressModel.myAddresses);
          } else {
            apiResponse = new ApiResponse(
                code: int.parse(shippingAddressModel.success),
                msg: shippingAddressModel.message);
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
