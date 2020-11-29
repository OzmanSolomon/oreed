//import 'package:flutter/material.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
//class RepeatSameAnimation extends StatefulWidget {
//  @override
//  _RepeatSameAnimationState createState() => _RepeatSameAnimationState();
//}
//
//class _RepeatSameAnimationState extends State<RepeatSameAnimation>
//    with SingleTickerProviderStateMixin {
//  AnimationController animationController;
//  Animation<double> animation;
//
//  @override
//  void initState() {
//    super.initState();
//    animationController = AnimationController(
//      vsync: this,
//      duration: Duration(seconds: 5),
//    )..addListener(() => setState(() {}));
//    animation = Tween<double>(
//      begin: 50.0,
//      end: 120.0,
//    ).animate(animationController);
//
//    animationController.forward();
//
//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        animationController.repeat();
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("Repeat Same Animation Example")),
//      body: Center(
//        child: Container(
//          color: Colors.red,
//          height: animation.value,
//          width: animation.value,
//          child: SmoothPageIndicator(
//            controller: animationController,
//            count: 6,
//            effect: ExpandingDotsEffect(
//              expansionFactor: 4,
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
