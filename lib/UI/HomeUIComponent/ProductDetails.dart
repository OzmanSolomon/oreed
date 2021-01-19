import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:oreeed/UI/CartUIComponent/CartLayout.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/UI/HomeUIComponent/ReviewLayout.dart';
import 'package:oreeed/UI/LoginOrSignup/ChoseLoginOrSignup.dart';
import 'package:oreeed/UI/LoginOrSignup/NewLogin.dart';
import 'package:oreeed/UI/Products/GridView/VerticalGProductsList.dart';
import 'package:oreeed/UI/TEstZone/FullImagePageRoute.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductDetails extends StatefulWidget {
  final Product gridItem;

  ProductDetails(this.gridItem);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(gridItem);
}

/// Detail Product for Recomended Grid in home screen
class _ProductDetailsState extends State<ProductDetails> {
  final _formKey = GlobalKey<FormState>();
  double rating = 3.5;
  int starCount = 5;

  /// Declaration List item HomeGridItemRe....dart Class
  final Product gridItem;
  _ProductDetailsState(this.gridItem);

  @override
  static BuildContext ctx;
  int valueItemChart = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  /// BottomSheet for view more in specification
  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  height: 1500.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Center(
                        child: Text(
                          AppLocalizations.of(context).tr('description'),
                          style: _subHeaderCustomStyle,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                          child: descriptionHtml(gridItem.productsDescription)),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: Text(
                      //     AppLocalizations.of(context).tr('spesifications'),
                      //     style: TextStyle(
                      //         fontFamily: "Montserrat",
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 15.0,
                      //         color: Colors.black,
                      //         letterSpacing: 0.3,
                      //         wordSpacing: 0.5),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// Custom Text black
  static var _customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Montserrat",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: "Montserrat",
      fontSize: 16.0);

  /// Custom Text for Detail title
  static var _detailText = TextStyle(
      fontFamily: "Montserrat",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  final TextEditingController _reviewTextController =
      new TextEditingController();
  double rateValue = 0.0;

  List<int> _likedList = [];
  User _user;
  bool liveSession = false;
  @override
  void didChangeDependencies() {
    if (mounted) {
      initUSer();
    }
    super.didChangeDependencies();
  }

  Future<void> initUSer() async {
    int flag = await DatabaseHelper().getUserCount();
    var _uservar = (await DatabaseHelper().getUserList())[0];
    if (flag > 0) {
      setState(() {
        _user = _uservar;
        liveSession = flag > 0;
      });
    }
  }

  Widget build(BuildContext context) {
    var _suggestedItem = Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 20.0, top: 30.0, bottom: 20.0),
      child: Container(
        height: 280.0,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('topRated'),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      fontSize: 15.0),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new VerticalGProductsList(
                            title: AppLocalizations.of(context).tr('topRated'),
                            router: "top_sales"),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).tr('seeAll'),
                    style: TextStyle(
                        color: Colors.indigoAccent.withOpacity(0.8),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            Expanded(
              child: TopRatedList(),
            ),
          ],
        ),
      ),
    );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        return GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity > 0) {
              Navigator.of(context).pop();
            }
            print("${details.primaryVelocity}");
            // print("${details.velocity}");
            // print("${details}");
          },
          child: Scaffold(
            key: _key,
            appBar: AppBar(
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new cart()));
                  },
                  child: Stack(
                    alignment: AlignmentDirectional(-1.0, -0.8),
                    children: <Widget>[
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.black26,
                        ),
                      ),
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Colors.red,
                        child:
                            Consumer<CartProvider>(builder: (context, cart, _) {
                          return Text(
                            cart.getCart.length.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.0),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
              elevation: 0.5,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                AppLocalizations.of(context).tr('productDetail'),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 17.0,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Header image slider
                        gridItem.images != null
                            ? gridItem.images.isNotEmpty
                                ? Builder(
                                    builder: (BuildContext context) {
                                      String _selected = gridItem.productsImage;
                                      return Column(
                                        children: [
                                          Container(
                                            height: 300.0,
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Hero(
                                                    tag:
                                                        "hero-grid-${gridItem.productsId}",
                                                    child: GestureDetector(
                                                      child: CachedNetworkImage(
                                                        imageUrl: imageUrl +
                                                            _selected,
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          PageRouteBuilder(
                                                              pageBuilder: (context,
                                                                  animation,
                                                                  anotherAnimation) {
                                                                return FullImagePageRoute(
                                                                    imageUrl +
                                                                        _selected);
                                                              },
                                                              transitionDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          2000),
                                                              transitionsBuilder:
                                                                  (context,
                                                                      animation,
                                                                      anotherAnimation,
                                                                      child) {
                                                                animation = CurvedAnimation(
                                                                    curve: Curves
                                                                        .fastOutSlowIn,
                                                                    parent:
                                                                        animation);
                                                                return Align(
                                                                  child:
                                                                      SizeTransition(
                                                                    sizeFactor:
                                                                        animation,
                                                                    child:
                                                                        child,
                                                                    axisAlignment:
                                                                        0.0,
                                                                  ),
                                                                );
                                                              }),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: FavoriteIcon(
                                                      gridItem.id, (userId)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: gridItem.images.map((e) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _selected = e.image;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 20,
                                                      left: 10,
                                                      bottom: 10),
                                                  width: 100,
                                                  height: 100,
                                                  child: Center(
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          imageUrl + e.image,
                                                      placeholder: (context,
                                                              url) =>
                                                          CupertinoActivityIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(
                                                        Icons.error,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),

                                          // Container(
                                          //   height: 100.0,
                                          //   child: Hero(
                                          //     tag:
                                          //         "hero-grid-${gridItem.productsId}",
                                          //     child: Material(
                                          //       child: Stack(
                                          //         children: [
                                          //           CarouselSlider(
                                          //             items:
                                          //                 List<Widget>.generate(
                                          //               gridItem.images.length,
                                          //               (image) =>
                                          //                   GestureDetector(
                                          //                 child:
                                          //                     CachedNetworkImage(
                                          //                   imageUrl:
                                          //                       "http://staging.oreeed.com/" +
                                          //                           gridItem
                                          //                               .images[
                                          //                                   image]
                                          //                               .image,
                                          //                 ),
                                          //                 onTap: () {
                                          //                   Navigator.of(
                                          //                           context)
                                          //                       .push(
                                          //                     PageRouteBuilder(
                                          //                         pageBuilder: (context,
                                          //                             animation,
                                          //                             anotherAnimation) {
                                          //                           return FullImagePageRoute("http://staging.oreeed.com/" +
                                          //                               gridItem
                                          //                                   .images[image]
                                          //                                   .image);
                                          //                         },
                                          //                         transitionDuration:
                                          //                             Duration(
                                          //                                 milliseconds:
                                          //                                     2000),
                                          //                         transitionsBuilder: (context,
                                          //                             animation,
                                          //                             anotherAnimation,
                                          //                             child) {
                                          //                           animation = CurvedAnimation(
                                          //                               curve: Curves
                                          //                                   .fastOutSlowIn,
                                          //                               parent:
                                          //                                   animation);
                                          //                           return Align(
                                          //                             child:
                                          //                                 SizeTransition(
                                          //                               sizeFactor:
                                          //                                   animation,
                                          //                               child:
                                          //                                   child,
                                          //                               axisAlignment:
                                          //                                   0.0,
                                          //                             ),
                                          //                           );
                                          //                         }),
                                          //                   );
                                          //                 },
                                          //               ),
                                          //             ),
                                          //             options: CarouselOptions(
                                          //               height: 400,
                                          //               // aspectRatio: 16/9,
                                          //               viewportFraction: 0.8,
                                          //               initialPage: 0,
                                          //               enableInfiniteScroll:
                                          //                   true,
                                          //               reverse: false,
                                          //               autoPlay: false,
                                          //               enlargeCenterPage: true,
                                          //               scrollDirection:
                                          //                   Axis.horizontal,
                                          //             ),
                                          //           ),

                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      );
                                    },
                                  )
                                : GestureDetector(
                                    child: Container(
                                      height: 300,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  gridItem.productsImage != null
                                                      ? imageUrl +
                                                          gridItem.productsImage
                                                      : "",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: FavoriteIcon(
                                                gridItem.id, (userId)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  anotherAnimation) {
                                                return FullImagePageRoute(
                                                  imageUrl +
                                                      gridItem.productsImage,
                                                );
                                              },
                                              transitionDuration:
                                                  Duration(milliseconds: 2000),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  anotherAnimation,
                                                  child) {
                                                animation = CurvedAnimation(
                                                    curve: Curves.fastOutSlowIn,
                                                    parent: animation);
                                                return Align(
                                                  child: SizeTransition(
                                                    sizeFactor: animation,
                                                    child: child,
                                                    axisAlignment: 0.0,
                                                  ),
                                                );
                                              }));
                                    },
                                  )
                            : Container(
                                height: 300,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 300,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            gridItem.productsImage != null
                                                ? imageUrl +
                                                    gridItem.productsImage
                                                : '',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child:
                                          FavoriteIcon(gridItem.id, (_user.id)),
                                    ),
                                  ],
                                ),
                              ),

                        /// Background white title,price and ratting
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Color(0xFF656565).withOpacity(0.15),
                              blurRadius: 1.0,
                              spreadRadius: 0.2,
                            )
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      gridItem.productsName ?? "unkown",
                                      style: _customTextStyle,
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text(
                                  gridItem.currency != null
                                      ? gridItem.productsPrice +
                                          ' ' +
                                          gridItem.currency.toString()
                                      : gridItem.productsPrice ??
                                          '0' + ' ' + "SDG",
                                  style: _customTextStyle,
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Divider(
                                  color: Colors.black12,
                                  height: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30.0,
                                            width: 75.0,
                                            decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  gridItem.rating ?? '0.0',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 19.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          gridItem.isOriginal != null
                                              ? gridItem.isOriginal
                                                          .toString() ==
                                                      "1"
                                                  ? "original"
                                                  : ""
                                              : "",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        /// Background white for chose Size and Color
                        gridItem.attributes.isNotEmpty
                            ? gridItem.attributes.length > 1
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      height: 220.0,
                                      width: 600.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
                                              blurRadius: 1.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 20.0, right: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            gridItem.attributes[1]
                                                        .productsOptions !=
                                                    null
                                                ? Text(
                                                    AppLocalizations.of(context)
                                                        .tr('size'),
                                                    style:
                                                        _subHeaderCustomStyle)
                                                : Container(),
                                            gridItem.attributes[1]
                                                        .productsOptions !=
                                                    null
                                                ? Row(
                                                    children: List.generate(
                                                      /// Get data in flashSaleItem.dart (ListItem folder)
                                                      gridItem
                                                          .attributes.length,
                                                      (index) =>
                                                          RadioButtonCustom(
                                                        txt: gridItem
                                                            .attributes[index]
                                                            .productsOptions,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.0)),
                                            Divider(
                                              color: Colors.black12,
                                              height: 1.0,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.0)),
                                            gridItem.attributes[0]
                                                        .productsOptions !=
                                                    null
                                                ? Text(
                                                    AppLocalizations.of(context)
                                                        .tr('color'),
                                                    style:
                                                        _subHeaderCustomStyle,
                                                  )
                                                : Container(),
                                            gridItem.attributes[0]
                                                        .productsOptions !=
                                                    null
                                                ? Row(
                                                    children: List.generate(
                                                      /// Get data in flashSaleItem.dart (ListItem folder)
                                                      gridItem
                                                          .attributes.length,
                                                      (index) => RadioButtonColor(gridItem
                                                                  .attributes[
                                                                      index]
                                                                  .productsOptionsValues ==
                                                              'blue'
                                                          ? Colors.blue
                                                          : gridItem
                                                                      .attributes[
                                                                          index]
                                                                      .productsOptionsValues ==
                                                                  'Red'
                                                              ? Colors.red
                                                              : gridItem
                                                                          .attributes[
                                                                              index]
                                                                          .productsOptionsValues ==
                                                                      'Pink'
                                                                  ? Colors.pink
                                                                  : gridItem.attributes[index].productsOptionsValues ==
                                                                          'green'
                                                                      ? Colors
                                                                          .green
                                                                      : gridItem.attributes[index].productsOptionsValues ==
                                                                              'Sky Blue'
                                                                          ? Colors
                                                                              .blueAccent
                                                                          : gridItem.attributes[index].productsOptionsValues == 'Purple'
                                                                              ? Colors.purple
                                                                              : Colors.black),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                            : Container(),

                        /// Background white for description
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 600.0,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: Color(0xFF656565).withOpacity(0.15),
                                blurRadius: 1.0,
                                spreadRadius: 0.2,
                              )
                            ]),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .tr('description'),
                                      style: _subHeaderCustomStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0,
                                        right: 20.0,
                                        bottom: 10.0,
                                        left: 20.0),
                                    child: descriptionHtml(
                                        gridItem.productsDescription),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          _bottomSheet();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .tr('viewMore'),
                                          style: TextStyle(
                                            color: Colors.indigoAccent,
                                            fontSize: 15.0,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// Background white for Ratting
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 600.0,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: Color(0xFF656565).withOpacity(0.15),
                                blurRadius: 1.0,
                                spreadRadius: 0.2,
                              )
                            ]),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0, left: 20.0, right: 20.0),
                              child: gridItem.reviewedCustomers.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .tr('review'),
                                              style: _subHeaderCustomStyle,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  top: 15.0,
                                                  bottom: 15.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  InkWell(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.0, right: 3.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .tr('viewAll'),
                                                        style: _subHeaderCustomStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .indigoAccent,
                                                                fontSize: 14.0),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        PageRouteBuilder(
                                                          pageBuilder: (_, __, ___) => ReviewsAll(
                                                              index: gridItem
                                                                  .productsId,
                                                              rating: double.parse(
                                                                      gridItem
                                                                          .rating) +
                                                                  0.0,
                                                              totalRating: gridItem
                                                                  .reviewedCustomers
                                                                  .length),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15.0,
                                                            top: 2.0),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18.0,
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  StarRating(
                                                    size: 25.0,
                                                    starCount: 5,
                                                    rating: double.parse(
                                                        gridItem.rating ?? '0'),
                                                    color: Colors.yellow,
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Text(
                                                    "${gridItem.totalUserRated ?? 0} Reviews",
                                                  )
                                                ]),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0,
                                              right: 20.0,
                                              top: 15.0,
                                              bottom: 7.0),
                                          child: _line(),
                                        ),
                                        Column(
                                          children: List.generate(
                                            gridItem.reviewedCustomers.length,
                                            (index) => Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0.0,
                                                      right: 20.0,
                                                      top: 15.0,
                                                      bottom: 7.0),
                                                  child: _Rating(
                                                      date: gridItem
                                                          .reviewedCustomers[
                                                              index]
                                                          .createdAt
                                                          .toString(),
                                                      details: gridItem
                                                          .reviewedCustomers[
                                                              index]
                                                          .comments,
                                                      rating: gridItem
                                                              .reviewedCustomers[
                                                                  index]
                                                              .reviewsRating +
                                                          0.0,
                                                      image:
                                                          "assets/avatars/male.png"),
                                                ),
                                                _line(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20.0)),
                                      ],
                                    )
                                  : Container(
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            print(
                                                "You Are trying to Add Review");
                                            if (liveSession) {
                                              Alert(
                                                context: context,
                                                title: "Add Review",
                                                content: Container(
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12.0),
                                                      ),
                                                      SmoothStarRating(
                                                          allowHalfRating:
                                                              false,
                                                          onRated: (v) {
                                                            setState(() {
                                                              rateValue =
                                                                  v + 0.0;
                                                            });
                                                          },
                                                          starCount: 5,
                                                          rating: 0,
                                                          size: 40.0,
                                                          isReadOnly: false,
                                                          color: Colors.yellow,
                                                          borderColor: appBlue,
                                                          spacing: 0.0),
                                                      Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          children: <Widget>[
                                                            /// TextFromField Password
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          12.0),
                                                            ),
                                                            Card(
                                                                color:
                                                                    Colors.grey,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        _reviewTextController,
                                                                    maxLines: 8,
                                                                    decoration: InputDecoration.collapsed(
                                                                        hintText:
                                                                            "Enter your text here"),
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      20.0)),
                                                    ],
                                                  ),
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    child: Text(
                                                      "save",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        print(
                                                            "stars: $rateValue");
                                                        print(
                                                            "reviews body: ${_reviewTextController.text}");
                                                        _formKey.currentState
                                                            .save();
                                                        if (_reviewTextController
                                                                    .text !=
                                                                null &&
                                                            _reviewTextController
                                                                    .text
                                                                    .toString() !=
                                                                null) {
                                                          ProductsProvider().addReview(
                                                              userName: _user
                                                                          .userName !=
                                                                      null
                                                                  ? _user
                                                                      .userName
                                                                  : _user.firstName ??
                                                                      '',
                                                              product: gridItem,
                                                              scaffoldKey: _key,
                                                              userId: int.parse(
                                                                  _user.id),
                                                              productId: gridItem
                                                                  .productsId,
                                                              rating:
                                                                  rateValue +
                                                                      0.0,
                                                              body:
                                                                  _reviewTextController
                                                                      .text);
                                                        } else {
                                                          ShowSnackBar(
                                                              context: _key
                                                                  .currentContext,
                                                              msg:
                                                                  "Please Fill in all empty fields",
                                                              bgColor: Colors
                                                                  .blue
                                                                  .withOpacity(
                                                                      0.5),
                                                              textColor:
                                                                  Colors.black,
                                                              height: 25);
                                                        }
                                                      }
                                                    },
                                                    color: appBlue,
                                                  ),
                                                  DialogButton(
                                                    child: Text(
                                                      "cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    color: appBlue,
                                                  )
                                                ],
                                              ).show();
                                            } else {
                                              ShowSnackBar(
                                                  context: _key.currentContext,
                                                  msg:
                                                      "Please login to be able to rate us",
                                                  bgColor: Colors.blue
                                                      .withOpacity(0.5),
                                                  textColor: Colors.black,
                                                  height: 25);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15,
                                                bottom: 15,
                                                left: 30,
                                                right: 12),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisSize: ,
                                                children: <Widget>[
                                                  Text(
                                                    "add First Review ",
                                                    style: TextStyle(
                                                        color: appBlue),
                                                  ),
                                                  Container(),
                                                  StarRating(
                                                    rating:
                                                        gridItem.rating != null
                                                            ? double.parse(
                                                                gridItem.rating)
                                                            : 5.0,
                                                    size: 25,
                                                    color: Color(0xffFAC917),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        _suggestedItem
                      ],
                    ),
                  ),
                ),

                /// If user click icon chart SnackBar show
                /// this code to show a SnackBar
                /// and Increase a valueItemChart + 1
                InkWell(
                  onTap: () {
                    // if (widget.gridItem.productsMaxStock > 0) {
                    // if (!cartProvider.getCart.contains(widget.gridItem)) {
                    cartProvider.addToCart(
                      product: widget.gridItem,
                    );
                    ShowSnackBar(
                        context: _key.currentContext,
                        msg: AppLocalizations.of(context).tr('itemAdded'),
                        bgColor: Colors.blue.withOpacity(0.5),
                        textColor: Colors.black,
                        height: 25);
                    // } else {
                    //   ShowSnackBar(
                    //       context: _key.currentContext,
                    //       msg: "Item already Exist in cart",
                    //       bgColor: Colors.blue.withOpacity(0.5),
                    //       textColor: Colors.black,
                    //       height: 25);
                    // }
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Container(
                      color: Color(0xffF7BE08),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Image.asset(
                              "assets/icon/shopping-cart.png",
                              height: 23.0,
                            ),
                            onTap: () {},
                          ),

                          /// Button Pay
                          Container(
                            height: 45.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Color(0xffF7BE08),
                            ),
                            child: Center(
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  dynamic descriptionHtml(data) {
    try {
      return Html(
        data: data,
        //Optional parameters:
        style: {
          "div": Style(
              padding: EdgeInsets.all(6),
              backgroundColor: Colors.grey,
              textAlign: TextAlign.center,
              fontSize: FontSize.medium,
              wordSpacing: 30.0
//                                        text-align:center,
              ),
        },
      );
    } catch (e) {
      return Text(
        'No Description Available Right Now',
        // style: _subHeaderCustomStyle.copyWith(
        //     color: Colors.indigoAccent, fontSize: 14.0),
      );
    }
  }

  Widget _Rating({String date, String details, double rating, String image}) {
    return ListTile(
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
      title: Row(
        children: <Widget>[
          StarRating(
            size: 20.0,
            rating: rating,
            starCount: 5,
            color: Colors.yellow,
          ),
          SizedBox(width: 8.0),
          Text(
            timeago.format(DateTime.parse(date), locale: 'en'),
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      subtitle: Text(
        details,
        style: _detailText,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _reviewTextController.dispose();
    super.dispose();
  }
}

/// RadioButton for item choose in size
class RadioButtonCustom extends StatefulWidget {
  String txt;

  RadioButtonCustom({this.txt});

  @override
  _RadioButtonCustomState createState() => _RadioButtonCustomState(this.txt);
}

class _RadioButtonCustomState extends State<RadioButtonCustom> {
  _RadioButtonCustomState(this.txt);

  String txt;
  bool itemSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
      child: InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              if (itemSelected == false) {
                setState(() {
                  itemSelected = true;
                });
              } else if (itemSelected == true) {
                setState(() {
                  itemSelected = false;
                });
              }
            });
          }
        },
        child: Container(
          height: 37.0,
          padding: EdgeInsets.only(left: 5, right: 5),
//          width: 37.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: itemSelected ? Colors.black54 : Colors.indigoAccent),
              shape: BoxShape.rectangle),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                txt,
                style: TextStyle(
                    color: itemSelected ? Colors.black54 : Colors.indigoAccent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// RadioButton for item choose in color
class RadioButtonColor extends StatefulWidget {
  Color clr;

  RadioButtonColor(this.clr);

  @override
  _RadioButtonColorState createState() => _RadioButtonColorState(this.clr);
}

class _RadioButtonColorState extends State<RadioButtonColor> {
  bool itemSelected = true;
  Color clr;

  _RadioButtonColorState(this.clr);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          if (mounted) {
            if (itemSelected == false) {
              setState(() {
                itemSelected = true;
              });
            } else if (itemSelected == true) {
              setState(() {
                itemSelected = false;
              });
            }
          }
        },
        child: Container(
          height: 37.0,
          width: 37.0,
          decoration: BoxDecoration(
              color: clr,
              border: Border.all(
                  color: itemSelected ? Colors.black26 : Colors.indigoAccent,
                  width: 2.0),
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}

/// Class for card product in "Top Rated Products"
class FavoriteItem extends StatelessWidget {
  Product gridItem;
  FavoriteItem(this.gridItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ProductDetails(gridItem),
                transitionDuration: Duration(milliseconds: 750),

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
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                imageUrl + gridItem.productsImage),
                            fit: BoxFit.cover)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      gridItem.productsName,
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
                      gridItem.productsPrice,
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
                          gridItem.productsPrice ?? '0',
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
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}

/// Component item Menu icon bellow a ImageSlider
class TopRatedList extends StatefulWidget {
  @override
  _TopRatedListState createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  Future<ApiResponse> _products;
  @override
  void initState() {
    super.initState();
    _products = ProductRepo().fetchTopSalesList();
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
                        return Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: FavoriteItem(apiResponse.object[index]),
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

class FavoriteIcon extends StatelessWidget {
  final int id;
  dynamic userId;
  FavoriteIcon(this.id, this.userId);

  @override
  Widget build(BuildContext context) {
    userId = userId != null ? int.parse(userId.toString()) : userId;
    return Consumer<ProductsProvider>(builder: (context, productProvider, _) {
      myIds = [];
      if (favs != null && favs.isNotEmpty) {
        favs.forEach((element) {
          myIds.add(element['liked_products_id']);
        });
      }
      return Padding(
        padding: EdgeInsets.only(right: 18.0, top: 12),
        child: processList.contains(id)
            ? CupertinoActivityIndicator()
            : userId == null
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new ChoseLogin()));
                    },
                    child: Icon(
                      Icons.favorite_border,
                      size: 35,
                      color: appBlue,
                    ),
                  )
                : favs != null && myIds.contains(id)
                    ? InkWell(
                        onTap: () {
                          myIds.removeWhere((element) => element == id);
                          productProvider.deleteFromLikedProducts(
                              context, id, userId);
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 35,
                          color: appBlue,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          myIds.add(id);
                          productProvider.addToLikedProducts(
                              context, id, userId);
                        },
                        child: Icon(
                          Icons.favorite_border,
                          size: 35,
                          color: appBlue,
                        ),
                      ),
      );
    });
  }
}

List processList = [];
List myIds = [];
