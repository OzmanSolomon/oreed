import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/UI/LoginOrSignup/widgets/TextFromField.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';
import 'package:oreeed/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  AnimationController sanimationController;
  // controllers for form text controllers
  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _dobController = new TextEditingController();

  final GlobalKey<ScaffoldState> _addInfoScaffoldKey =
      GlobalKey<ScaffoldState>();
  DatabaseHelper helper = DatabaseHelper();
  User _user;

  void getUserData() {
    helper.getUserList().then((user) {
      if (user != null) {
        setState(() {
          _user = user[0];
          _firstNameController.text = user[0].firstName;
          _lastNameController.text =
              user[0].lastName == null || user[0].lastName == ""
                  ? "..... "
                  : user[0].lastName;
          _userNameController.text =
              user[0].userName == null || user[0].userName == ""
                  ? "..... "
                  : user[0].userName;
          _phoneController.text = user[0].phone;
          _emailController.text = user[0].email;
          _dobController.text = user[0].dob;

          Provider.of<AuthProvider>(context, listen: false)
              .setUserPhone(user[0].phone);
          Provider.of<AuthProvider>(context, listen: false)
              .setUserEmail(user[0].email);
          Provider.of<AuthProvider>(context, listen: false)
              .setUserFirstName(user[0].firstName);
          Provider.of<AuthProvider>(context, listen: false)
              .setUserLastName(user[0].lastName);
          Provider.of<AuthProvider>(context, listen: false)
              .setUserName(user[0].userName);
        });
      }
    });
  }

  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return false;
    } else {
      return true;
    }
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    _dobController.text = "${picked.toLocal()}".split(' ')[0];
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select Your Birth date',
      cancelText: 'Not Sure',
      confirmText: 'yes',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Birth date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var ageIs = _ageCalculator(picked);
        _dobController.text =
            "${picked.toLocal()}".split(' ')[0] + "  / $ageIs Years";
        Provider.of<AuthProvider>(context, listen: false)
            .setUserDateOfBirth(selectedDate.toIso8601String());
      });
  }

  int _ageCalculator(DateTime birthDate) {
    Duration dur = DateTime.now().difference(birthDate);
    int differenceInYears = (dur.inDays / 365).floor();
    return differenceInYears;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      getUserData();
    }
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _addInfoScaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white.withOpacity(0.1), //Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Colors.white),
                  child: Column(
                    /// Setting Category List
                    ///
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            /// Set Text
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/avatars/editProfile.png'),
                                      fit: BoxFit.cover),
                                ),
                                height:
                                    MediaQuery.of(context).size.width / 3 + 10,
                                width: MediaQuery.of(context).size.width *
                                    3 /
                                    4, //double.infinity,
                              ),
                            ),

                            /// TextFromField first
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            TextFromFieldEditMode(
                              myContrller: _firstNameController,
                              icon: Icons.person,
                              isEmail: false,
                              isPassword: false,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .tr('firstName');
                                }
                                return null;
                              },
                              onChange: (value) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setUserFirstName(value);
                              },
                              hintText:
                                  AppLocalizations.of(context).tr('firstName'),
                              inputType: TextInputType.text,
                            ),

                            /// TextFromField rest name
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            TextFromFieldEditMode(
                              myContrller: _lastNameController,
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
                              hintText:
                                  AppLocalizations.of(context).tr('restName'),
                              inputType: TextInputType.text,
                            ),

                            /// TextFromField username or nickname
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            TextFromFieldEditMode(
                              myContrller: _userNameController,
                              icon: Icons.person,
                              isEmail: false,
                              isPassword: false,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .tr('userName');
                                }
                                return null;
                              },
                              onChange: (value) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setUserName(value);
                              },
                              hintText:
                                  AppLocalizations.of(context).tr('userName'),
                              inputType: TextInputType.text,
                            ),

                            /// TextFromField Email
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            TextFromFieldEditMode(
                              myContrller: _emailController,
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
                                var validEmail = EmailValidator.validate(value);
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
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            TextFromFieldEditMode(
                              myContrller: _phoneController,
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

                            /// TextFromField BirthDate
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Container(
                                height: 60.0,
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
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
                                child: Theme(
                                  data: ThemeData(
                                    hintColor: Colors.transparent,
                                  ),
                                  child: InkWell(
                                    onTap: () => _selectDate(context),
                                    child: TextFormField(
                                      obscureText: false,
                                      // validator: validator,
                                      enabled: false,
                                      onSaved: null,
                                      onChanged: null,
                                      controller: _dobController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Birth Date",
                                        icon: Icon(
                                          Icons.hourglass_empty,
                                          color: Colors.black38,
                                        ),
                                        labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0.3,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.yellow,
                        onTap: () async {
                          var authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            Provider.of<AuthProvider>(context, listen: false)
                                .setUserId(_user.id.toString());
                            authProvider.processEditProfile(
                                scaffoldKey: _addInfoScaffoldKey);
                          } else {
                            ShowSnackBar(
                                context: context,
                                msg:
                                    "Please fix the errors in red before submitting.",
                                bgColor: Colors.grey,
                                textColor: Colors.black,
                                height: 25);
                          }
                        },
                        child: _BuildMyButtons(
                          context,
                        ),
                        // child: buttonBlackBottom(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _BuildMyButtons(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                var authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  Provider.of<AuthProvider>(context, listen: false)
                      .setUserId(_user.id.toString());
                  authProvider.processEditProfile(
                      scaffoldKey: _addInfoScaffoldKey);
                } else {
                  SnackBar(
                    content:
                        Text('Please fix the errors in red before submitting.'),
                  );
                }
              },
              child: Container(
                height: 55.0,
                width: 298.0,
                child: Text(
                  AppLocalizations.of(context).tr('editProfile'),
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.2,
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800),
                ),
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black38, blurRadius: 15.0)
                  ],
                  // borderRadius: BorderRadius.circular(30.0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14)),
                  color: appBlue,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 55.0,
                width: 298.0,
                child: Text(
                  AppLocalizations.of(context).tr('cancel'),
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.2,
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800),
                ),
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black38, blurRadius: 15.0)
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14),
                        bottomRight: Radius.circular(14)),
                    color: appBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
