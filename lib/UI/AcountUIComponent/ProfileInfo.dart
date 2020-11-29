import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/AcountUIComponent/EditProfile.dart';
import 'package:oreed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreed/UI/LoginOrSignup/widgets/TextFromField.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/Utiles/databaseHelper.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _profileInfoState createState() => _profileInfoState();
}

class _profileInfoState extends State<ProfileInfo> {
  final GlobalKey<ScaffoldState> _addInfoScaffoldKey =
      GlobalKey<ScaffoldState>();
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

  initValues(context) async {
    Phoenix.rebirth(context);
  }

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
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _addInfoScaffoldKey,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('ProfileInfo'),
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
            child:
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
              return Column(
                children: <Widget>[
                  DetailPage(
                    parentKey: _addInfoScaffoldKey,
                    user: _user,
                    flag: liveSession,
                  ),
                  InkWell(
                    onTap: () {
                      print("You Are trying to logOut , ");
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Log Out",
                        desc:
                            "Are You Sure You Want to \nlog out of your oreeed account !",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "LogOut",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              authProvider.logMeOut(_user.id).then((value) {
                                initValues(context);
                              });
                            },
                            color: Colors.redAccent,
                          ),
                          DialogButton(
                            child: Text(
                              "cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.blueGrey,
                          )
                        ],
                      ).show();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 30, right: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.lock_open,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                liveSession
                                    ? Text(
                                        AppLocalizations.of(context)
                                            .tr('logout'),
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      )
                                    : Text(
                                        AppLocalizations.of(context)
                                            .tr('login'),
                                        style: TextStyle(color: appBlue),
                                      ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.redAccent,
                            )
                          ]),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  GlobalKey<ScaffoldState> parentKey;
  bool flag;
  User user;

  DetailPage({this.parentKey, this.flag, this.user});

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
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  // controllers for form text controllers
  final TextEditingController _oldPasswordController =
      new TextEditingController();
  final TextEditingController _newPasswordController =
      new TextEditingController();

  int _ageCalculator(DateTime birthDate) {
    Duration dur = DateTime.now().difference(birthDate);
    int differenceInYears = (dur.inDays / 365).floor();
    return differenceInYears;
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: widget.flag
          ? Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: widget.flag
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0,
                                  top: 15.0,
                                  left: 2.0,
                                  right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .tr('ProfileInfo'),
                                    style: DetailPage._txtCustomHead,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context, scrollController) =>
                                            Container(
                                          child: Column(
                                            children: [
                                              Expanded(child: EditProfile()),
                                            ],
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              20,
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.blueGrey,
                                      elevation: 5,
                                      child: Container(
                                        height: 30,
                                        // width: 30,
                                        child: Center(
                                          child: OutlineButton.icon(
                                            onPressed: () {},
                                            label: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black12,
                                height: 0.5,
                              ),
                            ),
                            RowElement("address ",
                                widget.user.defaultAddressId.toString()),
                            RowElement("default address ",
                                widget.user.defaultAddressId.toString()),
                            RowElement("First Name ",
                                widget.user.firstName.toString()),
                            RowElement(
                                "Last Name ", widget.user.lastName.toString()),
                            RowElement(
                                "User Name ", widget.user.userName.toString()),
                            RowElement("Phone ", widget.user.phone.toString()),
                            RowElement("Email ", widget.user.email.toString()),
                            RowElement(
                                "Gender ", widget.user.gender.toString()),
                            RowElement(
                                "Age   ",
                                _ageCalculator(DateTime.parse(widget.user.dob ??
                                        DateTime.now().toIso8601String()))
                                    .toString()),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black12,
                                height: 0.5,
                              ),
                            ),
                            widget.flag
                                ? InkWell(
                                    onTap: () {
                                      Alert(
                                        context: context,
                                        title: "Change Password",
                                        type: AlertType.warning,
                                        content: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: <Widget>[
                                                    /// Set Text
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                    ),

                                                    /// TextFromField first
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                    ),
                                                    TextFromFieldEditMode(
                                                      myContrller:
                                                          _oldPasswordController,
                                                      icon: Icons.lock,
                                                      isEmail: false,
                                                      isPassword: true,
                                                      validator:
                                                          (String value) {
                                                        if (value.isEmpty) {
                                                          return AppLocalizations
                                                                  .of(context)
                                                              .tr('oldPassword');
                                                        }
                                                        return null;
                                                      },
                                                      onChange: (value) {},
                                                      hintText: AppLocalizations
                                                              .of(context)
                                                          .tr('oldPassword'),
                                                      inputType:
                                                          TextInputType.text,
                                                    ),

                                                    /// TextFromField rest name
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child:
                                                          TextFromFieldEditMode(
                                                        myContrller:
                                                            _newPasswordController,
                                                        icon: Icons.lock,
                                                        isEmail: false,
                                                        isPassword: true,
                                                        validator:
                                                            (String value) {
                                                          if (value.isEmpty) {
                                                            return AppLocalizations
                                                                    .of(context)
                                                                .tr('newPassword');
                                                          }
                                                          if (value.length <
                                                              6) {
                                                            return AppLocalizations
                                                                    .of(context)
                                                                .tr('newPassword');
                                                          }
                                                          return null;
                                                        },
                                                        onChange: (value) {},
                                                        hintText: AppLocalizations
                                                                .of(context)
                                                            .tr('newPassword'),
                                                        inputType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Change",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              var authProvider =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                authProvider.processChangePassword(
                                                    oldPassword:
                                                        _oldPasswordController
                                                            .text,
                                                    newPassword:
                                                        _newPasswordController
                                                            .text,
                                                    scaffoldKey:
                                                        widget.parentKey,
                                                    customerId: int.parse(
                                                        widget.user.id));
                                              } else {
                                                ShowSnackBar(
                                                    context: context,
                                                    msg:
                                                        "Try to remember the old password and try .",
                                                    bgColor: Colors.blue
                                                        .withOpacity(0.5),
                                                    textColor: Colors.black,
                                                    height: 25);
                                              }
                                            },
                                            color: Colors.redAccent,
                                          ),
                                          DialogButton(
                                            child: Text(
                                              "cancel",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            color: Color(0xfff1f1f1),
                                          )
                                        ],
                                      ).show();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 15.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.security,
                                                  color: Colors.redAccent,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Change My Password",
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.redAccent,
                                            )
                                          ]),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black12,
                                height: 0.5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black12,
                                height: 0.5,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          child: Center(
                            child: Text("Try To LogIn please"),
                          ),
                        ),
                ),
              ),
            )
          : Container(
              child: Center(
                child: Text("Try To LogIn please"),
              ),
            ),
    );
  }

  // int _ageCalculator(String birDate) {
  //   String strDate =
  //       birDate == null || birDate.trim() == "null" || birDate.trim() == ""
  //           ? DateTime.now().toIso8601String()
  //           : birDate;
  //   DateTime dob = DateTime.parse(strDate);
  //   Duration dur = DateTime.now().difference(dob);
  //
  //   int differenceInYears = (dur.inDays / 365).floor();
  //   return differenceInYears;
  // }

  Widget RowElement(String key, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        CircleAvatar(
          radius: 7,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(value == null ||
                        value.trim() == "" ||
                        value.toString().trim() == "null" ||
                        value.toString().trim() == "0"
                    ? "assets/avatars/unchecked.png"
                    : "assets/avatars/checked.png"),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          key,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
        ),
        Text(
          " : " + value == null ||
                  value.trim() == "" ||
                  value.toString().trim() == "null" ||
                  value.toString().trim() == "0"
              ? "------------------------------"
              : value,
          style: DetailPage._txtCustomSub,
        ),
      ]),
    );
  }
}

///ButtonBlack class
class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0, left: 5, right: 5),
      child: Container(
        height: 55.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(),
            Icon(Icons.clear),
            Container(
              width: 5,
            ),
            Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.2,
                  fontFamily: "Montserrat",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
