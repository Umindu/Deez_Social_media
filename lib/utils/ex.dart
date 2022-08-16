import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfile.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/Profile/Profile.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:m_finder/utils/PostOptions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();
  Widget foloowersCounter(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: constantcolors.darkColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    height: 70.00,
                    width: 80.00,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: constantcolors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)),
                          height: 70.00,
                          width:
                              80.00, //................................................
                          child: Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(documentSnapshot['useruid'])
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
                                            color: constantcolors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28.0),
                                      );
                                    }
                                  }),
                              Text(
                                'Followers',
                                style: TextStyle(
                                    color: constantcolors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ],
                          ),
                        ), //...........................................................................................
                        Container(
                          decoration: BoxDecoration(
                              color: constantcolors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)),
                          height: 70.00,
                          width:
                              80.00, //................................................
                          child: Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(documentSnapshot['useruid'])
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
                                            color: constantcolors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28.0),
                                      );
                                    }
                                  }),
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
                    ), //....................................................
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
          ],
        ),
      );
    }).toList());
  }
}
