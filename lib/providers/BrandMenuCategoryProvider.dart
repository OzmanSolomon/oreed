import 'package:flutter/material.dart';
import 'package:oreeed/Models/CategoryModel.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';

// used OTPProvider instedbecuase of an error in the scaffoldkey
//not used lines are commented

class BrandMenuCategoryProvider with ChangeNotifier {
  BrandMenuCategoryProvider() {
    fetchCategoryList();
    fetchMenuList();
    fetchWeekPromotionList();
    fetchFlashSaleList();
    fetchRecommendedList();
  }

  bool _isLoadingCategories = false;
  bool _isLoadingMenu = false;
  bool _isLoadingWeekPromotion = false;
  bool _isLoadingFlashSale = false;
  bool _isLoadingRecommended = false;

  List<Category> _categoryList = [];
  List<Category> _menuList = [];
  List<Category> _weekPromotionList = [];
  List<Category> _flashSaleList = [];
  List<Category> _recommendedList = [];

  Category _selectedCategory;
  Category _selectedMenuItem;
  Category _selectedWeekPromotion;
  Category _selectedFlashSale;
  Category _selectedRecommendedItem;

  bool get isLoadingCategories => _isLoadingCategories;
  bool get isLoadingMenu => _isLoadingMenu;
  bool get isLoadingWeekPromotion => _isLoadingWeekPromotion;
  bool get isLoadingFlashSale => _isLoadingFlashSale;
  bool get isLoadingRecommended => _isLoadingRecommended;

  List<Category> get categoryList => _categoryList;
  List<Category> get menuList => _menuList;
  List<Category> get weekPromotionList => _weekPromotionList;
  List<Category> get flashSaleList => _flashSaleList;
  List<Category> get recommendedList => _recommendedList;

  Category get selectedCategory => _selectedCategory;
  Category get selectedMenuItem => _selectedMenuItem;
  Category get selectedWeekPromotion => _selectedWeekPromotion;
  Category get selectedFlashSale => _selectedFlashSale;
  Category get selectedRecommendedItem => _selectedRecommendedItem;

  void fetchCategoryList() async {
    try {
      BrandMenuCategoryRepo().fetchCategoryList().then((apiResponse) {
        print("BrandMenuCategoryRepo => fetchCategoryList");
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              List<Category> category = apiResponse.object;
              print("BrandMenuCategoryRepo => fetchCategoryList");
              category.forEach((cat) {
                print("BrandMenuCategoryRepo => fetchCategoryList");
                if (!_categoryList.contains(cat)) {
                  print("contains => Matched => $cat");
                  print("contains => Matched => ${_categoryList.length}");
                  _categoryList.add(cat);
                }
              });
              notifyListeners();
              break;
            default:
              print("default stat _CategoryList ${_categoryList.length}");
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _categoryList = [];
      notifyListeners();
    }

    print("_categoryList length is after addition");
    print(_categoryList.length);
  }

  void fetchMenuList() async {
    try {
      BrandMenuCategoryRepo().fetchCategoryList().then((apiResponse) {
        print("BrandMenuCategoryRepo => fetchCategoryList");
        if (apiResponse != null) {
          print("BrandMenuCategoryRepo => fetchCategoryList => if() ");
          switch (apiResponse.code) {
            case 1:
              print(
                  "BrandMenuCategoryRepo => fetchCategoryList => if() => switch()");
              List<Category> category = apiResponse.object;
              print("The Current Inserted Country is ${category.length} ");
              _categoryList.addAll(category);
              notifyListeners();
              break;
            default:
              _categoryList = [];
              notifyListeners();
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _categoryList = [];
      notifyListeners();
    }

    print("_categoryList length is after addition");
    print(_categoryList.length);
  }

  void fetchWeekPromotionList() async {
    try {
      BrandMenuCategoryRepo().fetchCategoryList().then((apiResponse) {
        print("BrandMenuCategoryRepo => fetchCategoryList");
        if (apiResponse != null) {
          print("BrandMenuCategoryRepo => fetchCategoryList => if() ");
          switch (apiResponse.code) {
            case 1:
              print(
                  "BrandMenuCategoryRepo => fetchCategoryList => if() => switch()");

              List<Category> category = apiResponse.object;
//              for (List<Category> category in apiResponse.object) {
              print("The Current Inserted Country is ${category.length} ");
//                print(category);
              _categoryList.addAll(category);
//              }
              notifyListeners();
              break;
            default:
              _categoryList = [];
              notifyListeners();
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _categoryList = [];
      notifyListeners();
    }

    print("_categoryList length is after addition");
    print(_categoryList.length);
  }

  void fetchFlashSaleList() async {
    try {
      BrandMenuCategoryRepo().fetchCategoryList().then((apiResponse) {
        print("BrandMenuCategoryRepo => fetchCategoryList");
        if (apiResponse != null) {
          print("BrandMenuCategoryRepo => fetchCategoryList => if() ");
          switch (apiResponse.code) {
            case 1:
              List<Category> category = apiResponse.object;
              _categoryList.addAll(category);
              notifyListeners();
              break;
            default:
              _categoryList = [];
              notifyListeners();
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _categoryList = [];
      notifyListeners();
    }
  }

  void fetchRecommendedList() async {
    try {
      BrandMenuCategoryRepo().fetchCategoryList().then((apiResponse) {
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              List<Category> category = apiResponse.object;
              _categoryList.addAll(category);
              notifyListeners();
              break;
            default:
              _categoryList = [];
              notifyListeners();
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _categoryList = [];
      notifyListeners();
    }
  }
}
