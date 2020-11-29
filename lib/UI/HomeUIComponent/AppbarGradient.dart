import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/AcountUIComponent/Notification.dart';
import 'package:oreed/UI/HomeUIComponent/Search.dart';
import 'package:oreed/providers/NotificationProvider.dart';
import 'package:provider/provider.dart';

class AppbarGradient extends StatefulWidget {
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient> {
  String CountNotice = "4";

  /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {
    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    var data = EasyLocalizationProvider.of(context).data;

    /// Create component in appbar
    return EasyLocalizationProvider(
      data: data,
      child: Container(
        padding: EdgeInsets.only(top: statusBarHeight, left: 12, right: 12),
        height: 58.0 + statusBarHeight,
        child: Consumer<NotificationProvider>(
            builder: (ctnx, notificationProvider, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              /// if user click shape white in appbar navigate to search layout
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => searchAppbar(),

                          /// animation route to search layout
                          transitionsBuilder: (_, Animation<double> animation,
                              __, Widget child) {
                            return Opacity(
                              opacity: animation.value,
                              child: child,
                            );
                          }),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      height: 45.0,
                      width: 177,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 10.0, color: Colors.black12)
                          ]),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            child: Text("Search ...",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 58,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new notification(),
                      ),
                    );
                  },
                  child: !(notificationProvider.getNotifications.length > 0)
                      ? Stack(
                          alignment: AlignmentDirectional(-.750, -.85),
                          children: <Widget>[
                            Icon(
                              Icons.notifications,
                              size: 34.0,
                              color: Color(0xff033766),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: CircleAvatar(
                                radius: 8.6,
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  notificationProvider.getNotifications.length
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(),
                ),
              ),

              /// Icon notification (if user click navigate to notification layout)
            ],
          );
        }),
      ),
    );
  }
}
