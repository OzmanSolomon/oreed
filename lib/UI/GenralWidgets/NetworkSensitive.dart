import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:oreed/providers/NetworkProvider.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatefulWidget {
  final Widget child;
  final double opacity;
  NetworkSensitive({
    this.child,
    this.opacity = 0.5,
  });
  @override
  _NetworkSensitiveState createState() => _NetworkSensitiveState();
}

class _NetworkSensitiveState extends State<NetworkSensitive> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<NetworkProvider>(builder: (context, app, child) {
      app.checkCon();
      switch (app.previousResult) {
        case ConnectivityResult.mobile:
          return widget.child;
          break;
        case ConnectivityResult.wifi:
          return widget.child;

          break;
        case ConnectivityResult.none:
          return Scaffold(
            body: Stack(
              children: <Widget>[
                widget.child,
                Container(
                  height: height,
                  width: width,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        app.msg,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        color: Colors.green,
                        child: Text('Ok'),
                        onPressed: () {
                          setState(() {
                            app.checkCon();
                          });
                        },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          );
          break;
        default:
          return Scaffold(
            body: Stack(
              children: <Widget>[
                widget.child,
                Container(
                  height: height,
                  width: width,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Checking network',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                      ),
                      RaisedButton(
                        color: Colors.green,
                        child: Text('Ok'),
                        onPressed: () {
                          setState(() {
                            app.checkCon();
                          });
                        },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          );
          break;
      }
    });
  }
}
