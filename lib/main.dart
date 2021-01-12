import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:oreeed/UI/LoginOrSignup/ChoseLoginOrSignup.dart';
import 'package:oreeed/UI/Products/GridView/VerticalGProductsList.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/providers/AppProvider.dart';
import 'package:oreeed/providers/AuthProvider.dart';
import 'package:oreeed/providers/BrandMenuCategoryProvider.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:oreeed/providers/CheckOutProvider.dart';
import 'package:oreeed/providers/CountryProvider.dart';
import 'package:oreeed/providers/NetworkProvider.dart';
import 'package:oreeed/providers/NotificationProvider.dart';
import 'package:oreeed/providers/ProductsProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Library/Language_Library/lib/easy_localization_delegate.dart';
import 'Library/Language_Library/lib/easy_localization_provider.dart';
import 'UI/BottomNavigationBar.dart';
import 'Utiles/databaseHelper.dart';

/// Run first apps open
void main() {
  BrandMenuCategoryProvider();
  runApp(
    Phoenix(
      child: EasyLocalization(
        // child: MaterialApp(home: ThirdScreen()),
        child: MyApp(),
      ),
    ),
  );
}

/// Set orienttation
class MyApp extends StatelessWidget {
  changeAppBar() async {
    // change the status bar color to material color [green-400]
    try {
      await FlutterStatusbarcolor.setStatusBarColor(Color(0xffF7BE00));
      if (useWhiteForeground(Color(0xffF7BE00))) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      }
    } catch (e) {}

// change the navigation bar color to material color [orange-200]
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(Color(0xff033766));
      if (useWhiteForeground(Color(0xff033766))) {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    // /// To set orientation always portrait
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    // ///Set color status bar
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    // ));

    changeAppBar();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckOutProvider()),
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CountryProvider()),
        ChangeNotifierProvider(create: (_) => BrandMenuCategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: EasyLocalizationProvider(
        data: data,
        child: new MaterialApp(
          title: "oreeed",
          theme: ThemeData(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              primaryColorLight: Colors.white,
              primaryColorBrightness: Brightness.light,
              primaryColor: Colors.white),
          debugShowCheckedModeBanner: false,
          // home: ThirdScreen(),
          home: SplashScreen(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            EasylocaLizationDelegate(
              locale: data.locale,
              path: 'assets/language',
            )
          ],
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
          locale: data.savedLocale,
        ),
      ),
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  /// Check user
  bool isLogin = false;
  bool sawIntro = false;

  SharedPreferences prefs;

  Future<Null> _session() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getBool("isLogin") != null) {
        if (prefs.getBool("sawIntro") != null) {
          sawIntro = true;
        } else {
          sawIntro = false;
        }
        isLogin = true;
      } else {
        if (prefs.getBool("sawIntro") != null) {
          sawIntro = true;
        } else {
          sawIntro = false;
        }
        isLogin = false;
      }
    });
    navigatorPage();
  }

  /// To navigate layout change
  void navigatorPage() {
    if (!sawIntro) {
      /// if userhas never been login
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ThirdScreen(),
          // pageBuilder: (_, __, ___) => onBoarding(),
        ),
      );
    } else {
      /// if userhas ever been login
      if (isLogin) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => BottomNavigationBarPage(),
          ),
        );
      } else {
        Navigator.of(context).push(
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => new BottomNavigationBarPage(),
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
      }
    }
  }

  Future updateFBToken(context) async {
    try {
      DatabaseHelper helper = DatabaseHelper();
      User _user;
      _user = (await helper.getUserList())[0];
      userId = _user.id;
      var token = await FirebaseMessaging().getToken();
      print(token);
      var response = await Dio().post(
        (baseuRL + 'update_firebase_code'),
        data: ({
          "firebase_token": token,
          "customer_id": _user.id,
        }),
      );
      print(response.data);

      return response.data;
    } on DioError catch (error) {
      print('DIO ERROR');
      print(error);
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CANCEL:
          return throw error;
          break;
        default:
          return throw error;
      }
    } catch (error) {
      return throw error;
    }
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    _session();
    updateFBToken(context);
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Color(0xff033766)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/oreeedImages/splash_logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          "oreeed",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Color(0xffF7BE08),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  ThirdScreen();

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  var _fontDescriptionStyle = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15.0,
      color: appBlue,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppProvider>(builder: (context, appProvider, child) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/intro/${appProvider.splashIndex}.png",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Text(
                  appProvider.centerText[appProvider.splashIndex - 1],
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs;
                        prefs = await SharedPreferences.getInstance();
                        if (appProvider.splashIndex == 1) {
                          prefs.setBool("sawIntro", true);

                          if (prefs.getBool("isLogin") == true) {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    BottomNavigationBarPage(),
                              ),
                            );
                          } else {
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
                          }
                        }
                        if (appProvider.splashIndex <= 0) {
                        } else {
                          appProvider.updateSplashIndex(-1);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xffF7BE00),
                            boxShadow: [
                              BoxShadow(blurRadius: 10.0, color: Colors.white)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              appProvider.splashIndex == 1 ? "Skip" : "Back",
                              style: TextStyle(
                                  color: Color(0xff033766),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          radius: appProvider.splashIndex == 1 ? 5 : 7,
                          backgroundColor: appProvider.splashIndex == 1
                              ? Color(0xff033766)
                              : Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: appProvider.splashIndex == 2 ? 5 : 7,
                          backgroundColor: appProvider.splashIndex == 2
                              ? Color(0xff033766)
                              : Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: appProvider.splashIndex == 3 ? 5 : 7,
                          backgroundColor: appProvider.splashIndex == 3
                              ? Color(0xff033766)
                              : Colors.white,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (appProvider.splashIndex == 3) {
                          SharedPreferences prefs;
                          prefs = await SharedPreferences.getInstance();
                          prefs.setBool("sawIntro", true);
                          if (prefs.getBool("isLogin") == true) {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    BottomNavigationBarPage(),
                              ),
                            );
                          } else {
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
                          }
                        }
                        if (appProvider.splashIndex <= 0) {
                        } else {
                          appProvider.updateSplashIndex(1);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Color(0xffF7BE00),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10.0, color: Colors.black12)
                              ]),
                          child: Center(
                            child: Text(
                              appProvider.splashIndex == 3 ? "Done" : "Next",
                              style: TextStyle(
                                  color: Color(0xff033766),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
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
