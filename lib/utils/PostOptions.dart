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

  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeago.format(dateTime);
    print(imageTimePosted);
    notifyListeners();
  }

  showPostOptions(BuildContext context, String postId) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: constantcolors.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy Link'),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
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
                                      color: constantcolors.blackColor,
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
                                  Provider.of<FirebaseOperation>(context,
                                          listen: false)
                                      .deleteUserData(postId, 'post')
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                  });
                                }),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        );
      },
    );
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
                  color: constantcolors.whiteColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
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
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
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
                                                radius: 20.00,
                                                backgroundImage: NetworkImage(
                                                    documentSnapshot[
                                                        'userimage'])),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color:
                                                    constantcolors.greyColor),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            documentSnapshot[
                                                                'username'],
                                                            style: TextStyle(
                                                                color: constantcolors
                                                                    .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.0),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    child: Row(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20.0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              100,
                                                          child: Text(
                                                            documentSnapshot[
                                                                'comment'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.0),
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: constantcolors.greyColor),
                              width: 300.00,
                              height: 50.00,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
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
                                ),
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
                color: constantcolors.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
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
                                backgroundColor: constantcolors.transparent,
                                radius: 20.00,
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
