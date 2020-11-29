import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void ShowSnackBar(
    {BuildContext context,
    String msg,
    bool isWarrning,
    Color bgColor,
    Color textColor,
    double height = 25,
    double width,
    int displayDuration = 3}) {
  Toast.show(msg, context,
      duration: displayDuration,
      gravity: Toast.BOTTOM,
      backgroundColor: bgColor,
      textColor: textColor);
}
