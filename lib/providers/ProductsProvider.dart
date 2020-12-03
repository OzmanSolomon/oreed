import 'package:flutter/material.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/GenralWidgets/ServerProcessLoader.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';

// used OTPProvider instedbecuase of an error in the scaffoldkey
//not used lines are commented

class ProductsProvider with ChangeNotifier {
  ProductsProvider() {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Fetching Searchable Items...");
    fetchProductList();
  }

  DatabaseHelper helper = DatabaseHelper();
  bool isSearching = false;
  bool isSearchingReady = false;
  List<int> _likedProducts = [];
  List<Product> productList = [];
  List<Product> _filteredProductList = [];
  List<Product> get filteredProductList => _filteredProductList;
  List<int> get likedProductsLists => _likedProducts;

  void addToLikedProducts(int id) {
    if (!likedProductsLists.contains(id)) {
      _likedProducts.add(id);
    }

    _likedProducts.toSet().toList();
    notifyListeners();
  }

  void deleteFromLikedProducts(int id) {
    _likedProducts.remove(id);
    _likedProducts.toSet().toList();
    notifyListeners();
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
    _likedProducts.clear();
    _likedProducts = [];
    notifyListeners();
  }

  void setLikedProducts(int id) {
    print("trying to add item with id :$id");
    _likedProducts.add(id);
    notifyListeners();
  }

  void fetchProductList() async {
    try {
      ProductRepo().fetchProductList("most_liked").then((apiResponse) {
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              List<Product> products = apiResponse.object;
              if (products.isNotEmpty != null && products.isNotEmpty) {
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
          productList.clear();
          productList = [];
          notifyListeners();
        }
      });
    } catch (Exception) {
      productList.clear();
      productList = [];
      notifyListeners();
    }
  }

  void addReview(
      {GlobalKey<ScaffoldState> scaffoldKey,
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
              userId: userId, productId: productId, rating: rating, body: body)
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
