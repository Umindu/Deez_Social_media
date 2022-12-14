import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfile.dart';
import 'package:m_finder/screens/LandingPage/Login.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHelper with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget headerProfile(
    BuildContext context,
    dynamic snapshot,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Container(
          //   height: 330.00,
          //   width: 180.00,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 1.00),
          //         child: GestureDetector(
          //             onTap: () {},
          //             child: CircleAvatar(
          //               backgroundColor: constantcolors.transparent,
          //               radius: 60.0,
          //               backgroundImage:
          //                   NetworkImage(snapshot.data.data()['userimage']),
          //             )),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 7.0),
          //         child: Text(
          //           snapshot.data.data()['username'],
          //           style: TextStyle(
          //             color: constantcolors.darkColor,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20.0,
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 5.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               EvaIcons.email,
          //               color: constantcolors.greenColor,
          //               size: 16.00,
          //             ),
          //             Text(
          //               snapshot.data.data()['useremail'],
          //               style: TextStyle(
          //                 color: constantcolors.darkColor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 12.0,
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(finalUid == ''
                                      ? Provider.of<Authentication>(context,
                                              listen: false)
                                          .getuserUid
                                      : finalUid)
                                  .collection('followers')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data!.docs.length.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.0),
                                  );
                                }
                              }),
                          Text(
                            'Followers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200.00,
                      width: 180.00,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 1.00),
                            child: GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: constantcolors.transparent,
                                  radius: 60.0,
                                  backgroundImage: NetworkImage(
                                      snapshot.data.data()['userimage']),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Text(
                              snapshot.data.data()['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data.data()['useremail'],
                                  style: TextStyle(
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
                    GestureDetector(
                      onTap: () {
                        checkFollowingSheet(
                          context,
                          snapshot,
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(finalUid == ''
                                        ? Provider.of<Authentication>(context,
                                                listen: false)
                                            .getuserUid
                                        : finalUid)
                                    .collection('following')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Text(
                                      snapshot.data!.docs.length.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0),
                                    );
                                  }
                                }),
                            Text(
                              'Following',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Center(
      child: SizedBox(
        height: 30.00,
        width: 350.0,
        child: Divider(),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.00,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(finalUid == ''
                              ? Provider.of<Authentication>(context,
                                      listen: false)
                                  .getuserUid
                              : finalUid)
                          .collection('followers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot documentSnapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (documentSnapshot['useruid'] !=
                                            (finalUid == ''
                                                ? Provider.of<Authentication>(
                                                        context,
                                                        listen: false)
                                                    .getuserUid
                                                : finalUid)) {
                                          Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  child: AltProfile(
                                                    userUid: documentSnapshot[
                                                        'useruid'],
                                                  ),
                                                  type: PageTransitionType
                                                      .bottomToTop));
                                        }
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  constantcolors.transparent,
                                              radius: 25.0,
                                              backgroundImage: NetworkImage(
                                                documentSnapshot['userimage'],
                                              ),
                                            ),
                                            Text(
                                              documentSnapshot['username'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }).toList());
                        }
                      }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget footerProfile(
    BuildContext context,
    dynamic snapshot,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Posts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.00,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(finalUid == ''
                      ? Provider.of<Authentication>(context, listen: false)
                          .getuserUid
                      : finalUid)
                  .collection('posts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot documentSnapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(8.00),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.53,
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.center,
                              child:
                                  Image.network(documentSnapshot['postimage']),
                            ),
                          ),
                        );
                      }).toList());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  logOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            title: const Text(
              'Log Out ?',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              MaterialButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: constantcolors.redColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear().whenComplete(() {
                      print(' All clear');
                      Provider.of<Authentication>(context, listen: false)
                          .logOutViaEmail()
                          .whenComplete(() {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: LoginPage(),
                                type: PageTransitionType.bottomToTop));
                      });
                    });
                  })
            ],
          );
        });
  }

  checkFollowingSheet(BuildContext context, dynamic snspshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(finalUid == ''
                        ? Provider.of<Authentication>(context, listen: false)
                            .getuserUid
                        : finalUid)
                    .collection('following')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot documentSnapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListTile(
                          onTap: () {
                            if (documentSnapshot['useruid'] !=
                                (finalUid == ''
                                    ? Provider.of<Authentication>(context,
                                            listen: false)
                                        .getuserUid
                                    : finalUid)) {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: AltProfile(
                                        userUid: documentSnapshot['useruid'],
                                      ),
                                      type: PageTransitionType.bottomToTop));
                            }
                          },
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(documentSnapshot['userimage'])),
                          title: Text(
                            documentSnapshot['username'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          subtitle: Text(
                            documentSnapshot['useremail'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        );
                      }
                    }).toList());
                  }
                }),
          );
        });
  }
}
