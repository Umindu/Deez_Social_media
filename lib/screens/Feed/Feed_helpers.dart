import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfile.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/Profile/Profile.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
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
        decoration: BoxDecoration(),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
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
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.00),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 10.0),
                        child: GestureDetector(
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
                                            userUid:
                                                documentSnapshot['useruid'],
                                          ),
                                          type: PageTransitionType.bottomToTop))
                                  .whenComplete(() {
                                print('done....');
                              });
                            }
                          },
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(140),
                            child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(140)),
                              height: 45,
                              width: 45,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 45,
                                    width: 45,
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0, top: 0, bottom: 0),
                                    padding: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2),
                                        borderRadius:
                                            BorderRadius.circular(140)),
                                    child: CircleAvatar(
                                        backgroundColor:
                                            constantcolors.transparent,
                                        radius: 20.00,
                                        backgroundImage: NetworkImage(
                                            documentSnapshot['userimage'])),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Container(
                                child: Text(documentSnapshot['username'],
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${Provider.of<PostFunctions>(context, listen: false).imageTimePosted.toString()}',
                                    style: GoogleFonts.lato(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: (finalUid == ''
                                    ? Provider.of<Authentication>(context,
                                            listen: false)
                                        .getuserUid
                                    : finalUid) ==
                                documentSnapshot['useruid']
                            ? IconButton(
                                onPressed: () {
                                  Provider.of<PostFunctions>(context,
                                          listen: false)
                                      .showPostOptions(
                                          context, documentSnapshot['caption']);
                                },
                                icon: Icon(
                                  EvaIcons.moreVertical,
                                ))
                            : Container(
                                width: 0.0,
                                height: 0.0,
                              ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                      child: Container(
                          child: Text(
                        documentSnapshot['caption'],
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(18.0),
                            elevation: 2,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Image.network(
                                  documentSnapshot['postimage'],
                                  scale: 0.1,
                                )),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 90.00,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(
                                  context,
                                  listen: false,
                                ).showLikes(
                                  context,
                                  documentSnapshot,
                                  documentSnapshot['caption'],
                                );
                              },
                              child: Icon(
                                Icons.favorite,
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
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 125.00,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showCommentsSheet(
                                        context,
                                        documentSnapshot,
                                        documentSnapshot['caption']);
                              },
                              child: Text(
                                ' Comments',
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100.00,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('Adding like..');
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .addLike(
                                        context,
                                        documentSnapshot['caption'],
                                        (finalUid == ''
                                            ? Provider.of<Authentication>(
                                                    context,
                                                    listen: false)
                                                .getuserUid
                                            : finalUid));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    size: 22.00,
                                  ),
                                  Text(
                                    ' Like',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 150.00,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showCommentsSheet(
                                        context,
                                        documentSnapshot,
                                        documentSnapshot['caption']);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mode_comment_outlined,
                                    size: 22.00,
                                  ),
                                  Text(
                                    ' Comment',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList());
  }
}
