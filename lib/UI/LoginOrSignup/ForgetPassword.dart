import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreed/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:oreed/UI/LoginOrSignup/NewLogin.dart';
import 'package:oreed/UI/LoginOrSignup/widgets/TextFromField.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  AnimationController sanimationController;

  final GlobalKey<ScaffoldState> _forgotPasswordfoScaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _forgotPasswordfoScaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xff033766), //Colors.white,
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
                        Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Montserrat"),
                        ),
                        Text(
                          "Please Enter the E-mail address \n associated with your account.",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat"),
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
                        image: AssetImage("assets/oreedImages/splash_logo.png"),
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
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 30,
                                ),
                              ),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       image: DecorationImage(
                              //           image: AssetImage(
                              //               'assets/avatars/forgot_password.png'),
                              //           fit: BoxFit.fitHeight),
                              //     ),
                              //     height:
                              //         MediaQuery.of(context).size.width / 3 +
                              //             10,
                              //     width: MediaQuery.of(context).size.width *
                              //         3 /
                              //         4, //double.infinity,
                              //   ),
                              // ),

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

                              /// Button Signup
                              FlatButton(
                                padding: EdgeInsets.only(top: 35.0),
                                onPressed: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new NewLogin(),
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

                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         new NewLogin(),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  "Remembered My Password, Login",
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
                                  var authProvider = Provider.of<AuthProvider>(
                                      context,
                                      listen: false);
                                  if (_formKey.currentState.validate()) {
                                    print("email: ${authProvider.model.email}");
                                    _formKey.currentState.save();
                                    if (authProvider.model.email != null) {
                                      authProvider.processForgotPassword(
                                          scaffoldKey:
                                              _forgotPasswordfoScaffoldKey,
                                          email: authProvider.model.email);
                                    } else {
                                      // _forgotPasswordfoScaffoldKey.currentState
                                      //     .showSnackBar(SnackBar(
                                      //   content: Text(
                                      //       'Please Fill in all empty fields'),
                                      // ));

                                      ShowSnackBar(
                                          context: _forgotPasswordfoScaffoldKey
                                              .currentContext,
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
                                animationController: sanimationController.view,
                              ),
                        Padding(padding: EdgeInsets.only(bottom: 20.0)),
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
          "Rest Password",
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
              colors: <Color>[Color(0xffF7BE08), Color(0xffF7BE00)]),
        ),
      ),
    );
  }
}
