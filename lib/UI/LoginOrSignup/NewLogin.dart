import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreed/UI/LoginOrSignup/ForgetPassword.dart';
import 'package:oreed/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:oreed/UI/LoginOrSignup/NewSinup.dart';
import 'package:oreed/UI/LoginOrSignup/widgets/TextFromField.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class NewLogin extends StatefulWidget {
  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final _formKey = GlobalKey<FormState>();
  AnimationController sanimationController;

  final GlobalKey<ScaffoldState> _addInfoScaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    var userData = Provider.of<AuthProvider>(context);

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _addInfoScaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xff033766), //Colors.white,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity > 0) {
                  Navigator.of(context).pop();
                }
                print("${details.primaryVelocity}");
              },
              child: Stack(
                children: <Widget>[
                  /// Setting Header Banner
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      height: MediaQuery.of(context).size.width - 134,
                      width: MediaQuery.of(context).size.width - 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                'assets/icon/left-arrow.png',
                                scale: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
//                              fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Please fill E-mail & password to login",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
//                              fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "your app account.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
//                              fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat"),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                new NewSinUp(),
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
                                      " OR New  Sing Up",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: appYellow,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Calling _profile variable
                  Positioned(
                    top: -85,
                    right: -85,
                    width: 220.0,
                    height: 220.0,
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              AssetImage("assets/oreedImages/splash_logo.png"),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width - 110),
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
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                /// Set Text
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                ),

                                /// TextFromField Email
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                ),
                                TextFromField(
                                  icon: Icons.email,
                                  isEmail: true,
                                  isPassword: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Example1: user@email.com';
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return "Example2: user@email.com";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    var validEmail =
                                        EmailValidator.validate(value);
                                    print("email valid is :$validEmail");
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserEmail(value);
                                  },
                                  hintText:
                                      AppLocalizations.of(context).tr('email'),
                                  inputType: TextInputType.emailAddress,
                                ),

                                /// TextFromField Password
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0)),
                                TextFromField(
                                  icon: Icons.vpn_key,
                                  isPassword: true,
                                  hintText: AppLocalizations.of(context)
                                      .tr('password'),
                                  inputType: TextInputType.text,
                                  isEmail: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Password';
                                    }
                                    if (value.length < 6) {
                                      return "at least 6 digits long";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    print("password is :$value");
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserPassword(value);
                                  },
                                ),

                                FlatButton(
                                  padding: EdgeInsets.only(top: 50.0),
                                  onPressed: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            new ForgetPassword(),
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
                                        }));
                                  },
                                  child: Text(
                                    "Forgot Your Password !",
                                    style: TextStyle(
                                        color: Color(0xff033766),
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat"),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Set Animaion after user click buttonLogin
                          Provider.of<AuthProvider>(context, listen: false)
                                  .logintabed
                              ? InkWell(
                                  splashColor: Colors.yellow,
                                  onTap: () async {
                                    var authProvider =
                                        Provider.of<AuthProvider>(context,
                                            listen: false);
                                    if (_formKey.currentState.validate()) {
                                      print(
                                          "email: ${authProvider.model.email}");
                                      print(
                                          "password: ${authProvider.model.password}");
                                      _formKey.currentState.save();
                                      if (authProvider.model.email != null &&
                                          authProvider.model.password != null) {
                                        authProvider.login(
                                            scaffoldKey: _addInfoScaffoldKey,
                                            password:
                                                authProvider.model.password,
                                            email: authProvider.model.email);
                                      } else {
                                        // _addInfoScaffoldKey.currentState
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(
                                        //         'Please Fill in all empty fields'),
                                        //   ),
                                        // );

                                        ShowSnackBar(
                                            context: context,
                                            msg:
                                                "Please Fill in all empty fields",
                                            bgColor: Colors.grey,
                                            textColor: Colors.black,
                                            height: 25);
                                      }
                                    }
                                  },
                                  child: buttonBlackBottom(),
                                )
                              : new LoginAnimation(
                                  animationController:
                                      sanimationController.view,
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
      ),
    );
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

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          AppLocalizations.of(context).tr('login'),
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 0.2,
              fontFamily: "Montserrat",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xffF7BE08), Color(0xffF7BE00)])),
      ),
    );
  }
}
