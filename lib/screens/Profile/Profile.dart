import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Profile/ProfileHelpers.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  Constantcolors constantcolors = Constantcolors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            EvaIcons.settings2Outline,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(EvaIcons.logOutOutline),
              onPressed: () {
                Provider.of<ProfileHelper>(context, listen: false)
                    .logOutDialog(context);
              })
        ],
        title: RichText(
            text: TextSpan(
                text: 'My',
                style: TextStyle(
                  color: constantcolors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.00,
                ),
                children: <TextSpan>[
              TextSpan(
                text: 'Profile',
                style: TextStyle(
                  color: constantcolors.darkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.00,
                ),
              )
            ])),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(finalUid == ''
                      ? Provider.of<Authentication>(context, listen: false)
                          .getuserUid
                      : finalUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Provider.of<ProfileHelper>(context, listen: false)
                          .headerProfile(
                        context,
                        snapshot,
                      ),
                      Provider.of<ProfileHelper>(context, listen: false)
                          .divider(),
                      Provider.of<ProfileHelper>(context, listen: false)
                          .middleProfile(context, snapshot),
                      Provider.of<ProfileHelper>(context, listen: false)
                          .footerProfile(context, snapshot),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
