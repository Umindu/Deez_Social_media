import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:m_finder/Setting/Setting.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Chatroom/Chatroom.dart';
import 'package:m_finder/screens/Feed/Feed.dart';
import 'package:m_finder/screens/Homepage/HomepageHepers.dart';
import 'package:m_finder/screens/Profile/Profile.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Constantcolors constantcolors = Constantcolors();

  final PageController homePageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperation>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: homePageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
          children: [
            Feed(),
            Chatroom(),
            Profile(),
            SettingPage(),
          ],
        ),
        bottomNavigationBar:
            Provider.of<HomepageHelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homePageController));
  }
}
