import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/LandingPage/landingPage.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfileHelper with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget headerProfile(BuildContext context, dynamic snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 330.00,
            width: 180.00,
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: constantcolors.transparent,
                      radius: 60.0,
                      backgroundImage:
                          NetworkImage(snapshot.data.data()['userimage']),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    snapshot.data.data()['username'],
                    style: TextStyle(
                      color: constantcolors.darkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.email,
                        color: constantcolors.greenColor,
                        size: 16.00,
                      ),
                      Text(
                        snapshot.data.data()['useremail'],
                        style: TextStyle(
                          color: constantcolors.darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 200.00,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: constantcolors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)),
                          height: 70.00,
                          width: 80.00,
                          child: Column(
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                    color: constantcolors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0),
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(
                                    color: constantcolors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: constantcolors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)),
                          height: 70.00,
                          width: 80.00,
                          child: Column(
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                    color: constantcolors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0),
                              ),
                              Text(
                                'Following',
                                style: TextStyle(
                                    color: constantcolors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: constantcolors.darkColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      height: 70.00,
                      width: 80.00,
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                                color: constantcolors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(
                                color: constantcolors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Center(
      child: SizedBox(
        height: 50.00,
        width: 350.0,
        child: Divider(color: constantcolors.darkColor),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150.00,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.userAstronaut,
                color: constantcolors.yellowColor,
                size: 16,
              ),
              Text(
                'Recently Added',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.00,
                    color: constantcolors.darkColor),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantcolors.blueColor,
                borderRadius: BorderRadius.circular(15.0)),
          ),
        )
      ],
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.53,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: constantcolors.blueColor,
            borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  logOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: constantcolors.darkColor,
            title: Text(
              'Log Out ?',
              style: TextStyle(
                color: constantcolors.whiteColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              MaterialButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                        color: constantcolors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: constantcolors.whiteColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  color: constantcolors.redColor,
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        color: constantcolors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: constantcolors.whiteColor),
                  ),
                  onPressed: () {
                    Provider.of<Authentication>(context, listen: false)
                        .logOutViaEmail()
                        .whenComplete(() {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: Landingpage(),
                              type: PageTransitionType.bottomToTop));
                    });
                  })
            ],
          );
        });
  }
}
