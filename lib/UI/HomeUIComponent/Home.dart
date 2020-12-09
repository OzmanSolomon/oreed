import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Services/ConfigurationRepo.dart';
import 'package:oreeed/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:oreeed/UI/HomeUIComponent/Widgets/CategoryList.dart';
import 'package:oreeed/UI/HomeUIComponent/Widgets/MenuItemList.dart';
import 'package:oreeed/UI/HomeUIComponent/Widgets/Recomended.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:shimmer/shimmer.dart';

import 'Widgets/FlashSale.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

/// Component all widget in home
class _MenuState extends State<Menu> with TickerProviderStateMixin {
  bool isStarted = false;
  Future<ApiResponse> _sliders;
  Future<ApiResponse> _prands;
  int _current = 0;
  @override
  void initState() {
    super.initState();
    _sliders = ConfigurationRepo().getSliders();
    _prands = ConfigurationRepo().getSliders();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _width = MediaQuery.of(context).size.width;

    /// ImageSlider in header
    var imageSlider = ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 250,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: Container(
        child: FutureBuilder(
            future: _sliders,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var apiResponse = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return EmptySlider(
                    ctx: context,
                    width: _width / 3,
                    height: _width / 3,
                  );
                  break;
                case ConnectionState.waiting:
                  return EmptySlider(
                      ctx: context, height: _width / 3, width: _width / 3);
                  break;
                case ConnectionState.active:
                  return EmptySlider(
                      ctx: context, height: _width / 3, width: _width / 3);
                  break;
                case ConnectionState.done:
                  //print("######done object ${apiResponse.object}");
                  //print("######done msg ${apiResponse.msg}");
                  //print("######done code ${apiResponse.code}");
                  if (apiResponse.code.toString() == "1") {
                    List<Widget> widgets = apiResponse.object
                        .map<Widget>(
                          (name) => GestureDetector(
                            onTap: () {
                              print("This Should Direct You to another");
                            },
                            child: Container(
                              width: _width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        imageUrl + name["path"]),
                                    fit: BoxFit.fill),
                              ),
                              child: Center(
                                  child: Text(
                                "${apiResponse.code}",
                                style: TextStyle(color: Colors.white70),
                              )),
                            ),
                          ),
                        )
                        .toList();
                    return Column(
                      children: [
                        CarouselSlider(
                            items: widgets,
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration: Duration(seconds: 5),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              scrollDirection: Axis.horizontal,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widgets.map((url) {
                            int index = widgets.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(
                      width: _width,
                      height: _width,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white70,
                        child: Container(
                          width: _width,
                          height: _width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/imgIllustration/IlustrasiCart.png",
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Center(
                              child: Text(
                            "${apiResponse.code}",
                            style: TextStyle(color: Colors.white70),
                          )),
                        ),
                      ),
                    );
                    // return Container(
                    //   child: Center(
                    //     child: Text("${_images.length}"),
                    //   ),
                    // );
                  }
                  break;
                default:
                  return null;
                  break;
              }
            }),
      ),
    );

    /// ImageSlider in header
    var prandsSlider = Container(
      height: 182.0,
      child: FutureBuilder(
          future: _prands,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var apiResponse = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return EmptySlider(
                  ctx: context,
                  width: _width / 3,
                  height: _width / 3,
                );
                break;
              case ConnectionState.waiting:
                return EmptySlider(
                    ctx: context, height: _width / 3, width: _width / 3);
                break;
              case ConnectionState.active:
                return EmptySlider(
                    ctx: context, height: _width / 3, width: _width / 3);
                break;
              case ConnectionState.done:
                if (apiResponse.code.toString() == "1") {
                  List<Widget> prands = apiResponse.object
                      .map<Widget>(
                        (brand) => GestureDetector(
                          onTap: () {
                            print("This Should Direct You to another");
                          },
                          child: Container(
                            width: _width / 3,
                            height: _width / 4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      imageUrl + brand["image"]),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      )
                      .toList();
                  return CarouselSlider(
                      items: prands,
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ));
                } else {
                  return SizedBox(
                    width: _width,
                    height: _width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white70,
                      child: Container(
                        width: _width,
                        height: _width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/imgIllustration/IlustrasiCart.png",
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                            child: Text(
                          "${apiResponse.code}",
                          style: TextStyle(color: Colors.white70),
                        )),
                      ),
                    ),
                  );
                }
                break;
              default:
                return null;
                break;
            }
          }),
    );

    /// ListView a WeekPromotion Component
    var PromoHorizontalList = Container(
      color: Colors.white,
      height: 230.0,
      padding: EdgeInsets.only(bottom: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 20.0, top: 15.0, bottom: 3.0, right: 20.0),
            child: Text(
              AppLocalizations.of(context).tr('weekPromotion'),
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: WeekPromotionList(),
          ),
        ],
      ),
    );

    /// Category Component in bottom of flash sale
    var categoryImageBottom = Container(
      height: _width / 2,
      color: Colors.white,
      child: CategoryList(
        width: _width / 3,
        height: _width / 3,
      ),
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        /// Use Stack to costume a appbar
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              brightness: MediaQuery.of(context).platformBrightness,
              expandedHeight: 100,
              flexibleSpace: AppbarGradient(),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding:
            //         EdgeInsets.only(top: mediaQueryData.padding.top + 58.5),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: imageSlider,
            ),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: Text(
                    AppLocalizations.of(context).tr('category'),
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat"),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: categoryImageBottom,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
            ),
            SliverToBoxAdapter(
              child: PromoHorizontalList,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
            ),
            SliverToBoxAdapter(
              child: FlashSale(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
            ),

            SliverToBoxAdapter(
              child: RecommendedList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Component item Menu icon bellow a ImageSlider
class CategoryIconValue extends StatelessWidget {
  String icon1, icon2, icon3, icon4, title1, title2, title3, title4;
  GestureTapCallback tap1, tap2, tap3, tap4;

  CategoryIconValue(
      {this.icon1,
      this.tap1,
      this.icon2,
      this.tap2,
      this.icon3,
      this.tap3,
      this.icon4,
      this.tap4,
      this.title1,
      this.title2,
      this.title3,
      this.title4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: tap1,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon1,
                height: 19.2,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title1,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap2,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon2,
                height: 26.2,
              ),
              Padding(padding: EdgeInsets.only(top: 0.0)),
              Text(
                title2,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap3,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon3,
                height: 22.2,
              ),
              Padding(padding: EdgeInsets.only(top: 4.0)),
              Text(
                title3,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap4,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon4,
                height: 19.2,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title4,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryItems {
  final int id;
  final String name;
  final Color color;

  CategoryItems({this.id, this.name, this.color});
}

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40),
    );
  }
}
