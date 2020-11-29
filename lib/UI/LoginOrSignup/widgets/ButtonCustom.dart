import 'package:flutter/material.dart';

/// Button Custom widget
class ButtonCustom extends StatelessWidget {
  final String txt;
  ButtonCustom({this.txt});

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return Container(
            width: 300.0,
            height: 52.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xffF7BE08),
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    letterSpacing: 0.5),
              ),
            ),
          );
        }),
      ),
    );
  }
}
