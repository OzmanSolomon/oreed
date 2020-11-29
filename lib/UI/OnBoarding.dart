import 'package:flutter/material.dart';
import 'package:oreed/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:oreed/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:oreed/UI/LoginOrSignup/ChoseLoginOrSignup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 21.0,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Montserrat", fontSize: 15.0, fontWeight: FontWeight.w400);

class _onBoardingState extends State<onBoarding> {
  final pages = [
    new PageViewModel(
        pageColor: Colors.white,
        iconColor: Colors.black,
        bubbleBackgroundColor: Colors.black,
        title: Text(
          'Buy',
          style: _fontHeaderStyle,
        ),
        body: Container(
          height: 250.0,
          child: Text(
              'Shope from thousands of brands \n   at Throwaway prices!',
              textAlign: TextAlign.center,
              style: _fontDescriptionStyle),
        ),
        bgImage: AssetImage(
          "assets/intro/1.png",
        ),
        mainImage: Image.asset(
          'assets/intro/1.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    new PageViewModel(
        pageColor: Colors.white,
        iconColor: Colors.black,
        bubbleBackgroundColor: Colors.black,
        title: Text(
          'Sell',
          style: _fontHeaderStyle,
        ),
        body: Container(
          height: 250.0,
          child: Text('Click, List & Sell coll stuff to \n  earn easy cash. ',
              textAlign: TextAlign.center, style: _fontDescriptionStyle),
        ),
        bgImage: AssetImage(
          "assets/intro/2.png",
        ),
        mainImage: Image.asset(
          'assets/intro/2.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    new PageViewModel(
        pageColor: Colors.white,
        iconColor: Colors.black,
        bubbleBackgroundColor: Colors.black,
        title: Text(
          'Quick Money ',
          style: _fontHeaderStyle,
        ),
        body: Container(
          height: 250.0,
          child: Text('Click, List & Earn Money Easily  \n    and Quickly! ',
              textAlign: TextAlign.center, style: _fontDescriptionStyle),
        ),
        bgImage: AssetImage(
          "assets/intro/3.png",
        ),
        mainImage: Image.asset(
          'assets/intro/3.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Colors.black45,
      skipText: Text(
        "SKIP",
        style: _fontDescriptionStyle.copyWith(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: _fontDescriptionStyle.copyWith(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () async {
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        prefs.setString("username", "Login");
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new ChoseLogin(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget widget) {
            return Opacity(
              opacity: animation.value,
              child: widget,
            );
          },
          transitionDuration: Duration(milliseconds: 1500),
        ));
      },
    );
  }
}
