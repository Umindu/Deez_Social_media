import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: constantcolors.blueColor,
        body: PageView(
          controller: homePageController,
          children: [
            Feed(),
            Chatroom(),
            Profile(),
          ],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<HomepageHelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homePageController));
  }
}
