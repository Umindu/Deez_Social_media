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
import 'package:m_finder/utils/PostOptions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: constantcolors.whiteColor,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('post')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 500.00,
                  width: 400.00,
                  child: Lottie.asset(
                      ''), //................................................
                ),
              );
            } else {
              return loadPosts(context, snapshot);
            }
          }),
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
      Provider.of<PostFunctions>(context, listen: false)
          .showTimeAgo(documentSnapshot['time']);

      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        if (documentSnapshot['useruid'] !=
                            Provider.of<Authentication>(context, listen: false)
                                .getuserUid) {
                          Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: AltProfile(
                                        userUid: documentSnapshot['useruid'],
                                      ),
                                      type: PageTransitionType.bottomToTop))
                              .whenComplete(() {
                            print('done....');
                          });
                        }
                      },
                      child: CircleAvatar(
                          backgroundColor: constantcolors.transparent,
                          radius: 20.00,
                          backgroundImage:
                              NetworkImage(documentSnapshot['userimage'])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            documentSnapshot['caption'],
                            style: TextStyle(
                              color: constantcolors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.00,
                            ),
                          )),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    text: documentSnapshot['username'],
                                    style: TextStyle(
                                        color: constantcolors.blueColor,
                                        fontSize: 14.00,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          ' ,${Provider.of<PostFunctions>(context, listen: false).imageTimePosted.toString()}',
                                      style: TextStyle(
                                          color: constantcolors.blackColor))
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: Provider.of<Authentication>(context, listen: false)
                                .getuserUid ==
                            documentSnapshot['useruid']
                        ? IconButton(
                            onPressed: () {
                              Provider.of<PostFunctions>(context, listen: false)
                                  .showPostOptions(
                                      context, documentSnapshot['caption']);
                            },
                            icon: Icon(
                              EvaIcons.moreVertical,
                              color: constantcolors.blackColor,
                            ))
                        : Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                  child: Image.network(
                documentSnapshot['postimage'],
                scale: 2,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(),
                  Container(
                    width: 90.00,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            Provider.of<PostFunctions>(context, listen: false)
                                .showLikes(context, documentSnapshot,
                                    documentSnapshot['caption']);
                          },
                          onTap: () {
                            print('Adding like..');
                            Provider.of<PostFunctions>(context, listen: false)
                                .addLike(
                                    context,
                                    documentSnapshot['caption'],
                                    Provider.of<Authentication>(context,
                                            listen: false)
                                        .getuserUid);
                          },
                          child: Icon(
                            FontAwesomeIcons.heart,
                            color: constantcolors.redColor,
                            size: 22.00,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(documentSnapshot['caption'])
                                .collection('likes')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    snapshot.data!.docs.length.toString(),
                                    style: TextStyle(
                                      color: constantcolors.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 90.00,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<PostFunctions>(context, listen: false)
                                .showCommentsSheet(context, documentSnapshot,
                                    documentSnapshot['caption']);
                          },
                          child: Icon(
                            FontAwesomeIcons.comment,
                            color: constantcolors.blueColor,
                            size: 22.00,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(documentSnapshot['caption'])
                                .collection('comments')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    snapshot.data!.docs.length.toString(),
                                    style: TextStyle(
                                      color: constantcolors.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 90.00,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.share,
                            color: constantcolors.redColor,
                            size: 22.00,
                          ),
                        ),
                        Text(
                          ' 0',
                          style: TextStyle(
                              color: constantcolors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.00),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList());
  }
}
