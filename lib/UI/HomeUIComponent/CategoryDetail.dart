import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Library/carousel_pro/carousel_pro.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/CategoryModel.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:oreeed/UI/HomeUIComponent/Search.dart';
import 'package:oreeed/UI/Products/GridView/VerticalGProductsList.dart';
import 'package:oreeed/UI/Products/ListView/HorizontalProductsList.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:shimmer/shimmer.dart';

class categoryDetail extends StatefulWidget {
  final Category category;
  categoryDetail({this.category});
  @override
  _categoryDetailState createState() => _categoryDetailState();
}

/// if user click icon in category layout navigate to categoryDetail Layout
class _categoryDetailState extends State<categoryDetail> {
  bool loadImage = true;

  /// custom text variable is make it easy a custom textStyle black font
  static var _customTextStyleBlack = TextStyle(
      fontFamily: "Montserrat",
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 15.0);

  /// Custom text blue in variable
  static var _customTextStyleBlue = TextStyle(
      fontFamily: "Montserrat",
      color: Color(0xFF6991C7),
      fontWeight: FontWeight.w700,
      fontSize: 15.0);

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
    _products = ProductRepo()
        .fetchProductByCategory(widget.category.categoriesId.toString());
    super.initState();
  }

  /// All Widget Component layout
  @override
  Widget build(BuildContext context) {
    /// imageSlider in header layout category detail
    var _imageSlider = Padding(
      padding: const EdgeInsets.only(
          top: 0.0, left: 10.0, right: 10.0, bottom: 35.0),
      child: Container(
        height: 180.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          dotColor: Colors.transparent,
          dotSize: 5.5,
          dotSpacing: 16.0,
          dotBgColor: Colors.transparent,
          showIndicator: false,
          overlayShadow: false,
          autoplay: false,
          overlayShadowColors: Colors.white.withOpacity(0.9),
          overlayShadowSize: 0.9,
          images: [
            CachedNetworkImageProvider(imageUrl + widget.category.image)
          ],
        ),
      ),
    );

    /// Variable Category (Sub Category)
    var _subCategory = widget.category.childCategories.isNotEmpty
        ? Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('subCategory'),
                        style: _customTextStyleBlack,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       PageRouteBuilder(
                      //           pageBuilder: (_, __, ___) => new promoDetail(),
                      //           transitionDuration: Duration(milliseconds: 900),
                      //
                      //           /// Set animation Opacity in route to detailProduk layout
                      //           transitionsBuilder: (_,
                      //               Animation<double> animation,
                      //               __,
                      //               Widget child) {
                      //             return Opacity(
                      //               opacity: animation.value,
                      //               child: child,
                      //             );
                      //           }),
                      //     );
                      //   },
                      //   child: Text(
                      //     AppLocalizations.of(context).tr('seeMore'),
                      //     style: _customTextStyleBlue.copyWith(
                      //         color: Colors.black26),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(right: 10.0, top: 15.0),
                    height: 55.0,
                    child: ListView.builder(
                      itemCount: widget.category.childCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, top: 8, bottom: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _products = ProductRepo()
                                    .fetchProductByCategory(widget.category
                                        .childCategories[index].categoriesId
                                        .toString());
                              });
                            },
                            child: Container(
                              height: 35.0,
                              width: widget.category.childCategories[index]
                                      .categoriesName.length +
                                  MediaQuery.of(context).size.width * .25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4.5,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Center(
                                  child: Text(
                                    widget.category.childCategories[index]
                                        .categoriesName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Montserrat"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();

    /// Variable item Discount with Card
    var _itemDiscount = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('itemDiscount'),
                  style: _customTextStyleBlack,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              new VerticalGProductsList(
                                  title: AppLocalizations.of(context)
                                      .tr('itemDiscount'),
                                  router: "specials"),
                          transitionDuration: Duration(milliseconds: 900),

                          /// Set animation Opacity in route to detailProduk layout
                          transitionsBuilder: (_, Animation<double> animation,
                              __, Widget child) {
                            return Opacity(
                              opacity: animation.value,
                              child: child,
                            );
                          }),
                    );
                  },
                  child: Text(AppLocalizations.of(context).tr('seeMore'),
                      style: _customTextStyleBlue),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 300.0,
              child: HorizontalProductsList(router: "top_sales"),
            ),
          )
        ],
      ),
    );

    /// Variable item Popular with Card
    var _itemPopular = Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('itemPopular'),
                    style: _customTextStyleBlack,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new VerticalGProductsList(
                                    title: AppLocalizations.of(context)
                                        .tr('itemPopular'),
                                    router: "top_sales"),
                            transitionDuration: Duration(milliseconds: 900),

                            /// Set animation Opacity in route to detailProduk layout
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }),
                      );
                    },
                    child: Text(AppLocalizations.of(context).tr('seeMore'),
                        style: _customTextStyleBlue),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                height: 300.0,
                child:
                    HorizontalProductsList(router: "top_selling_of_the_week"),
              ),
            )
          ],
        ),
      ),
    );

    /// Variable New Items with Card
    var _itemNew = Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('newItem'),
                    style: _customTextStyleBlack,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new VerticalGProductsList(
                                    title: AppLocalizations.of(context)
                                        .tr('newItem'),
                                    router: "new_arrival"),
                            transitionDuration: Duration(milliseconds: 900),

                            /// Set animation Opacity in route to detailProduk layout
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }),
                      );
                    },
                    child: Text(AppLocalizations.of(context).tr('seeMore'),
                        style: _customTextStyleBlue),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(right: 10.0, bottom: 15.0),
                height: 300.0,
                child: HorizontalProductsList(router: "new_arrival"),
              ),
            )
          ],
        ),
      ),
    );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Navigator.of(context).pop();
          }
          print("${details.primaryVelocity}");
        },
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new searchAppbar(),
                    ),
                  );
                },
                icon: Icon(Icons.search, color: Color(0xFF6991C7)),
              ),
            ],
            centerTitle: true,
            title: Text(
              widget.category.categoriesName,
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

          /// For call a variable include to body
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _imageSlider,
                  _subCategory,
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
                            if (apiResponse.code == 1 &&
                                apiResponse.object.isNotEmpty) {
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
                                    (index) => ItemGrid(
                                        product: apiResponse.object[index]),
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

                  // _itemDiscount,
                  // _itemPopular,
                  // _itemNew
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Loading Item Card Animation Constructor

class loadingMenuItemDiscountCard extends StatelessWidget {
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
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                  width: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 185.0,
                            width: 160.0,
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
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "",
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

/// Loading Item Card Animation Constructor

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
                  width: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 185.0,
                        width: 160.0,
                        color: Colors.black12,
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
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "",
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
