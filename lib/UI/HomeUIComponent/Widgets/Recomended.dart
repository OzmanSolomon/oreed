import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization.dart';
import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Models/ProductsModel.dart';
import 'package:oreed/Services/ProductRepo.dart';
import 'package:oreed/UI/BrandUIComponent/NoData.dart';
import 'package:oreed/UI/HomeUIComponent/DetailProduct.dart';

class RecommendedList extends StatefulWidget {
  @override
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  Future<ApiResponse> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductRepo().fetchSpecialList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              AppLocalizations.of(context).tr('recomended'),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
          ),

          FutureBuilder(
              future:
                  _products, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var apiResponse = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return TryAgainLater();
                    break;
                  case ConnectionState.waiting:
                    return Container(
                      child: LoaderFetchingData(),
                      height: 50,
                    );
                    break;
                  case ConnectionState.active:
                    return Container(
                      child: LoaderFetchingData(),
                      height: 50,
                    );
                    break;
                  case ConnectionState.done:
                    if (apiResponse.code == 1) {
                      return GridView.count(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20.0),
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: List.generate(
                          apiResponse.object.length,
                          (index) => ItemGrid(apiResponse.object[index]),
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

          /// To set GridView item
        ],
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
// ignore: must_be_immutable
class ItemGrid extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  Product gridItem;
  ItemGrid(this.gridItem);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => new detailProduk(gridItem),
              transitionDuration: Duration(milliseconds: 900),

              /// Set animation Opacity in route to detailProduk layout
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }),
        );
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// Set Animation image to detailProduk layout
            Hero(
              tag: "hero-grid-${gridItem.productsId}",
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return new Material(
                            color: Colors.black54,
                            child: Container(
                              padding: EdgeInsets.all(30.0),
                              child: InkWell(
                                child: Hero(
                                  tag: "hero-grid-${gridItem.productsId}",
                                  child: CachedNetworkImage(
                                    imageUrl: "http://oreeed.com/" +
                                        gridItem.productsImage,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 130, maxWidth: 100),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              "http://oreeed.com/" + gridItem.productsImage),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                gridItem.productsName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    letterSpacing: 0.5,
                    color: Colors.black54,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                gridItem.productsPrice,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        gridItem.rating,
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
                    gridItem.isOriginal == 1 ? "original" : "",
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
      ),
    );
  }
}
