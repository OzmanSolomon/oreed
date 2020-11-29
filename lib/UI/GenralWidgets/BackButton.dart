import 'package:flutter/material.dart';

class BackButtonBtn extends StatefulWidget {
  final Widget child;
  BackButtonBtn({
    this.child,
  });
  @override
  _BackButtonBtnState createState() => _BackButtonBtnState();
}

class _BackButtonBtnState extends State<BackButtonBtn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Navigator.of(context).pop();
          }
          print("${details.primaryVelocity}");
        },
        child: widget.child,
      ),
    );
  }
}
