import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      if (_currentPage < 6) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: PageView(
                  controller: controller,
                  children: List.generate(
                    6,
                    (_) => Container(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Center(child: Text("Progressing")),
              ),
              Center(
                child: Container(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 6,
                    effect: WormEffect(
                        dotHeight: 20.0, dotWidth: 20.0, spacing: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
