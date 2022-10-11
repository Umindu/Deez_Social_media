import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfileHelper.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/Profile/ProfileHelpers.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AltProfile extends StatelessWidget {
  final String userUid;
  AltProfile({required this.userUid});

  Constantcolors constantcolors = Constantcolors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: Homepage(), type: PageTransitionType.bottomToTop));
          },
        ),
        actions: [
          IconButton(icon: Icon(EvaIcons.moreVertical), onPressed: () {})
        ],
        title: RichText(
            text: TextSpan(
                text: 'Other',
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
          height: MediaQuery.of(context).size.height * 1.25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Provider.of<AltProfileHelper>(context, listen: false)
                          .headerProfile(context, snapshot, userUid),
                      Provider.of<AltProfileHelper>(context, listen: false)
                          .divider(),
                      Provider.of<AltProfileHelper>(context, listen: false)
                          .middleProfile(context, snapshot, userUid),
                      Provider.of<AltProfileHelper>(context, listen: false)
                          .footerProfile(context, snapshot, userUid),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
