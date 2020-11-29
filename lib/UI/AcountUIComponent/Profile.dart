import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/AcountUIComponent/AboutApps.dart';
import 'package:oreed/UI/AcountUIComponent/CallCenter.dart';
import 'package:oreed/UI/AcountUIComponent/CreditCardSetting.dart';
import 'package:oreed/UI/AcountUIComponent/Notification.dart';
import 'package:oreed/UI/AcountUIComponent/languageSetting.dart';
import 'package:oreed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreed/UI/LoginOrSignup/NewLogin.dart';
import 'package:oreed/UI/OrderUIComponent/OrderHistory.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/Utiles/databaseHelper.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

import 'ProfileInfo.dart';
import 'Settings.dart';

class profil extends StatefulWidget {
  @override
  _profilState createState() => _profilState();
}

class _profilState extends State<profil> {
  final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();

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
    var lineTxtStyle = TextStyle(
        fontFamily: "Montserrat",
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.grey);
    Widget spacer() {
      return SizedBox(
        height: 5,
      );
    }

    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding: EdgeInsets.only(
        top: 135.0,
      ),
      child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(),
            !liveSession
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: appYellow,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Guest, Mode",
                          style: lineTxtStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Try Login Or Register",
                          style: lineTxtStyle,
                        )
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 125.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue, width: 2.5),
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "http://oreeed.com/${_user.avatar.toString()}",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 100,
                            child: InkWell(
                              onTap: () async {
                                if (liveSession) {
                                  var image1 = await ImagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  var base64Avatar =
                                      base64Encode(image1.readAsBytesSync());
                                  authProvider.uploadUserImage(
                                      scaffoldKey: _ScaffoldKey,
                                      base64Image: base64Avatar,
                                      userId: int.parse(_user.id));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Container(
                                      height: 45,
                                      child: Center(
                                        child: Text(
                                            "login Or register to setup your profile"),
                                      ),
                                    ),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: appBlue,
                                    elevation: 5,
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                }
                              },
                              child: Icon(
                                Icons.camera_alt,
                                size: 25,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //FileImage(authProvider.model.avatar),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                liveSession ? _user.firstName ?? "" : "",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FittedBox(
                              child: Text(
                                liveSession
                                    ? "${_user.email.toString()}"
                                    : "guest@oreeed.com",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            Container(),
          ],
        );
      }),
    );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _ScaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            color: appBlue, //Colors.white,
            child: Stack(
              children: <Widget>[
                /// Setting Header Banner
                Container(
                  color: appBlue,
                  child: Column(
                    children: <Widget>[
                      _profile,
                    ],
                  ),
                ),

                /// Calling _profile variable
                Positioned(
                  top: -85,
                  right: -85,
                  width: 200.0,
                  height: 200.0,
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/oreedImages/splash_logo.png"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 15,
                  width: 200.0,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 18.0, left: 10, right: 10),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 400.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        color: Colors.white),
                    child: Column(
                      /// Setting Category List
                      children: <Widget>[
                        category(
                          txt: liveSession
                              ? AppLocalizations.of(context).tr('editProfile')
                              : AppLocalizations.of(context).tr('login'),
                          padding: 35.0,
                          tap: () {
                            if (liveSession) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new ProfileInfo(),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new NewLogin()));
                            }
                          },
                        ),
                        category(
                          txt:
                              AppLocalizations.of(context).tr('settingAccount'),
                          padding: 35.0,
                          tap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new Settings(),
                              ),
                            );
                          },
                        ),

                        /// Call category class
                        category(
                          txt: AppLocalizations.of(context).tr('notification'),
                          padding: 35.0,
                          tap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new notification(),
                              ),
                            );
                          },
                        ),
                        category(
                          txt: AppLocalizations.of(context).tr('payments'),
                          padding: 35.0,
                          tap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    new creditCardSetting(),
                              ),
                            );
                          },
                        ),
                        category(
                          txt: AppLocalizations.of(context).tr('myOrders'),
                          padding: 23.0,
                          tap: () {
                            if (liveSession) {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new OrderHome()));
                            } else {
                              ShowSnackBar(
                                  context: context,
                                  msg: "Login to see your orders history",
                                  bgColor: Colors.grey.withOpacity(0.5),
                                  textColor: Colors.black,
                                  height: 25);
                            }
                          },
                        ),

                        category(
                          txt: AppLocalizations.of(context).tr('language'),
                          padding: 30.0,
                          tap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    new languageSetting(),
                              ),
                            );
                          },
                        ),
                        category(
                          txt: AppLocalizations.of(context).tr('callCenter'),
                          padding: 30.0,
                          tap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new callCenter(),
                              ),
                            );
                          },
                        ),

                        category(
                          padding: 38.0,
                          txt: AppLocalizations.of(context).tr('aboutApps'),
                          tap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new aboutApps(),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(String userName) async {
    await showDialog<String>(
      context: context,
      child: new _SystemPadding(
        child: new AlertDialog(
          contentPadding: EdgeInsets.only(top: 150, left: 16, right: 16),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'User Name', hintText: userName),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('OPEN'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 18, bottom: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(txt),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
