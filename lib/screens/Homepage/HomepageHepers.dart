import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Chatroom/Chatroom.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:provider/provider.dart';

class HomepageHelpers with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    return CustomNavigationBar(
        currentIndex: index,
        bubbleCurve: Curves.bounceIn,
        scaleCurve: Curves.decelerate,
        selectedColor: constantcolors.blueColor,
        unSelectedColor: constantcolors.whiteColor,
        strokeColor: constantcolors.blueColor,
        scaleFactor: 0.5,
        iconSize: 30.0,
        onTap: (val) {
          index = val;
          pageController.jumpToPage(val);
          notifyListeners();
        },
        backgroundColor: Color(0xff040307),
        items: [
          CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
          CustomNavigationBarItem(icon: Icon(EvaIcons.messageCircle)),
          CustomNavigationBarItem(
              icon: CircleAvatar(
            radius: 35.0,
            backgroundColor: constantcolors.blueGreyColor,
            // backgroundImage: NetworkImage(Provider.of<FirebaseOperation>(context, listen: false).)
          )),
        ]);
  }
}
