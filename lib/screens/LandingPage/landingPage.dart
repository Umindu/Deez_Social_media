import 'package:flutter/material.dart';
import 'package:m_finder/screens/LandingPage/landingHelpers.dart';
import 'package:provider/provider.dart';

import '../../constants/Constantcolors.dart';

class Landingpage extends StatelessWidget {
  Landingpage({Key? key}) : super(key: key);

  final Constantcolors constantcolors = Constantcolors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantcolors.whiteColor,
      body: Stack(
        children: [
          bodycolor(),
          Provider.of<landingHelpers>(context, listen: false)
              .bodyImage(context),
          Provider.of<landingHelpers>(context, listen: false)
              .taglineText(context),
          Provider.of<landingHelpers>(context, listen: false)
              .mainButton(context),
          Provider.of<landingHelpers>(context, listen: false)
              .privacyText(context),
        ],
      ),
    );
  }

  bodycolor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 9.0],
              colors: [constantcolors.blueColor, constantcolors.whiteColor])),
    );
  }
}
