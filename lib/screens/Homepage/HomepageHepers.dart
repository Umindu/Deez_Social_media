import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Chatroom/Chatroom.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:provider/provider.dart';

class HomepageHelpers with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    return Container(
        color: constantcolors.whiteColor,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
                backgroundColor: constantcolors.whiteColor,
                color: Colors.grey[800],
                activeColor: constantcolors.darkpurple,
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                tabActiveBorder:
                    Border.all(color: constantcolors.darkpurple, width: 1),
                gap: 8,
                onTabChange: (val) {
                  index = val;
                  pageController.jumpToPage(val);
                  notifyListeners();
                },
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.man,
                    text: 'Profile',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Setting',
                  ),
                ])));

    //  CustomNavigationBar(
    //     currentIndex: index,
    //     bubbleCurve: Curves.bounceIn,
    //     scaleCurve: Curves.decelerate,
    //     selectedColor: constantcolors.blueColor,
    //     unSelectedColor: constantcolors.whiteColor,
    //     strokeColor: constantcolors.blueColor,
    //     scaleFactor: 0.5,
    //     iconSize: 25.0,
    //     onTap: (val) {
    //       index = val;
    //       pageController.jumpToPage(val);
    //       notifyListeners();
    //     },
    //     backgroundColor: Color(0xff040307),
    //     items: [
    //       CustomNavigationBarItem(icon: Icon(EvaIcons.homeOutline)),
    //       CustomNavigationBarItem(icon: Icon(EvaIcons.messageSquareOutline)),
    //       CustomNavigationBarItem(
    //           icon: CircleAvatar(
    //         radius: 35.0,
    //         backgroundColor: constantcolors.blueGreyColor,
    //       )),
    //     ]);
  }
}
