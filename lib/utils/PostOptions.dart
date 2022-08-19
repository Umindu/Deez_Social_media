import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfile.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostFunctions with ChangeNotifier {
  TextEditingController commentcontroller = TextEditingController();
  Constantcolors constantcolors = Constantcolors();

  late String imageTimePosted;
  String get getImageTimePosted => imageTimePosted;

  // showTimeAgo(dynamic timedata) {
  //   Timestamp time = timedata;
  //   DateTime dateTime = time.toDate();
  //   imageTimePosted = timeago.format(dateTime);
  //   print(imageTimePosted);
  //   notifyListeners();
  // }

  showPostOptions(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantcolors.blueColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.00),
                    child: Divider(
                      thickness: 4.00,
                      color: constantcolors.whiteColor,
                    )),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                color: constantcolors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          onPressed: () {}),
                      MaterialButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: constantcolors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Delete This Post ?',
                                      style: TextStyle(
                                          color: constantcolors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    actions: [
                                      MaterialButton(
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color:
                                                    constantcolors.blackColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      MaterialButton(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: constantcolors.redColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          onPressed: () {
                                            Provider.of<FirebaseOperation>(
                                                    context,
                                                    listen: false)
                                                .deleteUserData(postId, 'post')
                                                .whenComplete(() {
                                              Navigator.pop(context);
                                            });
                                          }),
                                    ],
                                  );
                                });
                          })
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Future addLike(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .set({
      'likes': FieldValue.increment(1),
      'username':
          Provider.of<FirebaseOperation>(context, listen: false).initUserName,
      'useruid': Provider.of<Authentication>(context, listen: false).getuserUid,
      'userimage':
          Provider.of<FirebaseOperation>(context, listen: false).initUserImage,
      'useremail':
          Provider.of<FirebaseOperation>(context, listen: false).initUserEmail,
      'time': Timestamp.now()
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'username':
          Provider.of<FirebaseOperation>(context, listen: false).initUserName,
      'useruid': Provider.of<Authentication>(context, listen: false).getuserUid,
      'userimage':
          Provider.of<FirebaseOperation>(context, listen: false).initUserImage,
      'useremail':
          Provider.of<FirebaseOperation>(context, listen: false).initUserEmail,
      'time': Timestamp.now()
    });
  }

  showCommentsSheet(
      BuildContext context, DocumentSnapshot snapshot, String docId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantcolors.blueColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150.00),
                      child: Divider(
                        thickness: 4.00,
                        color: constantcolors.whiteColor,
                      )),
                  Container(
                    width: 100,
                    child: Center(
                        child: Text(
                      'Comments',
                      style: TextStyle(
                          color: constantcolors.blackColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .doc(docId)
                            .collection('comments')
                            .orderBy("time")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot documentSnapshot) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (documentSnapshot['useruid'] !=
                                                  Provider.of<Authentication>(
                                                          context,
                                                          listen: false)
                                                      .getuserUid) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    PageTransition(
                                                        child: AltProfile(
                                                          userUid:
                                                              documentSnapshot[
                                                                  'useruid'],
                                                        ),
                                                        type: PageTransitionType
                                                            .bottomToTop));
                                              }
                                            },
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    constantcolors.transparent,
                                                radius: 15.00,
                                                backgroundImage: NetworkImage(
                                                    documentSnapshot[
                                                        'userimage'])),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    documentSnapshot[
                                                        'username'],
                                                    style: TextStyle(
                                                        color: constantcolors
                                                            .blackColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    FontAwesomeIcons.arrowUp,
                                                    color: constantcolors
                                                        .blackColor,
                                                    size: 12,
                                                  )),
                                              Text('0',
                                                  style: TextStyle(
                                                      color: constantcolors
                                                          .whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    FontAwesomeIcons.reply,
                                                    color: constantcolors
                                                        .blackColor,
                                                    size: 12,
                                                  )),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    FontAwesomeIcons.trashAlt,
                                                    size: 12,
                                                    color: constantcolors
                                                        .blackColor,
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              FontAwesomeIcons
                                                  .arrowRotateForward,
                                              color: constantcolors.blackColor,
                                              size: 12.0,
                                            )),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            documentSnapshot['comment'],
                                            style: TextStyle(
                                                color:
                                                    constantcolors.blackColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                        )
                                      ]),
                                    ),
                                    Divider(
                                      color: constantcolors.blackColor,
                                    )
                                  ],
                                ),
                              );
                            }).toList());
                          }
                        },
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 300.00,
                              height: 20.00,
                              child: TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  hintText: 'Add Comment...',
                                  hintStyle: TextStyle(
                                      color: constantcolors.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                controller: commentcontroller,
                                style: TextStyle(
                                    color: constantcolors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              )),
                          FloatingActionButton(
                              backgroundColor: constantcolors.blueColor,
                              child: Icon(
                                FontAwesomeIcons.arrowRight,
                                color: constantcolors.blackColor,
                              ),
                              onPressed: () {
                                print('Adding comment..');
                                addComment(context, snapshot['caption'],
                                        commentcontroller.text)
                                    .whenComplete(() {
                                  commentcontroller.clear();
                                  notifyListeners();
                                });
                              })
                        ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  showLikes(
    BuildContext context,
    DocumentSnapshot documentSnapshot,
    String postId,
  ) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantcolors.blueColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.00),
                  child: Divider(
                    thickness: 4.00,
                    color: constantcolors.whiteColor,
                  )),
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  'Likes',
                  style: TextStyle(
                      color: constantcolors.blackColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .collection('likes')
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot) {
                        return ListTile(
                          leading: GestureDetector(
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    DocumentSnapshot['userimage'])),
                          ),
                          title: Text(
                            DocumentSnapshot['username'],
                            style: TextStyle(
                                color: constantcolors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          subtitle: Text(
                            DocumentSnapshot['useremail'],
                            style: TextStyle(
                                color: constantcolors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          trailing: Provider.of<Authentication>(context,
                                          listen: false)
                                      .getuserUid ==
                                  DocumentSnapshot['useruid']
                              ? Container(
                                  height: 0.0,
                                  width: 0.0,
                                )
                              : MaterialButton(
                                  onPressed: (() {}),
                                  child: Text('Follow',
                                      style: TextStyle(
                                          color: constantcolors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                ),
                        );
                      }).toList());
                    }
                  }),
                ),
              )
            ]),
          );
        });
  }
}
