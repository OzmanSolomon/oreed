import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/countdown_timer/countDownTimer.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';

import '../ProductDetails.dart';

class FlashSale extends StatefulWidget {
  @override
  _FlashSaleState createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  Future<ApiResponse> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductRepo().fetchFlashSaleList();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 330,
      ),
      child: Container(
        height: 330,
        color: Colors.white70,

        /// To set FlashSale Scrolling horizontal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Flash Sales",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
            ),
            Expanded(
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
                                print(
                                    "_______________________________FlashSales");
                                print(
                                    "##############_________________${apiResponse.object[index]}");

                                return InkWell(
                                  onTap: () {},
                                  child: flashSaleItem(
                                    product: apiResponse.object[index],
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
            ),
          ],
        ),
      ),
    );
  }
}

/// Component FlashSaleItem
class flashSaleItem extends StatelessWidget {
  final Product product;

  flashSaleItem({
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new ProductDetails(product),
                    transitionDuration: Duration(milliseconds: 850),

                    /// Set animation with opacity
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
              // height: 310.0,
              width: 145.0,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 1),
                    height: 140.0,
                    width: 145.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "http://oreeed.com/" + product.productsFlashImage,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                    child: Text(product.productsName,
                        style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                    child: Text(product.productsPrice,
                        style: TextStyle(
                            fontSize: 10.5,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                    child: Text(product.flashPrice.toString(),
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF7F7FD5),
                            fontWeight: FontWeight.w800,
                            fontFamily: "Montserrat")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 5.0, right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 11.0,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          size: 11.0,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          size: 11.0,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          size: 11.0,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star_half,
                          size: 11.0,
                          color: Colors.yellow,
                        ),
                        Text(
                          product.rating,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                  product.manufacturerName.toString() == "null"
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, right: 10.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 11.0,
                                color: Colors.black38,
                              ),
                              Text(
                                product.manufacturerName.toString() == "null"
                                    ? ""
                                    : product.manufacturerName.toString(),
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      product.productsQuantity.toString() +
                          AppLocalizations.of(context).tr('fAvailable1'),
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, left: 10.0, right: 10.0),
                    child: Container(
                      height: 5.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFA500),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          shape: BoxShape.rectangle),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18.0, bottom: 10),
                    child: CountDownTimer(
                      secondsRemaining: product.flashExpiresDate, //86400,
                      whenTimeExpires: () {
                        // setState(() {
                        //   //hasTimerStopped = true;
                        // });
                      },
                      countDownTimerStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 19.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff033766), // Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
