import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/ListItem/notificationsData.dart';
import 'package:oreeed/UI/GenralWidgets/BackButton.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/providers/NotificationProvider.dart';
import 'package:provider/provider.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  final List<Post> items = new List();
  @override
  void initState() {
    super.initState();
    setState(() {
      items.add(
        Post(
            image: "assets/oreeedImages/logo.PNG",
            id: 1,
            title: "Oreeed Shop",
            desc: "Thanks for downloaded Oreeed shop application"),
      );
      items.add(
        Post(
            image: "assets/oreeedImages/logo.PNG",
            id: 2,
            title: "Oreeed Shop",
            desc: "Your Item Delivery"),
      );
      items.add(
        Post(
            image: "assets/oreeedImages/logo.PNG",
            id: 3,
            title: "Oreeed Shop",
            desc: "Pending List Item Shoes"),
      );
      items.add(
        Post(
            image: "assets/oreeedImages/logo.PNG",
            id: 4,
            title: "Oreeed Shop",
            desc: "Get 10% Discount for macbook pro 2018"),
      );
    });
  }

  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: BackButtonBtn(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).tr('notification'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontFamily: "Montserrat"),
            ),
            iconTheme: IconThemeData(
              color: const Color(0xFF6991C7),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: Consumer<NotificationProvider>(
              builder: (context, notificationProvider, _) {
            return notificationProvider.getNotifications.isNotEmpty
                ? ListView.builder(
                    itemCount: notificationProvider.getNotifications.length,
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (context, position) {
                      return Dismissible(
                          key: Key("$position"),
                          onDismissed: (direction) {
                            setState(() {
                              // notificationProvider.getNotifications
                              notificationProvider.deleteMessage(position);
                              // items.removeAt(position);
                            });
                          },
                          background: Container(
                            color: Color(0xFF6991C7),
                          ),
                          child: Container(
                            height: 88.0,
                            child: Column(
                              children: <Widget>[
                                Divider(height: 5.0),
                                ListTile(
                                  title: Text(
                                    '${notificationProvider.getNotifications[position].notification.title}',
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Container(
                                      width: 440.0,
                                      child: Text(
                                        '${notificationProvider.getNotifications[position].notification.body}',
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black38),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  leading: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(60.0)),
                                            image: DecorationImage(
                                                image: CachedNetworkImageProvider(
                                                    'http://oreeed.com/${notificationProvider.getNotifications[position].data.other}'),
                                                fit: BoxFit.fill)),
                                      )
                                    ],
                                  ),
                                  onTap: () =>
                                      _onTapItem(context, items[position]),
                                ),
                                Divider(height: 5.0),
                              ],
                            ),
                          ));
                    })
                : noItemNotifications();
          }),
        ),
      ),
    );
  }
}

void _onTapItem(BuildContext context, Post post) {
  ShowSnackBar(
      context: context,
      msg: post.id.toString() + ' - ' + post.title,
      bgColor: Colors.red.withOpacity(0.5),
      textColor: Colors.black,
      height: 25);
}

class noItemNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
            Image.asset(
              "assets/img/noNotification.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              AppLocalizations.of(context).tr('notHaveNotification'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Montserrat"),
            ),
          ],
        ),
      ),
    );
  }
}
