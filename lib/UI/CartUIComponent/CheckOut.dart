import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/UI/CartUIComponent/address.dart';
import 'package:oreeed/UI/CartUIComponent/Payment.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:oreeed/providers/CountryProvider.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  User _user;
  bool liveSession = false;
  @override
  void initState() {
    super.initState();
    // CountryProvider().fetchTimeZoneList();
  }

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      body: Consumer<CartProvider>(builder: (context, cart, child) {
        return _user == null
            ? Center(child: Container(child: CircularProgressIndicator(),height: 50,width: 50))
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    top: 15.0,
                    left: 12.0,
                    right: 12.0,
                    child: Container(
                      height: 90,
                      margin: EdgeInsets.only(top: 5),
                      child: FittedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: width / 5,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 65.0,
                              width: 65.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/logo/oreeedlogo.png"),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: width / 5,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.0,
                    left: 10.0,
                    right: 10.0,
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 5),
                      child: FittedBox(
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                cart.setStage(1);
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle,
                                    color: cart.stage > 0
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Delivery'),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: width / 5,
                                height: 2,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cart.setStage(2);
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle,
                                    color: cart.stage > 1
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  Text('Address'),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: width / 5,
                                height: 2,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print(
                                    "your Current address is ___________${cart.myCurrentAddresses}");
                                if (cart.myCurrentAddresses != null) {
                                  if ((cart.stage > 2)) {
                                    cart.setStage(3);
                                  } else {
                                    ShowSnackBar(
                                        context: context,
                                        msg:
                                            "please fill all required fields in order",
                                        bgColor: Colors.yellow.withOpacity(0.9),
                                        textColor: Colors.black,
                                        height: 25);
                                  }
                                } else {
                                  ShowSnackBar(
                                      context: context,
                                      msg:
                                          "please fill all required fields in order",
                                      bgColor: Colors.yellow.withOpacity(0.9),
                                      textColor: Colors.black,
                                      height: 25);
                                }
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle,
                                    color: cart.stage > 2
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  Text('Payment'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: height - 150,
                      child: ListView(
                        children: <Widget>[
                          Visibility(
                            visible: cart.stage == 1,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 50,
                                      bottom: 12),
                                  child: Card(
                                      elevation: 5,
                                      color: cart.getDeliveryMethod == 1
                                          ? Colors.grey
                                          : Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          cart.setDeliveryMthod(1);
                                        },
                                        child: Container(
                                          height: 100,
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: FittedBox(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(
                                                        "normal speed ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "Order will be delivered between 3 - 5 business days"),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      elevation: 5,
                                      color: cart.getDeliveryMethod == 2
                                          ? Colors.grey
                                          : Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          cart.setDeliveryMthod(2);
                                        },
                                        child: Container(
                                          height: 100,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: FittedBox(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(
                                                        "- express delivery",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "- Order will be delivered in about 24 Hours",
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  // padding: EdgeInsets.only(top: 80.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .setStage(2);
                                            },
                                            child: Container(
                                              height: 55.0,
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.2,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              alignment:
                                                  FractionalOffset.center,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        blurRadius: 15.0)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(14),
                                                    topLeft:
                                                        Radius.circular(14),
                                                    bottomLeft:
                                                        Radius.circular(14),
                                                    bottomRight:
                                                        Radius.circular(14),
                                                  ),
                                                  color: appBlue),
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
                          Visibility(
                            visible: cart.stage == 2,
                            child: Container(
                              width: width,
                              height: height - 175,
                              child: Column(
                                children: [
                                  Expanded(child: Address(_user.id)),
                                  Container(
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        left: 12.0, right: 12.0, bottom: 0.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              cart.setStage(1);
                                            },
                                            child: Container(
                                              height: 55.0,
                                              child: Text(
                                                "Previous",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.2,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              alignment:
                                                  FractionalOffset.center,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      blurRadius: 15.0)
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14)),
                                                color: appBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              print(
                                                  "your Current address is ___________${cart.myCurrentAddresses}");
                                              if (cart.myCurrentAddresses !=
                                                  null) {
                                                if (!(cart.stage < 2)) {
                                                  cart.setStage(3);
                                                } else {
                                                  ShowSnackBar(
                                                      context: context,
                                                      msg:
                                                          "please fill all required fields in order",
                                                      bgColor: Colors.yellow
                                                          .withOpacity(0.9),
                                                      textColor: Colors.black,
                                                      height: 25);
                                                }
                                              } else {
                                                ShowSnackBar(
                                                    context: context,
                                                    msg:
                                                        "please fill all required fields in order",
                                                    bgColor: Colors.yellow
                                                        .withOpacity(0.9),
                                                    textColor: Colors.black,
                                                    height: 25);
                                              }
                                            },
                                            child: Container(
                                              height: 55.0,
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.2,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              alignment:
                                                  FractionalOffset.center,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        blurRadius: 15.0)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(14),
                                                  ),
                                                  color: appBlue),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: cart.stage == 3,
                            child: Container(
                              width: width,
                              height: height - 175,
                              child: Column(
                                children: [
                                  Expanded(child: payment()),
                                  Container(
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        left: 12.0, right: 12.0, bottom: 0.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              cart.setStage(2);
                                            },
                                            child: Container(
                                              height: 55.0,
                                              child: Text(
                                                "Previous",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.2,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              alignment:
                                                  FractionalOffset.center,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      blurRadius: 15.0)
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14)),
                                                color: appBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              cart.placeOrder(
                                                user: _user,
                                                scaffoldKey: _key,
                                              );
                                              // _showDialog(context);
                                            },
                                            child: Container(
                                              height: 55.0,
                                              child: Text(
                                                "Pay",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.2,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              alignment:
                                                  FractionalOffset.center,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        blurRadius: 15.0)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(14)),
                                                  color: appBlue),
                                            ),
                                          ),
                                        ),
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
                ],
              );
      }),
    );
  }
}
