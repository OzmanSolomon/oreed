import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:oreeed/UI/HomeUIComponent/ProductDetails.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class VerticalGProductsList extends StatefulWidget {
  final String title;
  final String router;
  const VerticalGProductsList({Key key, this.title, this.router})
      : super(key: key);
  @override
  _VerticalGProductsListState createState() => _VerticalGProductsListState();
}

class _VerticalGProductsListState extends State<VerticalGProductsList> {
  bool isLoading = true;

  Future<ApiResponse> _products;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    // TODO: implement initState
    _products = ProductRepo().fetchProductList(widget.router);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Item Search in bottom of appbar
    var _search = Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: Colors.grey.withOpacity(0.2), width: 1.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Theme(
            data: ThemeData(hintColor: Colors.transparent),
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black38,
                    size: 18.0,
                  ),
                  hintText: AppLocalizations.of(context).tr('description'),
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 14.0)),
            ),
          ),
        ));

    /// Grid Item a product
    var _grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
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
                      if (apiResponse.code == 1) {
                        return Container(
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
                              apiResponse.object.length,
                              (index) =>
                                  ItemGrid(product: apiResponse.object[index]),
                            ),
                          ),
                        );
                      } else {
                        return NoData();
                      }
                      break;
                    default:
                      return null;
                      break;
                  }
                }),
          ],
        ),
      ),
    );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        /// Appbar item
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${widget.title}",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Colors.black54,
                fontFamily: "Montserrat"),
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF6991C7),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              /// Calling search and grid variable
              children: <Widget>[
                _search,
                _grid,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalGProductsListWithoutHeader extends StatefulWidget {
  final String title;
  final String router;
  const VerticalGProductsListWithoutHeader({Key key, this.title, this.router})
      : super(key: key);
  @override
  _VerticalGProductsListWithoutHeaderState createState() =>
      _VerticalGProductsListWithoutHeaderState();
}

class _VerticalGProductsListWithoutHeaderState
    extends State<VerticalGProductsListWithoutHeader> {
  bool isLoading = true;
  Future<ApiResponse> _products;
  List<Product> _productList = [];

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    // TODO: implement initState
    _products = ProductRepo().fetchProductList(widget.router);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Grid Item a product
    var _grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
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
                      if (apiResponse.code == 1) {
                        return Container(
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
                              apiResponse.object.length,
                              (index) => ItemGrid(product: apiResponse[index]),
                            ),
                          ),
                        );
                      } else {
                        return NoData();
                      }
                      break;
                    default:
                      return null;
                      break;
                  }
                }),
          ],
        ),
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

/// ItemGrid class
class ItemGrid extends StatelessWidget {
  @override
  Product product;
  ItemGrid({this.product});
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new ProductDetails(product),
            transitionDuration: Duration(milliseconds: 750),

            /// Set animation with opacity
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 2.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: mediaQueryData.size.height / 3.3,
                      width: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "http://oreeed.com/" + product.productsImage),
                              fit: BoxFit.cover)),
                    ),
                    product.discountPrice != null
                        ? Container(
                            height: 25.5,
                            width: 55.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFD7124A),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(5.0))),
                            child: Center(
                                child: Text(
                              "${product.discountPrice}%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                          )
                        : Container()
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    product.productsName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    product.productsPrice,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            product.rating,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        product.isOriginal.toString() == "1" ? "original" : "",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class loadingMenuItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 205.0,
                            width: 185.0,
                            color: Colors.black12,
                          ),
                          Container(
                            height: 25.5,
                            width: 65.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFD7124A),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(5.0))),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 12.0),
                          child: Container(
                            height: 9.5,
                            width: 130.0,
                            color: Colors.black12,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 10.0),
                          child: Container(
                            height: 9.5,
                            width: 80.0,
                            color: Colors.black12,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 7.0, bottom: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14.0,
                                )
                              ],
                            ),
                            Container(
                              height: 8.0,
                              width: 30.0,
                              color: Colors.black12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget isLoadinging({BuildContext context, int count}) {
  return GridView.count(
    shrinkWrap: true,
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 15.0,
    childAspectRatio: 0.545,
    crossAxisCount: 2,
    primary: false,
    children: List.generate(
      /// Get data in PromotionDetail.dart (ListItem folder)
      count,
      (index) => loadingMenuItemCard(),
    ),
  );
}

class FavoriteProductsList extends StatefulWidget {
  final String title;
  final String router;
  const FavoriteProductsList({Key key, this.title, this.router})
      : super(key: key);
  @override
  _FavoriteProductsListState createState() => _FavoriteProductsListState();
}

class _FavoriteProductsListState extends State<FavoriteProductsList> {
  bool isLoading = true;
  Future<ApiResponse> _products;
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
    // TODO: implement initState
    _products = ProductRepo().fetchProductList(widget.router);
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
                        if (apiResponse.code == 1) {
                          List<Product> myList = apiResponse.object;
                          _productList.clear();
                          for (int i = 0; i < myList.length - 1; i++) {
                            if (productProvider.likedProductsLists
                                .contains(myList[i].id)) {
                              _productList.add(myList[i]);
                            }
                          }
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
                                      (index) => ItemGrid(
                                          product: _productList[index]),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width,
                                  child: NoData());
                        } else {
                          return NoData();
                        }
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
