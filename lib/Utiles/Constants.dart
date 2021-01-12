import 'package:flutter/material.dart';

const String baseuRL = "http://staging2.oreeed.com/api/";
const String imageUrl = "http://staging2.oreeed.com/";
const String CFAssetImage = "images/five.png";
const String appName = "Oreeed";
const Color appBlue = Color(0xff033766);
const Color appYellow = Color(0xffF7BE00);
const Color appBlack = Colors.black;
const Color appTextHeadingColor = Colors.black;
const Color appTextNColor = Colors.black;

void showInSnackBar({GlobalKey<ScaffoldState> scaffoldKey, String msg}) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Container(
      height: 45,
      child: Center(
        child: Text("$msg"),
      ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: appBlue,
    elevation: 5,
    behavior: SnackBarBehavior.floating,
  ));
}
