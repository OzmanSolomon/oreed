import 'package:flutter/material.dart';

/// textfromfield custom class
class TextFromField extends StatelessWidget {
  final IconData icon;
  final TextInputType inputType;
  final String hintText;
  final TextInputType keyBoardType;
  final Function validator;
  final Function onSaved;
  final bool isEnabled;
  final Function onChange;
  final bool isPassword;
  final bool isEmail;

  TextFromField(
      {this.hintText,
      this.icon,
      this.inputType,
      this.isPassword,
      this.isEmail,
      this.keyBoardType,
      this.onSaved,
      this.isEnabled = true,
      this.onChange,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            obscureText: isPassword ? true : false,
            validator: validator,
            enabled: isEnabled,
            onSaved: onSaved,
            onChanged: onChange,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: hintText,
              icon: Icon(
                icon,
                color: Colors.black38,
              ),
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  letterSpacing: 0.3,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600),
            ),
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
          ),
        ),
      ),
    );
  }
}

/// textfromfield custom class
class TextFromFieldEditMode extends StatelessWidget {
  final IconData icon;
  final TextInputType inputType;
  final String hintText;
  final TextInputType keyBoardType;
  final TextEditingController myContrller;
  final Function validator;
  final Function onSaved;
  final Function onChange;
  final bool isPassword;
  final bool isEmail;

  TextFromFieldEditMode(
      {this.hintText,
      this.icon,
      this.inputType,
      this.isPassword,
      this.isEmail,
      this.keyBoardType,
      this.myContrller,
      this.onSaved,
      this.onChange,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            obscureText: isPassword ? true : false,
            validator: validator,
            onSaved: onSaved,
            onChanged: onChange,
            controller: myContrller,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: hintText,
              icon: Icon(
                icon,
                color: Colors.black38,
              ),
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  letterSpacing: 0.3,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600),
            ),
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
          ),
        ),
      ),
    );
  }
}
