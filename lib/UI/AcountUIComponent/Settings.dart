import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/GenralWidgets/BackButton.dart';
import 'package:oreed/UI/HomeUIComponent/Widgets/CustomDialog.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<Settings> {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Montserrat",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLocalNotifications();
  }

  _initLocalNotifications() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future _showNotification() async {
    try {
      //print("############################################# _showNotification");
      print("started ...");

      var platformChannelSpecificsAndroid = new AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          playSound: true,
          enableVibration: true,
          ticker: 'ticker',
          importance: Importance.Max,
          priority: Priority.High);
      var platformChannelSpecificsIos =
          new IOSNotificationDetails(presentSound: false);
      var platformChannelSpecifics = new NotificationDetails(
          platformChannelSpecificsAndroid, platformChannelSpecificsIos);

      new Future.delayed(Duration.zero, () async {
        print(
            "############################################# _showNotification");
        print("Notifying ...");
        await _flutterLocalNotificationsPlugin.show(
          1,
          "تطبيق اريد",
          "تم تفعيل الاشعارات بنجاح ",
          platformChannelSpecifics,
          payload: 'No_Sound',
        );
      });

      //print("############################################# _showNotification");
      print("Ended ...");
    } catch (Exception) {
      //print("############################################# Exception");
      print(Exception.toString());
    }
  }

  initValues(context) async {
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    var userData = Provider.of<AuthProvider>(context);
    return EasyLocalizationProvider(
      data: data,
      child: BackButtonBtn(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).tr('settingAccount'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontFamily: "Montserrat"),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Color(0xFF6991C7),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                return Column(
                  children: <Widget>[
                    settingContainer(),
                    userData.loginCheck
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: InkWell(
                              onTap: () {
                                print("You are trying to logout , ");
                                initValues(context);
                              },
                              child: Container(
                                height: 50.0,
                                width: 1000.0,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13.0, left: 20.0, bottom: 15.0),
                                  child: Text(
                                    AppLocalizations.of(context).tr('logout'),
                                    style: _txtCustomHead,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  bool _bookingNotify = false;
  bool _discountNotification = false;
  Widget settingContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        height: 235.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                child: Text(
                  AppLocalizations.of(context).tr('setting'),
                  style: _txtCustomHead,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('orderNotification'),
                        style: _txtCustomSub,
                      ),
                      Switch(
                        value: _bookingNotify,
                        onChanged: (value) async {
                          setState(() {
                            _bookingNotify = !_bookingNotify;
                          });
                          if (_bookingNotify) {
                            _showNotification();
                          }
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('discountNotification'),
                        style: _txtCustomSub,
                      ),
                      Switch(
                        value: _discountNotification,
                        onChanged: (value) async {
                          setState(() {
                            _discountNotification = !_discountNotification;
                          });
                          if (_discountNotification) {
                            _showNotification();
                          }
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Setting extends StatefulWidget {
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Montserrat",
  );

  String head, sub1, sub2, sub3;

  Setting({this.head, this.sub1, this.sub2, this.sub3});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        height: 235.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                child: Text(
                  widget.head,
                  style: Setting._txtCustomHead,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.sub1,
                        style: Setting._txtCustomSub,
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "Would you like to create a free account?",
                      description:
                          "With an account, your data will be securely saved, allowing you to access it from multiple devices.",
                      primaryButtonText: "Create My Account",
                      primaryButtonRoute: "/signUp",
                      secondaryButtonText: "Maybe Later",
                      secondaryButtonRoute: "/anonymousSignIn",
                    ),
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.sub2,
                          style: Setting._txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.sub3,
                        style: Setting._txtCustomSub,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog() async {
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
                      labelText: 'Full Name', hintText: 'eg. John Smith'),
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
