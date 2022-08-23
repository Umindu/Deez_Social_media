import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/LandingPage/Signup.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Constantcolors constantcolors = Constantcolors();

class userDetalistShow extends StatefulWidget {
  const userDetalistShow({Key? key}) : super(key: key);

  @override
  State<userDetalistShow> createState() => _userDetalistShowState();
}

class _userDetalistShowState extends State<userDetalistShow> {
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
              Container(
                width: 325,
                height: 470,
                decoration: BoxDecoration(
                  color: constantcolors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: constantcolors.darkpurple,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Please Select to Your Profile Pic",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 80.0,
                      backgroundColor: constantcolors.transparent,
                      backgroundImage: FileImage(
                          Provider.of<LandingUtils>(context, listen: false)
                              .userAvatar),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<FirebaseOperation>(context,
                                      listen: false)
                                  .uploadUserAvatar(context)
                                  .whenComplete(() {
                                print(getusername);
                                print('Creating collection');
                                Provider.of<FirebaseOperation>(context,
                                        listen: false)
                                    .createUserCollection(context, {
                                  'userid': Provider.of<Authentication>(context,
                                          listen: false)
                                      .getuserUid,
                                  'useremail': getuseremail,
                                  'username': getusername,
                                  'userimage': Provider.of<LandingUtils>(
                                          context,
                                          listen: false)
                                      .getUserAvatarUrl,
                                });
                              }).whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: Homepage(),
                                        type: PageTransitionType.bottomToTop));
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 110,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        constantcolors.darkpurple,
                                        constantcolors.purple
                                      ])),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: constantcolors.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
