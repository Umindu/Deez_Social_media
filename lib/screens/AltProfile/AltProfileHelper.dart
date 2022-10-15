import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfile.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:core';

import 'package:provider/provider.dart';

class AltProfileHelper with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();
  Widget headerProfile(
    BuildContext context,
    dynamic snapshot,
    String userUid,
  ) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userUid)
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
                                            snapshot.data!.docs.length
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28.0),
                                          );
                                        }
                                      }),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 230.00,
                              width: 180.00,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.00),
                                    child: GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          backgroundColor:
                                              constantcolors.transparent,
                                          radius: 60.0,
                                          backgroundImage: NetworkImage(snapshot
                                              .data
                                              .data()['userimage']),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          EvaIcons.email,
                                          size: 16.00,
                                        ),
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
                            Container(
                              child: Column(
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userUid)
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
                                            snapshot.data!.docs.length
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28.0),
                                          );
                                        }
                                      }),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(
                    color: constantcolors.blackColor,
                    onPressed: () {
                      Provider.of<FirebaseOperation>(context, listen: false)
                          .followUser(
                              userUid,
                              (finalUid == ''
                                  ? Provider.of<Authentication>(context,
                                          listen: false)
                                      .getuserUid
                                  : finalUid),
                              {
                                'username': Provider.of<FirebaseOperation>(
                                        context,
                                        listen: false)
                                    .initUserName,
                                'userimage': Provider.of<FirebaseOperation>(
                                        context,
                                        listen: false)
                                    .initUserImage,
                                'useruid': (finalUid == ''
                                    ? Provider.of<Authentication>(context,
                                            listen: false)
                                        .getuserUid
                                    : finalUid),
                                'useremail': Provider.of<FirebaseOperation>(
                                        context,
                                        listen: false)
                                    .initUserEmail,
                                'time': Timestamp.now()
                              },
                              (finalUid == ''
                                  ? Provider.of<Authentication>(context,
                                          listen: false)
                                      .getuserUid
                                  : finalUid),
                              userUid,
                              {
                                'username': snapshot.data.data()['username'],
                                'userimage': snapshot.data.data()['userimage'],
                                'useremail': snapshot.data.data()['useremail'],
                                'useruid': (userUid),
                                'time': Timestamp.now()
                              })
                          .whenComplete(() {
                        print('$userUid');
                      });
                    },
                    child: Text(
                      'Follow',
                      style: TextStyle(
                          color: constantcolors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    )),
                MaterialButton(
                    color: constantcolors.blackColor,
                    onPressed: () {},
                    child: Text(
                      'Message',
                      style: TextStyle(
                          color: constantcolors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return const Center(
      child: SizedBox(
        child: Divider(
          color: Colors.grey,
          indent: 20,
          endIndent: 20,
        ),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot, String userUid) {
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
              Text(
                'Recently Added',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.00,
                ),
              )
            ],
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
                    .doc(userUid)
                    .collection('following')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: AltProfile(
                                            userUid:
                                                documentSnapshot['useruid'],
                                          ),
                                          type:
                                              PageTransitionType.bottomToTop));

                                  print(documentSnapshot['useruid']);
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot, String userUid) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.44,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userUid)
              .collection('posts')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          child: Image.network(documentSnapshot['postimage']),
                        ),
                      ),
                    );
                  }).toList());
            }
          },
        ),
      ),
    );
  }
}
