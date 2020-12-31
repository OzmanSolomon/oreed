import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/UI/CartUIComponent/CheckOut.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/UI/LoginOrSignup/NewLogin.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:provider/provider.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    var totalItems =
        Provider.of<CartProvider>(context, listen: false).getCart.length;
    String totalItem = totalItems == 0 ? "" : totalItems.toString() + " Item/s";
    return EasyLocalizationProvider(
      data: data,
      child: Consumer<CartProvider>(builder: (ctnx, cart, _) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color(0xFF6991C7)),
              centerTitle: true,
              // automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Text(
                AppLocalizations.of(context).tr('cart') + " " + totalItem,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700),
              ),
              elevation: 0.0,
            ),
            body: cart.getCart.length > 0
                ? Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 90,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height - 176,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: cart.getCart.length,
                              itemBuilder: (context, position) {
                                ///
                                /// Widget for list view slide delete
                                ///
                                return Slidable(
                                  delegate: new SlidableDrawerDelegate(),
                                  actionExtentRatio: 0.25,
                                  actions: <Widget>[
                                    new IconSlideAction(
                                      caption: AppLocalizations.of(context)
                                          .tr('cartArchiveText'),
                                      color: Colors.blue,
                                      icon: Icons.archive,
                                      onTap: () {
                                        ShowSnackBar(
                                            context: context,
                                            msg: AppLocalizations.of(context)
                                                .tr('cartArchice'),
                                            bgColor:
                                                Colors.blue.withOpacity(0.5),
                                            textColor: Colors.black,
                                            height: 25);
                                      },
                                    ),
                                  ],
                                  secondaryActions: <Widget>[
                                    new IconSlideAction(
                                      key: Key(position.toString()),
                                      caption: AppLocalizations.of(context)
                                          .tr('cartDelete'),
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        setState(() {
                                          cart.removeFromCart(position);
                                        });

                                        /// SnackBar show if cart delet

                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              AppLocalizations.of(context)
                                                  .tr('cartDeleted'),
                                            ),
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 1.0, left: 13.0, right: 13.0),

                                    /// Background Constructor for card
                                    child: Container(
                                      height: 158.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            blurRadius: 3.5,
                                            spreadRadius: 0.4,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(10.0),

                                                /// Image item
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 0.5,
                                                            spreadRadius: 0.1)
                                                      ]),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "http://staging.oreeed.com/${cart.getCart[position].productsImage}",
                                                    height: 130.0,
                                                    width: 120.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25.0,
                                                          left: 10.0,
                                                          right: 5.0),
                                                  child: Column(
                                                    /// Text Information Item
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        '${cart.getCart[position].productsName}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              "Montserrat",
                                                          color: Colors.black87,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0)),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0)),
                                                      Text(
                                                          '${cart.getCart[position].productsPrice}'),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 18.0,
                                                                left: 0.0),
                                                        child: Container(
                                                          width: 112.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white70,
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12
                                                                  .withOpacity(
                                                                      0.1),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              /// Decrease of value item
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    Provider.of<CartProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .decrementQty(
                                                                            cartItem:
                                                                                cart.getCart[position]);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                      child: Text(
                                                                          "-")),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                                child: Text(
                                                                    '${cart.getCart[position].productsQuantity}'
                                                                        .toString()),
                                                              ),

                                                              /// Increasing value of item
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    Provider.of<CartProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .incrementQty(
                                                                            cartItem:
                                                                                cart.getCart[position]);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 28.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      left:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                        "+"),
                                                                  ),
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
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.vertical,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),

                                  /// Total price of item buy
                                  child: Text(
                                    AppLocalizations.of(context)
                                            .tr('cartTotal') +
                                        "SDG" +
                                        cart.getTotalPrice.toString(),
                                    style: TextStyle(
                                        color:
                                            Color(0xff033766), //Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.5,
                                        fontFamily: "Montserrat"),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (liveSession) {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  new CheckOut()));
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  new NewLogin()));

                                      // _scaffoldKey.currentState
                                      //     .showSnackBar(SnackBar(
                                      //   content: Container(
                                      //     height: 45,
                                      //     child: Center(
                                      //       child: Text(
                                      //           "Login or register to continue "),
                                      //     ),
                                      //   ),
                                      //   duration: Duration(seconds: 2),
                                      //   backgroundColor: Color(0xff033766),
                                      //   elevation: 5,
                                      //   behavior: SnackBarBehavior.floating,
                                      // ));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height: 40.0,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF7BE08),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .tr('checkOut'),
                                          style: TextStyle(
                                              color: Color(0xff033766),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : noItemCart());
      }),
    );
  }
}

/// If no item cart this class showing

class noItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Center(
                child: Text(
                  AppLocalizations.of(context).tr('cartNoItem'),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.5,
                      color: Colors.black26.withOpacity(0.2),
                      fontFamily: "Montserrat"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
