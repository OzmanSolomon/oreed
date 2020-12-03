import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/UI/BottomNavigationBar.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:provider/provider.dart';

class payment extends StatefulWidget {
  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  /// Duration for popup card if user succes to payment
  StartTime() async {
    return Timer(Duration(milliseconds: 1450), navigator);
  }

  /// Navigation to route after user succes payment
  void navigator() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => new BottomNavigationBarPage()));
  }

  @override

  /// For radio button
  int tapvalue = 0;
  int tapvalue2 = 0;
  int tapvalue3 = 0;
  int tapvalue4 = 0;

  /// Custom Text
  var _customStyle = TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 17.0);

  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: RadioGroup(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Text Header for Dialog after user succes payment
var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Montserrat",
);

/// Custom Text Description for Dialog after user succes payment
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Montserrat",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    child: SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            "assets/img/checklist.png",
            height: 110.0,
            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            AppLocalizations.of(ctx).tr('yuppy'),
            style: _txtCustomHead,
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            AppLocalizations.of(ctx).tr('paymentReceive'),
            style: _txtCustomSub,
          ),
        )),
      ],
    ),
  );
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class PaymentMethod {
  String methodName;
  String methodImage;
  int index;
  PaymentMethod({this.index, this.methodImage, this.methodName});
}

class RadioGroupWidget extends State {
  var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Montserrat",
  );

  // Default Radio Button Item
  String radioItem = 'Cash On Delivery';

  // Group Value for Radio Button.
  int id = 1;

  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      return Column(
        children: <Widget>[
          Text(
            AppLocalizations.of(context).tr('chosePaymnet'),
            style: TextStyle(
                letterSpacing: 0.1,
                fontWeight: FontWeight.w600,
                fontSize: 25.0,
                color: Colors.black54,
                fontFamily: "Montserrat"),
          ),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Visibility(
                  visible: true,
                  child: Container(
                    color:
                        cart.selectedPayMent == 1 ? Colors.grey : Colors.white,
                    child: InkWell(
                      onTap: () {
                        cart.setPayMent(1);
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text("Cash On Delivery",
                                    style: TextStyle(color: Colors.black)),
                                Container(
                                  // padding: EdgeInsets.only(left: 1),
                                  child: Image.asset(
                                    "assets/img/handshake.png",
                                    height: 55.0,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(12),
                            width: MediaQuery.of(context).size.width,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5.0),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
             Visibility(
                  visible: false,
                                  child: Container(
                    color: cart.selectedPayMent == 2 ? Colors.grey : Colors.white,
                    child: InkWell(
                      onTap: () {
                        cart.setPayMent(2);
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text("mBOK",
                                    style: TextStyle(color: Colors.black)),
                                Container(
                                  // padding: EdgeInsets.only(left: 1),
                                  child: Image.asset(
                                    "assets/logo/bankaklogo.png",
                                    height: 55.0,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(12),
                            width: MediaQuery.of(context).size.width,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5.0),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    color:
                        cart.selectedPayMent == 3 ? Colors.grey : Colors.white,
                    child: InkWell(
                      onTap: () {
                        cart.setPayMent(3);
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text("SyberPay",
                                    style: TextStyle(color: Colors.black)),
                                Container(
                                  // padding: EdgeInsets.only(left: 1),
                                  child: Image.asset(
                                    "assets/logo/syberpay.png",
                                    height: 55.0,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(12),
                            width: MediaQuery.of(context).size.width,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5.0),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
