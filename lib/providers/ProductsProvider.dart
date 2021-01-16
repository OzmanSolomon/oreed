import 'package:flutter/material.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/GenralWidgets/ServerProcessLoader.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/UI/HomeUIComponent/ProductDetails.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';

// used OTPProvider instedbecuase of an error in the scaffoldkey
//not used lines are commented

class ProductsProvider with ChangeNotifier {
  ProductsProvider() {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Fetching Searchable Items...");
    // fetchProductList();
  }

  DatabaseHelper helper = DatabaseHelper();
  bool isSearching = false;
  bool isSearchingReady = false;
  List<dynamic> likedProducts = [];
  List<Product> productList = [];
  List<Product> _filteredProductList = [];
  List<Product> get filteredProductList => _filteredProductList;
  List<dynamic> get likedProductsLists => likedProducts;

  void addToLikedProducts(
    context,
    int id,
    userId,
  ) async {
    processList.add(id);
    notifyListeners();
    var response = ProductRepo().likeProduct(context, id, userId);
    response.then((onValue) {
      processList.remove(id);
      notifyListeners();
    });
  }

  void deleteFromLikedProducts(context, int id, userId) {
    processList.add(id);
    notifyListeners();
    var response = ProductRepo().unLikeProduct(context, id, userId);
    response.then((onValue) {
      processList.remove(id);
      notifyListeners();
    });
  }

  void doSearchText(String searchKey) {
    if (searchKey.isNotEmpty && productList.isNotEmpty) {
      _filteredProductList.clear();
      _filteredProductList = [];
      productList.forEach((product) {
        if (product.productsName
            .toLowerCase()
            .contains(searchKey.toLowerCase())) {
          _filteredProductList.add(product);
        }
      });
    } else {
      _filteredProductList.clear();
      _filteredProductList = [];
    }

    notifyListeners();
  }

  void setSearchingStatus(bool flag) {
    isSearching = flag;
    notifyListeners();
  }

  void resetLikedProducts() {
    likedProducts.clear();
    likedProducts = [];
    notifyListeners();
  }

  void setLikedProducts(int id) {
    print("trying to add item with id :$id");
    likedProducts.add(id);
    notifyListeners();
  }

  Future<ApiResponse> fetchProductList() async {
    ApiResponse myApiResponse;
    try {
      await ProductRepo()
          .fetchProductList("get_all_products")
          .then((apiResponse) {
        myApiResponse = apiResponse;
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              List<Product> products = apiResponse.object;
              if (products != null && products.isNotEmpty) {
                productList.clear();
                productList.addAll(products);
                isSearchingReady = true;
              }
              notifyListeners();
              break;
            default:
              notifyListeners();
              break;
          }
        } else {
          myApiResponse = new ApiResponse(code: 0, msg: "Network Error");

          productList.clear();
          productList = [];
          notifyListeners();
        }
      });
    } catch (Exception) {
      myApiResponse = new ApiResponse(code: 0, msg: "Network Error");

      productList.clear();
      productList = [];
      notifyListeners();
    }
    return myApiResponse;
  }

  void addReview(
      {Product product,
      GlobalKey<ScaffoldState> scaffoldKey,
      userName,
      int userId,
      int productId,
      double rating,
      String body}) async {
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );

    try {
      ProductRepo()
          .addReview(
              userName: userName,
              userId: userId,
              productId: productId,
              rating: rating,
              body: body)
          .then((apiResponse) async {
        Navigator.pop(scaffoldKey.currentContext);
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          if (apiResponse.code == 1) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Container(
                height: 45,
                child: Center(
                  child: Text("${apiResponse.msg}"),
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: appBlue,
              elevation: 5,
              behavior: SnackBarBehavior.floating,
            ));
            // Navigator.of(scaffoldKey.currentContext).push(PageRouteBuilder(
            //     pageBuilder: (_, __, ___) => new ProductDetails(product),
            //     transitionDuration: Duration(milliseconds: 750),

            //     /// Set animation with opacity
            //     transitionsBuilder:
            //         (_, Animation<double> animation, __, Widget child) {
            //       return Opacity(
            //         opacity: animation.value,
            //         child: child,
            //       );
            //     }));
          } else {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      Navigator.pop(scaffoldKey.currentContext);
      Navigator.pop(scaffoldKey.currentContext);
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: Exception.toString(),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }
}
