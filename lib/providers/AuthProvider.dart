import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization.dart';
import 'package:oreeed/Services/AuthRepo.dart';
import 'package:oreeed/UI/BottomNavigationBar.dart';
import 'package:oreeed/UI/GenralWidgets/ServerProcessLoader.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    getUserData();
  }

  Model model = Model();
  DatabaseHelper helper = DatabaseHelper();
  User _user;
  bool _isLoading = false;
  bool _loginCheck = false;
  bool _logintabed = true;
  bool _isSecurePassword = true;
  bool _isSecureCPassword = true;
  String _password = "1234567";
  bool get isLoading => _isLoading;
  bool get loginCheck => _loginCheck;
  User get getLoggedInUser => _user;
  bool get logintabed => _logintabed;
  String get checkPassword => _password;
  Model get user => model;

  void resetLoginButton() {
    _isLoading = false;
    notifyListeners();
  }

  void confirmLoginButton() {
    _isLoading = true;
    notifyListeners();
  }

  void resetLoginCheck() {
    _loginCheck = false;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUserAvatar(File avatar, String avatarStr) {
    model.avatar = avatar;
    model.avatarStr = avatarStr;
    notifyListeners();
  }

  void reSetUser() {
    model = new Model();
    notifyListeners();
  }

  bool get securePassword => _isSecurePassword;

  void togglePassword() {
    _isSecurePassword = !_isSecurePassword;
    notifyListeners();
  }

  bool get secureCPassword => _isSecureCPassword;
  void togglecPassword(bool value) {
    _isSecureCPassword = value;
    notifyListeners();
  }

  void setUserName(String strValue) {
    model.name = strValue;
    notifyListeners();
  }

  void setUserId(String strValue) {
    model.id = int.parse(strValue);
    notifyListeners();
  }

  void setUserFirstName(String strValue) {
    model.firstName = strValue;
    notifyListeners();
  }

  void setUserLastName(String strValue) {
    model.lastName = strValue;
    notifyListeners();
  }

  void setUserPassword(String strValue) {
    model.password = strValue;
    notifyListeners();
  }

  void setUserCPassword(String strValue) {
    model.cPassword = strValue;
    notifyListeners();
  }

  void setUserEmail(String strValue) {
    model.email = strValue;
    notifyListeners();
  }

  void setUserGender(bool strValue) {
    model.gender = strValue ? 1 : 2;
    notifyListeners();
  }

  void setUserPhone(String strValue) {
    model.phone = strValue;
    notifyListeners();
  }

  void setUserDateOfBirth(String strValue) {
    model.dob = strValue;
    notifyListeners();
  }

  void setUserAddress(String strValue) {
    model.address = strValue;
    notifyListeners();
  }

  void setUserFCMToken(String strValue) {
    model.fcmToken = strValue;
    notifyListeners();
  }

  void setUserGenderId(String strValue) {
    model.gender = int.parse(strValue);
    notifyListeners();
  }

  void getUserData() {
    helper.getUserList().then((user) {
      if (user != null && user.length > 0) {
        _user = user[0];
        _loginCheck = true;
        notifyListeners();
      }
    });
  }

  Future<bool> logMeOut(String userId) async {
    SharedPreferences prefs;
    await prefs.clear();
  }

  void login(
      {GlobalKey<ScaffoldState> scaffoldKey,
      String password,
      String email}) async {
    SharedPreferences prefs;
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );
    try {
      prefs = await SharedPreferences.getInstance();
      if (_user != null) {
        helper.deleteUser(int.parse(_user.id));
      }
      AuthRepo().login(email: email, password: password).then((apiResponse) {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              prefs.setBool("isLogin", true);
              var userData = Provider.of<AuthProvider>(
                  scaffoldKey.currentContext,
                  listen: false);

              userData.reSetUser();
              Navigator.of(scaffoldKey.currentContext).pushReplacement(
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          new BottomNavigationBarPage(),
                      transitionDuration: Duration(milliseconds: 750),

                      /// Set animation with opacity
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
              this.resetLoginButton();
              break;
            default:
              ShowSnackBar(
                  context: scaffoldKey.currentContext,
                  msg: apiResponse.msg,
                  bgColor: Colors.grey.withOpacity(0.5),
                  textColor: Colors.black,
                  height: 25);
              break;
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }

  void uploadUserImage(
      {GlobalKey<ScaffoldState> scaffoldKey,
      String base64Image,
      int userId}) async {
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(true);
          }),
    );
    try {
      AuthRepo()
          .uploadUserImage(base64Image: base64Image, userId: userId)
          .then((apiResponse) {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          if (apiResponse.code == 1) {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
            Navigator.of(scaffoldKey.currentContext).pushReplacement(
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        new BottomNavigationBarPage(initIndex: 3),
                    transitionDuration: Duration(milliseconds: 750)));
          } else {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }

  void processRegistration({GlobalKey<ScaffoldState> scaffoldKey}) async {
    //print("############# registration #####################");
    print(model.toMap());
    SharedPreferences prefs;
    Map<String, dynamic> userRegistration = model.toMap();
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );
    try {
      prefs = await SharedPreferences.getInstance();
      AuthRepo()
          .registration(userRegistration: userRegistration)
          .then((apiResponse) async {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              prefs.setBool("isLogin", true);
              var userData = Provider.of<AuthProvider>(
                  scaffoldKey.currentContext,
                  listen: false);
              userData.reSetUser();
              Navigator.of(scaffoldKey.currentContext).pushReplacement(
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          new BottomNavigationBarPage(),
                      transitionDuration: Duration(milliseconds: 750),

                      /// Set animation with opacity
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
              this.resetLoginButton();
              break;
            default:
              ShowSnackBar(
                  context: scaffoldKey.currentContext,
                  msg: apiResponse.msg,
                  bgColor: Colors.grey.withOpacity(0.5),
                  textColor: Colors.black,
                  height: 25);
              break;
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      Navigator.pop(scaffoldKey.currentContext);

      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }

  void processEditProfile({GlobalKey<ScaffoldState> scaffoldKey}) async {
    Map<String, dynamic> userRegistration = model.editedUserToMap();
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );
    try {
      AuthRepo()
          .processEditProfile(userRegistration: userRegistration)
          .then((apiResponse) async {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          if (apiResponse.code == 1) {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          } else {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }

  void processForgotPassword(
      {GlobalKey<ScaffoldState> scaffoldKey, String email}) async {
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );
    try {
      AuthRepo().processForgotPassword(email: email).then((apiResponse) async {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          if (apiResponse.code == 1) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Container(
                height: 45,
                child: Center(
                  child: Text("${apiResponse.msg}"),
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: appBlue,
              elevation: 5,
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Container(
                height: 45,
                child: Center(
                  child: Text("${apiResponse.msg}"),
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: appBlue,
              elevation: 5,
              behavior: SnackBarBehavior.floating,
            ));
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      Navigator.pop(scaffoldKey.currentContext);

      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }

  void processChangePassword(
      {GlobalKey<ScaffoldState> scaffoldKey,
      String oldPassword,
      String newPassword,
      int customerId}) async {
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );
    try {
      AuthRepo()
          .processChangePassword(
              newPassword: newPassword,
              oldPassword: oldPassword,
              customerId: customerId.toString())
          .then((apiResponse) async {
        Navigator.pop(scaffoldKey.currentContext);
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          if (apiResponse.code == 1) {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          } else {
            ShowSnackBar(
                context: scaffoldKey.currentContext,
                msg: apiResponse.msg,
                bgColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.black,
                height: 25);
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.5),
          textColor: Colors.black,
          height: 25);
    }
  }
}

class Model {
  int id;
  String name;
  String firstName;
  String lastName;
  String userName;
  String password;
  String cPassword;
  String address;
  String phone;
  String email;
  int gender;
  int countryId;
  int timeZone;
  File avatar;
  String avatarStr;
  String dob;
  String fcmToken;
  String zoneId;
  List<dynamic> other;

  Model({
    this.id,
    this.password,
    this.cPassword,
    this.address = "sudan ",
    this.phone = "+24900000000",
    this.name = "gestu",
    this.firstName = "",
    this.lastName = "",
    this.userName = "",
    this.dob = "",
    this.gender = 1,
    this.countryId = 199,
    this.timeZone = 1,
    this.email = "geust@email.com",
    this.avatar,
    this.avatarStr,
    this.fcmToken = "",
    this.zoneId,
    this.other,
  });

  Map<String, dynamic> toMap() => {
        "customers_firstname": name,
        "customers_lastname": name,
        "email": email,
        "password": password,
        "country_code": countryId,
        "customers_telephone": phone,
        "gender_id": gender,
        "token": fcmToken,
      };
  Map<String, dynamic> editedUserToMap() => {
        "customers_id": id,
        "customers_firstname": firstName,
        "customers_lastname": lastName,
        "customers_email": email,
        "customers_username": password,
        "customers_telephone": phone,
        "customers_dob": dob,
      };
}
