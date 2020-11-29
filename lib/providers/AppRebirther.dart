library flutter_phoenix;

import 'package:flutter/widgets.dart';

/// Wrap your root App widget in this widget and call [AppRebirther.rebirth] to restart your app.
class AppRebirther extends StatefulWidget {
  final Widget child;

  AppRebirther({this.child});

  @override
  _AppRebirtherState createState() => _AppRebirtherState();

  static rebirth(BuildContext context) {
    context.findAncestorStateOfType<_AppRebirtherState>().restartApp();
  }
}

class _AppRebirtherState extends State<AppRebirther> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
