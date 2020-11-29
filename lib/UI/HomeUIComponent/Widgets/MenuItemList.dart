import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Services/BrandMenuCategoryRepo.dart';
import 'package:oreed/Services/ProductRepo.dart';
import 'package:oreed/UI/BrandUIComponent/NoData.dart';
import 'package:oreed/UI/HomeUIComponent/DetailProduct.dart';

/// Component item Menu icon bellow a ImageSlider
class MenuItemList extends StatefulWidget {
  @override
  _MenuItemListState createState() => _MenuItemListState();
}

class _MenuItemListState extends State<MenuItemList> {
  Future<ApiResponse> _categories;

  @override
  void initState() {
    super.initState();
    _categories = BrandMenuCategoryRepo().fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      child: FutureBuilder(
          future:
              _categories, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var apiResponse = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return TryAgainLater();
                break;
              case ConnectionState.waiting:
                return LoaderFetchingData();
                break;
              case ConnectionState.active:
                return LoaderFetchingData();
                break;
              case ConnectionState.done:
                if (apiResponse.code == 1) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: apiResponse.object.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 2, right: 2),
                          padding: EdgeInsets.only(left: 4.0, right: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 85.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                            child: FittedBox(
                              child: Text(
                                apiResponse.object[index].categoriesName
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return NoData();
                }
                break;
              default:
                return null;
                break;
            }
          }),
    );
  }
}

/// Component item Menu icon bellow a ImageSlider
class WeekPromotionList extends StatefulWidget {
  @override
  _WeekPromotionListState createState() => _WeekPromotionListState();
}

class _WeekPromotionListState extends State<WeekPromotionList> {
  Future<ApiResponse> _products;
  @override
  void initState() {
    super.initState();
    _products = ProductRepo().fetchSpecialList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      child: FutureBuilder(
          future:
              _products, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var apiResponse = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return TryAgainLater();
                break;
              case ConnectionState.waiting:
                return LoaderFetchingData();
                break;
              case ConnectionState.active:
                return LoaderFetchingData();
                break;
              case ConnectionState.done:
                if (apiResponse.code == 1) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: apiResponse.object.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 2, right: 2),
                            padding: EdgeInsets.only(left: 4.0, right: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    "http://oreeed.com/" +
                                        apiResponse
                                            .object[index].productsImage),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 85.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new detailProduk(
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
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return NoData();
                }
                break;
              default:
                return null;
                break;
            }
          }),
    );
  }
}
