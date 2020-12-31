import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:oreeed/UI/HomeUIComponent/CategoryDetail.dart';
import 'package:oreeed/UI/HomeUIComponent/ProductDetails.dart';

/// Component item Menu icon bellow a ImageSlider
class HorizontalProductsList extends StatefulWidget {
  final String router;
  HorizontalProductsList({this.router});
  @override
  _HorizontalProductsListState createState() => _HorizontalProductsListState();
}

class _HorizontalProductsListState extends State<HorizontalProductsList> {
  Future<ApiResponse> _products;
  @override
  void initState() {
    super.initState();
    _products = ProductRepo().fetchProductList(widget.router);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      child: FutureBuilder(
          future: _products,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var apiResponse = snapshot.data;
            print(
                "/////////////////////////////////////////////////////////////This is the Landing Page ");

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _loadingImageAnimationDiscount();
                break;
              case ConnectionState.waiting:
                return _loadingImageAnimationDiscount();
                break;
              case ConnectionState.active:
                return _loadingImageAnimationDiscount();
                break;
              case ConnectionState.done:
                if (apiResponse.code == 1) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: apiResponse.object.length,
                      itemBuilder: (context, index) {
                        return ProductItem(product: apiResponse.object[index]);
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

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
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
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Container(
                width: 160.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 185.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "http://staging.oreeed.com/" +
                                      product.productsImage),
                              fit: BoxFit.cover)),
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
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0),
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
                            product.isOriginal == 1 ? "original" : "",
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
            ],
          ),
        ),
      ),
    );
  }
}

Widget _loadingImageAnimationDiscount({BuildContext context, int count}) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) =>
        loadingMenuItemDiscountCard(),
    itemCount: count,
  );
}
