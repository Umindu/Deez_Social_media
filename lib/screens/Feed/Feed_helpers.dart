import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/constants/Constantcolors.dart';

class FeedHelpers with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantcolors.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0))),
        ),
      ),
    );
  }
}
