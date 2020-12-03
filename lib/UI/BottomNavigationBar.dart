import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/UI/AcountUIComponent/Profile.dart';
import 'package:oreeed/UI/BrandUIComponent/BrandLayout.dart';
import 'package:oreeed/UI/CartUIComponent/CartLayout.dart';
import 'package:oreeed/UI/HomeUIComponent/Home.dart';

import 'GenralWidgets/NetworkSensitive.dart';

class BottomNavigationBarPage extends StatefulWidget {
  final int initIndex;
  BottomNavigationBarPage({this.initIndex});
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return NetworkSensitive(child: Menu());
      case 1:
        return NetworkSensitive(child: brand());
      case 2:
        return NetworkSensitive(child: cart());
      case 3:
        return NetworkSensitive(child: profil());
        break;
      default:
        return NetworkSensitive(child: Menu());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initIndex != null ? widget.initIndex : 0;
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: callPage(currentIndex),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              textTheme: Theme.of(context).textTheme.copyWith(
                    caption: TextStyle(color: Colors.black26.withOpacity(0.15)),
                  ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              fixedColor: Color(0xff033766),
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 23.0,
                  ),
                  title: Text(
                    AppLocalizations.of(context).tr('home'),
                    style:
                        TextStyle(fontFamily: "Montserrat", letterSpacing: 0.5),
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    title: Text(
                      "Wishlist",
                      style: TextStyle(
                          fontFamily: "Montserrat", letterSpacing: 0.5),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    title: Text(
                      AppLocalizations.of(context).tr('cart'),
                      style: TextStyle(
                          fontFamily: "Montserrat", letterSpacing: 0.5),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 24.0,
                    ),
                    title: Text(
                      AppLocalizations.of(context).tr('account'),
                      style: TextStyle(
                          fontFamily: "Montserrat", letterSpacing: 0.5),
                    )),
              ],
            )),
      ),
    );
  }
}
