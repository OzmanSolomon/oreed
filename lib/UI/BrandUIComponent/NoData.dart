import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      color: Colors.white,
      // height: 200,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  AppLocalizations.of(context).tr('cartNoItem'),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.5,
                      color: Colors.black26.withOpacity(0.2),
                      fontFamily: "Montserrat"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoaderFetchingData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextLiquidFill(
        text: 'Fetching . . .',
        waveColor: Color(0xff033766),
        boxBackgroundColor: Colors.white,
        loadDuration: Duration(seconds: 2),
        waveDuration: Duration(seconds: 2),
        textStyle: TextStyle(
//                    color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        boxHeight: 100.0,
      ),
    );
  }
}

class TryAgainLater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        child: Center(
          child: Text(
            " pleas try again later",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[500],
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
