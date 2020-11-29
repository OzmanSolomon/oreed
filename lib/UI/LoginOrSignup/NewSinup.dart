import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:oreed/UI/LoginOrSignup/NewLogin.dart';
import 'package:oreed/UI/LoginOrSignup/widgets/TextFromField.dart';
import 'package:oreed/Utiles/Constants.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

import 'widgets/DropDownList.dart';

class NewSinUp extends StatefulWidget {
  @override
  _NewSinupState createState() => _NewSinupState();
}

class _NewSinupState extends State<NewSinUp> {
  final _formKey = GlobalKey<FormState>();
  AnimationController sanimationController;
  final _genderNotifier = ValueNotifier<bool>(true);

  final GlobalKey<ScaffoldState> _addInfoScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _addInfoScaffoldKey,
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity > 0) {
              Navigator.of(context).pop();
            }
            print("${details.primaryVelocity}");
          },
          child: SingleChildScrollView(
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
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
//                              fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Do already have account ? ',
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("don't Hit me !");
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new NewLogin(),
                                          ),
                                        );
                                      },
                                    text: ' Sign In',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow)),
                              ],
                            ),
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
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                ),

                                /// TextFromField Email
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.0),
                                ),
                                TextFromField(
                                  icon: Icons.person,
                                  isEmail: false,
                                  isPassword: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Pleas Fill in the name';
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserFirstName(value);
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserName(value);
                                  },
                                  hintText: AppLocalizations.of(context)
                                      .tr('firstName'),
                                  inputType: TextInputType.emailAddress,
                                ),

                                /// TextFromField Email
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.0),
                                ),
                                TextFromField(
                                  icon: Icons.person,
                                  isEmail: false,
                                  isPassword: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .tr('restName');
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserLastName(value);
                                  },
                                  hintText: AppLocalizations.of(context)
                                      .tr('restName'),
                                  inputType: TextInputType.emailAddress,
                                ),

                                /// TextFromField Email
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.0)),
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

                                /// TextFromField Phone
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.0)),
                                TextFromField(
                                  keyBoardType: TextInputType.number,
                                  icon: Icons.phone,
                                  isEmail: false,
                                  isPassword: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Fill In Your Phone Number';
                                    }
                                    if (value.length < 10) {
                                      return 'Please Fill In a Valid Phone Number';
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserPhone(value);
                                  },
                                  hintText: AppLocalizations.of(context)
                                      .tr('enterPhoneNumber'),
                                  inputType: TextInputType.emailAddress,
                                ),

                                /// TextFromField country
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.0),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(horizontal: 30.0),
                                //   child: Container(
                                //       height: 60.0,
                                //       alignment: AlignmentDirectional.center,
                                //       decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(14.0),
                                //           color: Colors.white,
                                //           boxShadow: [
                                //             BoxShadow(
                                //                 blurRadius: 10.0,
                                //                 color: Colors.black12)
                                //           ]),
                                //       padding: EdgeInsets.only(
                                //           left: 20.0,
                                //           right: 30.0,
                                //           top: 0.0,
                                //           bottom: 0.0),
                                //       child: CountriesDropDown()),
                                // ),

                                /// TextFromField Password
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.0)),

                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Container(
                                      height: 60.0,
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10.0,
                                                color: Colors.black12)
                                          ]),
                                      padding: EdgeInsets.only(
                                          left: 20.0,
                                          right: 30.0,
                                          top: 0.0,
                                          bottom: 0.0),
                                      child: TimeZoneDropDown()),
                                ),

                                /// TextFromField Password
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.0)),
                                TextFromField(
                                  icon: Icons.vpn_key,
                                  isPassword: true,
                                  hintText: AppLocalizations.of(context)
                                      .tr('password'),
                                  inputType: TextInputType.text,
                                  isEmail: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter Your Password';
                                    }
                                    if (value.length < 6) {
                                      return "password must be at least 6 digits long";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserPassword(value);
                                  },
                                ),

                                /// TextFromField Confirme Password
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.0)),
                                TextFromField(
                                  icon: Icons.vpn_key,
                                  isPassword: true,
                                  hintText: AppLocalizations.of(context)
                                      .tr('cPassword'),
                                  inputType: TextInputType.text,
                                  isEmail: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please ReEnter Your Password';
                                    }
                                    if (value.length < 6) {
                                      return "password must be at least 6 digits long";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserCPassword(value);
                                  },
                                ),

                                /// TextFromField Confirme Password
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                ),

                                new Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 45, right: 12),
                                      child: ValueListenableBuilder(
                                        valueListenable: _genderNotifier,
                                        builder: (_, value, __) => Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (_genderNotifier.value) {
                                                    print("gender is male");
                                                  }
                                                  _genderNotifier.value =
                                                      !value;
                                                  Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .setUserGender(value);
                                                },
                                                child: Opacity(
                                                  opacity:
                                                      !_genderNotifier.value
                                                          ? 0.99
                                                          : 0.5,
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            appBlue,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Male")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _genderNotifier.value =
                                                      !value;
                                                  if (_genderNotifier.value) {
                                                    print("gender is female");
                                                  }
                                                  Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .setUserGender(value);
                                                },
                                                child: Opacity(
                                                  opacity: _genderNotifier.value
                                                      ? 0.99
                                                      : 0.6,
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            appBlue,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Female")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                /// Button Signup
                                FlatButton(
                                  padding: EdgeInsets.only(top: 25.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new NewLogin(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .tr('notHaveLogin'),
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
                                      _formKey.currentState.save();
                                      if (authProvider.model.email != null &&
                                          authProvider.model.password != null) {
                                        authProvider.processRegistration(
                                            scaffoldKey: _addInfoScaffoldKey);
                                      }
                                    }
                                  },
                                  child: buttonBlackBottom(),
                                )
                              : new LoginAnimation(
                                  animationController:
                                      sanimationController.view,
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
          AppLocalizations.of(context).tr('signUp'),
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
