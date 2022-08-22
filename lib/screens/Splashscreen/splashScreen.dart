import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/LandingPage/Login.dart';
import 'package:m_finder/screens/LandingPage/Signup.dart';
import 'package:m_finder/screens/LandingPage/landingPage.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String finalUid = '';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Constantcolors constantcolors = Constantcolors();

  Future getval() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userUid = sharedPreferences.getString('uid')!;
    setState(() {
      finalUid = userUid;
    });
    print('############# $finalUid');
  }

  @override
  void initState() {
    getval().whenComplete(() {
      if (finalUid != '') {
        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop, child: Homepage())));
      } else {
        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: Landingpage())));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                constantcolors.darkpurple,
                constantcolors.purple,
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: 'Medicine',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantcolors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.00),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Finder',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: constantcolors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 34.00),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
