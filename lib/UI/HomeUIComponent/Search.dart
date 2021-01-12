import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:oreeed/UI/HomeUIComponent/ProductDetails.dart';
import 'package:oreeed/UI/Products/ListView/HorizontalProductsList.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:provider/provider.dart';

class searchAppbar extends StatefulWidget {
  @override
  _searchAppbarState createState() => _searchAppbarState();
}

class _searchAppbarState extends State<searchAppbar> {
  Future<ApiResponse> _products;
  final TextEditingController _filter = new TextEditingController();
  List<Product> productList = [];
  List<Product> filteredProductList = [];

  @override
  void initState() {
    super.initState();
    _products = ProductRepo().fetchProductList("most_liked");
  }

  @override
  Widget build(BuildContext context) {
    /// Item TextFromField Search
    var _search = Padding(
      padding: const EdgeInsets.only(top: 35.0, right: 20.0, left: 20.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: Consumer<ProductsProvider>(
                  builder: (context, productProvider, _) {
                return TextFormField(
                  controller: _filter,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Color(0xFF6991C7),
                        size: 28.0,
                      ),
                      hintText: AppLocalizations.of(context).tr('findYouWant'),
                      hintStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400)),
                  onChanged: (v) {
                    productProvider.setSearchingStatus(true);
                    productProvider.doSearchText(v.trim());
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );

    /// Item Favorite Item with Card item
    var _favorite = Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 250.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                AppLocalizations.of(context).tr('favorite'),
                style:
                    TextStyle(fontFamily: "Montserrat", color: Colors.black26),
              ),
            ),
            Expanded(
              child: HorizontalProductsList(router: "top_selling_of_the_week"),
            ),
          ],
        ),
      ),
    );

    /// Popular Keyword Item
    var _sugestedText = Container(
      height: 145.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              AppLocalizations.of(context).tr('popularity'),
              style: TextStyle(fontFamily: "Montserrat", color: Colors.black26),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Expanded(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(right: 10.0, top: 15.0),
              height: 55.0,
              child: FutureBuilder(
                  future: _products,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var apiResponse = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                        break;
                      case ConnectionState.waiting:
                        return Container();
                        break;
                      case ConnectionState.active:
                        return Container();
                        break;
                      case ConnectionState.done:
                        if (apiResponse.code == 1) {
                          return ListView.builder(
                            itemCount: apiResponse.object
                                .length, //widget.category.childCategories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new ProductDetails(
                                              apiResponse.object[index]),
                                      transitionDuration:
                                          Duration(milliseconds: 750),

                                      /// Set animation with opacity
                                      transitionsBuilder: (_,
                                          Animation<double> animation,
                                          __,
                                          Widget child) {
                                        return Opacity(
                                          opacity: animation.value,
                                          child: child,
                                        );
                                      }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0, top: 8, bottom: 8),
                                  child: Container(
                                    height: 25.0,
                                    width: apiResponse
                                                .object[index].productsName
                                                .trim()
                                                .length <
                                            10
                                        ? MediaQuery.of(context).size.width *
                                            .25
                                        : MediaQuery.of(context).size.width *
                                            .75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Center(
                                        child: Text(
                                          apiResponse
                                              .object[index].productsName,
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

              //     ListView.builder(
              //   itemCount: 5, //widget.category.childCategories.length,
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Padding(
              //       padding: const EdgeInsets.only(
              //           left: 5.0, right: 5.0, top: 8, bottom: 8),
              //       child: Container(
              //         height: 35.0,
              //         width: 18 + MediaQuery.of(context).size.width * .25,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.1),
              //               blurRadius: 4.5,
              //               spreadRadius: 1.0,
              //             )
              //           ],
              //         ),
              //         child: Container(
              //           padding: EdgeInsets.only(left: 10, right: 10),
              //           child: Center(
              //             child: Text(
              //               "${index}-yyy"
              //               // widget.category.childCategories[index]
              //               //     .categoriesName
              //               ,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(
              //                   color: Colors.black54,
              //                   fontFamily: "Montserrat"),
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
            //     ListView(
            //   scrollDirection: Axis.horizontal,
            //   children: <Widget>[
            //     Padding(padding: EdgeInsets.only(left: 20.0)),
            //     KeywordItem(
            //       title: AppLocalizations.of(context).tr('searchTitle1'),
            //       title2: AppLocalizations.of(context).tr('searchTitle2'),
            //     ),
            //     KeywordItem(
            //       title: AppLocalizations.of(context).tr('searchTitle3'),
            //       title2: AppLocalizations.of(context).tr('searchTitle4'),
            //     ),
            //     KeywordItem(
            //       title: AppLocalizations.of(context).tr('searchTitle5'),
            //       title2: AppLocalizations.of(context).tr('searchTitle6'),
            //     ),
            //     KeywordItem(
            //       title: AppLocalizations.of(context).tr('searchTitle7'),
            //       title2: AppLocalizations.of(context).tr('searchTitle8'),
            //     ),
            //   ],
            // )
          )
        ],
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
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Consumer<ProductsProvider>(
                builder: (context, productProvider, _) {
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _search,
                      Flexible(
                        child: Visibility(
                          visible: productProvider.filteredProductList.isEmpty,
                          child: Column(
                            children: [
                              _sugestedText,
                              _favorite,
                              Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 30.0, top: 2.0))
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Visibility(
                          visible: !productProvider.filteredProductList.isEmpty,
                          child: Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 100,
                                    child: new ListTile(
                                      leading: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12
                                                      .withOpacity(0.1),
                                                  blurRadius: 0.5,
                                                  spreadRadius: 0.1)
                                            ]),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${imageUrl + productProvider.filteredProductList[index].productsImage}",
                                          // height: 130.0,
                                          // width: 120.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(productProvider
                                          .filteredProductList[index]
                                          .productsName),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  new ProductDetails(
                                                      productProvider
                                                              .filteredProductList[
                                                          index]),
                                              transitionDuration:
                                                  Duration(milliseconds: 900),

                                              /// Set animation Opacity in route to detailProduk layout
                                              transitionsBuilder: (_,
                                                  Animation<double> animation,
                                                  __,
                                                  Widget child) {
                                                return Opacity(
                                                  opacity: animation.value,
                                                  child: child,
                                                );
                                              }),
                                        );
                                      },
                                      subtitle: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("price : "),
                                              Text(productProvider
                                                  .filteredProductList[index]
                                                  .productsPrice),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("qty : "),
                                              Text(productProvider
                                                  .filteredProductList[index]
                                                  .productsQuantity
                                                  .toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                                itemCount:
                                    productProvider.filteredProductList.isEmpty
                                        ? 0
                                        : productProvider
                                            .filteredProductList.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Popular Keyword Item class
class KeywordItem extends StatelessWidget {
  @override
  String title, title2;

  KeywordItem({this.title, this.title2});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 3.0),
          child: Container(
            height: 29.5,
            width: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.5,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.black54, fontFamily: "Montserrat"),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 15.0)),
        Container(
          height: 29.5,
          width: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Center(
            child: Text(
              title2,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///Favorite Item Card
class FavoriteItem extends StatelessWidget {
  String image, Rating, Salary, title, sale;

  FavoriteItem({this.image, this.Rating, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
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
                Container(
                  height: 120.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    title,
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
                    Salary,
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
                            Rating,
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
                        sale,
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
