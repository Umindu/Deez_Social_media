import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/LandingPage/Signup.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/screens/LandingPage/userDetalistShow.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Constantcolors constantcolors = Constantcolors();

class getAvatarPage extends StatefulWidget {
  const getAvatarPage({Key? key}) : super(key: key);

  @override
  State<getAvatarPage> createState() => _getAvatarPageState();
}

class _getAvatarPageState extends State<getAvatarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 325,
                height: 470,
                decoration: BoxDecoration(
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
                              Provider.of<LandingUtils>(context, listen: false)
                                  .pickUserAvatar(context, ImageSource.gallery);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 110,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Reselect',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<FirebaseOperation>(context,
                                      listen: false)
                                  .uploadUserAvatar(context)
                                  .whenComplete(() {
                                Done(context);
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

  Done(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 325,
                  height: 470,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
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
                        height: 15,
                      ),
                      Text(
                        getusername,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        getuseremail,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                    'userid': Provider.of<Authentication>(
                                            context,
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
                                          type:
                                              PageTransitionType.bottomToTop));
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 150,
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
                                    'Get Started',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
