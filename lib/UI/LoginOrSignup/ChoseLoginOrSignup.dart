import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/UI/BottomNavigationBar.dart';
import 'package:oreeed/UI/LoginOrSignup/NewLogin.dart';
import 'package:oreeed/UI/LoginOrSignup/NewSinup.dart';
import 'package:oreeed/UI/LoginOrSignup/widgets/ButtonCustom.dart';

class ChoseLogin extends StatefulWidget {
  @override
  _ChoseLoginState createState() => _ChoseLoginState();
}

/// Component Widget this layout UI
class _ChoseLoginState extends State<ChoseLogin> with TickerProviderStateMixin {
  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.devicePixelRatio;

    mediaQuery.size.height;
    mediaQuery.size.width;

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "OreeedKey",
                    child: Image(
                      image: AssetImage("assets/logo/logo.png"),
                      height: 70.0,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).tr('welcomeTo') +
                        " " +
                        AppLocalizations.of(context).tr('title'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Explore Our Choices \n \t\t\t And Markets',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Montserrat",
                          letterSpacing: 1.3),
                    ),
                    InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 350),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return NewLogin();
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return Align(
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: ButtonCustom(
                        txt: AppLocalizations.of(context).tr('login'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /// To set white line (Click to open code)
                        Container(
                          color: Color(0xff033766),
                          height: 0.2,
                          width: 80.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),

                          /// navigation to home screen if user click "OR SKIP" (Click to open code)
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new BottomNavigationBarPage(),
                                    transitionDuration:
                                        Duration(milliseconds: 750),

                                    /// Set animation with opacity
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
                            child: Text(
                              AppLocalizations.of(context).tr('orSkip'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "Montserrat",
                                  fontSize: 15.0),
                            ),
                          ),
                        ),

                        /// To set white line (Click to open code)
                        Container(
                          color: Color(0xff033766),
                          height: 0.2,
                          width: 80.0,
                        )
                      ],
                    ),
                    InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Hero(
                              tag: 'choseNewSinUp',
                              child: new NewSinUp(),
                            ),
                          ),
                        );

                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new Hero(
                                  tag: 'choseNewSinUp',
                                  child: new NewSinUp(),
                                ),
                            transitionDuration: Duration(milliseconds: 750),

                            /// Set animation with opacity
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));
                      },
                      child: ButtonCustom(
                        txt: AppLocalizations.of(context).tr('signUp'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
