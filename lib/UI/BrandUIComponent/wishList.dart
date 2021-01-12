import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:oreeed/UI/HomeUIComponent/Search.dart';
import 'package:oreeed/UI/Products/GridView/VerticalGProductsList.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:provider/provider.dart';

bool loadImage = true;

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  // Future<ApiResponse> _categories;
  @override
  void initState() {
    super.initState();
    // _categories = BrandMenuCategoryRepo().fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    /// Component appbar
    var _appbar = AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          AppLocalizations.of(context).tr('whishlist'),
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 20.0,
              color: Colors.black54,
              fontWeight: FontWeight.w700),
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => new searchAppbar(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(
              Icons.search,
              size: 27.0,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );

    var data = EasyLocalizationProvider.of(context).data;
    var lineTxtStyle = TextStyle(
        fontFamily: "Montserrat",
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.grey);
    return EasyLocalizationProvider(
      data: data,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Scaffold(
          /// Calling variable appbar
          appBar: _appbar,
          body: userId != null
              ? _imageLoaded(context)
              : Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 60,
                        //   backgroundColor: appYellow,
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Guest, Mode",
                          style: lineTxtStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Try Login Or Register",
                          style: lineTxtStyle,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  /// Calling ImageLoaded animation for set layout
  Widget _imageLoaded(BuildContext context) {
    return Container(
      color: Colors.white,
      child: WishListBody(
          // title: AppLocalizations.of(context).tr('customer_liked_products'),
          // router: "top_sales"
          ),
    );
  }
}

class WishListBody extends StatefulWidget {
  @override
  _WishListBodyState createState() => _WishListBodyState();
}

class _WishListBodyState extends State<WishListBody> {
  bool isLoading = true;
  Future _products;
  List<Product> _productList = [];

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    if (userId != null) {
      _products = BrandMenuCategoryRepo().fetchFavList(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Grid Item a product
    var _grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child:
            Consumer<ProductsProvider>(builder: (context, productProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: _products,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var apiResponse = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return isLoadinging(context: context, count: 6);
                        break;
                      case ConnectionState.waiting:
                        return isLoadinging(context: context, count: 6);
                        break;
                      case ConnectionState.active:
                        return isLoadinging(context: context, count: 6);
                        break;
                      case ConnectionState.done:
                        List<Product> myList = apiResponse
                            .map<Product>((json) => Product.fromMap(json))
                            .toList();
                        _productList = myList;
                        // for (int i = 0; i < myList.length - 1; i++) {
                        //   if (productProvider.likedProductsLists
                        //       .contains(myList[i].id)) {
                        //     _productList.add(myList[i]);
                        //   }
                        // }
                        // final finalList =
                        //     _productList.map((e) => e.productsId).toSet();
                        // _productList.retainWhere((x) => finalList.remove(x));
                        return _productList.isNotEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.0, vertical: 10.0),
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 15.0,
                                  childAspectRatio: 0.545,
                                  crossAxisCount: 2,
                                  primary: false,
                                  children: List.generate(
                                    /// Get data in flashSaleItem.dart (ListItem folder)
                                    _productList.length,
                                    (index) =>
                                        ItemGrid(product: _productList[index]),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                child: NoData());

                        break;
                      default:
                        return null;
                        break;
                    }
                  }),
            ],
          );
        }),
      ),
    );

    return SingleChildScrollView(
      child: Container(
        child: Column(
          /// Calling search and grid variable
          children: <Widget>[
            _grid,
          ],
        ),
      ),
    );
  }
}
