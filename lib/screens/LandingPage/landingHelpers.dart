import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/LandingPage/landingServices.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../constants/Constantcolors.dart';

class landingHelpers with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget bodyImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/login.png'))),
      ),
    );
  }

  //......................................................................................................................................

  Widget taglineText(BuildContext context) {
    return Positioned(
      top: 250.0,
      left: 10.0,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300.0,
        ),
        child: RichText(
          text: TextSpan(
              text: 'Login/Singin',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantcolors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.00),
              children: <TextSpan>[
                TextSpan(
                  text: ' ?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: constantcolors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 34.00),
                )
              ]),
        ),
      ),
    );
  }

  //..................................................................................................................................

  Widget mainButton(BuildContext context) {
    return Positioned(
      top: 520.00,
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                  child: Text(
                    'Log in',
                    style: TextStyle(
                        color: constantcolors.blackColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Provider.of<LandingService>(context, listen: false)
                        .logInSheet(context);
                  }),
              MaterialButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: constantcolors.blackColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Provider.of<LandingService>(context, listen: false)
                        .signInsheet(context);
                  })
            ],
          )),
    );
  }
  //...........................................................................................................................

  Widget privacyText(BuildContext context) {
    return Positioned(
        top: 620.00,
        left: 20.00,
        right: 20.00,
        child: Container(
          child: Column(
            children: [
              Text(
                "By continuing you adree Medicine finder's Terms of",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.00),
              ),
              Text(
                "Services & Privacy Policy",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.00),
              )
            ],
          ),
        ));
  }
}
