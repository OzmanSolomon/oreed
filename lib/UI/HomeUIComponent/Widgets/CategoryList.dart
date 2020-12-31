import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';
import 'package:shimmer/shimmer.dart';

import '../CategoryDetail.dart';

class CategoryList extends StatefulWidget {
  double width;
  double height;
  CategoryList({this.width, this.height});
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  Future<ApiResponse> _categories;
  ScrollController _controller;
  int itemSize = 0;

  @override
  void initState() {
    super.initState();
    _categories = BrandMenuCategoryRepo().fetchCategoryList();
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            _categories, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var apiResponse = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return EmptySlider(
                  ctx: context, height: widget.height, width: widget.width);
              break;
            case ConnectionState.waiting:
              return EmptySlider(
                  ctx: context, height: widget.height, width: widget.width);
              break;
            case ConnectionState.active:
              return EmptySlider(
                  ctx: context, height: widget.height, width: widget.width);
              break;
            case ConnectionState.done:
              if (apiResponse.code == 1) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _controller,
                          itemCount: apiResponse.object.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8.0),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new categoryDetail(
                                              category:
                                                  apiResponse.object[index]),
                                      transitionDuration:
                                          Duration(milliseconds: 750),
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
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minHeight: 60, minWidth: 60),
                                      child: Container(
                                        // height: widget.height,
                                        // width: widget.width,
                                        decoration: BoxDecoration(
                                          // color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.0),
                                          ),
                                          // color: Colors.green,
                                          image: DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: CachedNetworkImageProvider(
                                                "http://staging.oreeed.com/" +
                                                    apiResponse
                                                        .object[index].image),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        apiResponse
                                            .object[index].categoriesName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Montserrat",
                                          fontSize: 12.5,
                                          letterSpacing: 0.7,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    // apiResponse.object.length > 3
                    //     ? Center(
                    //         child: Padding(
                    //           padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             mainAxisSize: MainAxisSize.max,
                    //             children: [
                    //               GestureDetector(
                    //                   onTap: () {
                    //                     _controller.animateTo(
                    //                         _controller.offset -
                    //                             _controller.position.pixels -
                    //                             1,
                    //                         curve: Curves.linear,
                    //                         duration:
                    //                             Duration(milliseconds: 100));
                    //                   },
                    //                   child: Icon(Icons.arrow_back_ios)),
                    //               GestureDetector(
                    //                   onTap: () {
                    //                     _controller.animateTo(
                    //                         _controller.offset +
                    //                             apiResponse.object.length,
                    //                         curve: Curves.linear,
                    //                         duration:
                    //                             Duration(milliseconds: 100));
                    //                   },
                    //                   child: Icon(Icons.arrow_forward_ios)),
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     : Container()
                  ],
                );
              } else {
                return EmptySlider(
                    ctx: context, height: widget.height, width: widget.width);
              }
              break;
            default:
              return null;
              break;
          }
        });
  }
}

Widget EmptySlider({BuildContext ctx, double height, double width}) {
  return Shimmer.fromColors(
    baseColor: Colors.black38,
    highlightColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.only(left: 2.0, right: 2),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(7.0),
              ),
              // color: Colors.green,
              // image: DecorationImage(
              //   fit: BoxFit.fitHeight,
              //   image: AssetImage("http://staging.oreeed.com/"),
              // ),
            ),
          ),
          Center(
            child: Text(
              "",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat",
                fontSize: 18.5,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
