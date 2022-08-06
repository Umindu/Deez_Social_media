import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/LandingPage/landingPage.dart';
import 'package:page_transition/page_transition.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Constantcolors constantcolors = Constantcolors();

  @override
  void initState() {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight, child: Landingpage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantcolors.darkColor,
      body: Center(
          child: RichText(
        text: TextSpan(
            text: 'Medicine',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: constantcolors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 30.00),
            children: <TextSpan>[
              TextSpan(
                text: 'Finder',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: constantcolors.blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.00),
              )
            ]),
      )),
    );
  }
}
