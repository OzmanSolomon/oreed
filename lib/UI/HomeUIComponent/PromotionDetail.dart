import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:shimmer/shimmer.dart';

class promoDetail extends StatefulWidget {
  @override
  _promoDetailState createState() => _promoDetailState();
}

class _promoDetailState extends State<promoDetail> {
  bool imageLoad = true;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        imageLoad = false;
      });
    });
    // TODO: implement initState
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
    // var _grid = SingleChildScrollView(
    //   child: Container(
    //     color: Colors.white,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         imageLoad
    //             ? _imageLoading(context)
    //             : GridView.count(
    //                 shrinkWrap: true,
    //                 padding:
    //                     EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    //                 crossAxisSpacing: 10.0,
    //                 mainAxisSpacing: 15.0,
    //                 childAspectRatio: 0.545,
    //                 crossAxisCount: 2,
    //                 primary: false,
    //                 children: List.generate(
    //                   /// Get data in flashSaleItem.dart (ListItem folder)
    //                   promotionItem.length,
    //                   (index) => ItemGrid(product: promotionItem[index]),
    //                 ),
    //               )
    //       ],
    //     ),
    //   ),
    // );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        /// Appbar item
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).tr('weekPromotion'),
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
                // _grid,
              ],
            ),
          ),
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
                )
              ]),
          child: Wrap(
            children: <Widget>[
              ///
              ///
              /// Shimmer class for animation loading
              ///
              ///
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
