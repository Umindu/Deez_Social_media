import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfile.dart';
import 'package:m_finder/screens/AltProfile/AltProfileHelper.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
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

  late String imageTimeCommented;
  String get getImageTimeCommented => imageTimeCommented;

  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeago.format(dateTime);
    print(imageTimePosted);
    notifyListeners();
  }

  showCommentTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimeCommented = timeago.format(dateTime);
    print(imageTimeCommented);
    notifyListeners();
  }

  showPostOptions(BuildContext context, String postId) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: Wrap(
            children: [
              const ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
              ),
              const ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy Link'),
              ),
              const ListTile(
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
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          title: const Text(
                            'Delete This Post ?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          actions: [
                            MaterialButton(
                                child: const Text(
                                  'No',
                                  style: TextStyle(
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
                                      .deleteUserData(postId, 'posts')
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
      'useruid': (finalUid == ''
          ? Provider.of<Authentication>(context, listen: false).getuserUid
          : finalUid),
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
      'useruid': (finalUid == ''
          ? Provider.of<Authentication>(context, listen: false).getuserUid
          : finalUid),
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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150.00),
                      child: Divider(
                        thickness: 4.00,
                      )),
                  Container(
                    width: 100,
                    child: const Center(
                        child: Text(
                      'Comments',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
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
                              Provider.of<PostFunctions>(context, listen: false)
                                  .showCommentTimeAgo(documentSnapshot['time']);
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (documentSnapshot[
                                                        'useruid'] !=
                                                    (finalUid == ''
                                                        ? Provider.of<
                                                                    Authentication>(
                                                                context,
                                                                listen: false)
                                                            .getuserUid
                                                        : finalUid)) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      PageTransition(
                                                          child: AltProfile(
                                                            userUid:
                                                                documentSnapshot[
                                                                    'useruid'],
                                                          ),
                                                          type:
                                                              PageTransitionType
                                                                  .bottomToTop));
                                                }
                                              },
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      constantcolors
                                                          .transparent,
                                                  radius: 20.00,
                                                  backgroundImage: NetworkImage(
                                                      documentSnapshot[
                                                          'userimage'])),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[500],
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
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
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              documentSnapshot[
                                                                  'username'],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Row(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0),
                                                          child: Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 50,
                                                              maxWidth: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  100,
                                                            ),
                                                            child: Text(
                                                              documentSnapshot[
                                                                  'comment'],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0),
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60.0, top: 4.0),
                                        child: Container(
                                          child: Text(
                                            '${Provider.of<PostFunctions>(context, listen: false).imageTimeCommented.toString()} ,',
                                            style: GoogleFonts.lato(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
                              ),
                              width: 300.00,
                              height: 60.00,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),

                                child: TextField(
                                  autofocus: true,
                                  minLines: 1,
                                  maxLines: 5,
                                  textCapitalization: TextCapitalization.words,
                                  controller: commentcontroller,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    hintText: 'Add Comment...',
                                    hintStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                // child: TextField(
                                //   textCapitalization:
                                //       TextCapitalization.sentences,
                                //   decoration: const InputDecoration(
                                //     hintText: 'Add Comment...',
                                //     hintStyle: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 16.0),
                                //   ),
                                //   controller: commentcontroller,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 16.0),
                                // ),
                              )),
                          IconButton(
                            onPressed: () {
                              print('Adding comment..');
                              addComment(context, snapshot['caption'],
                                      commentcontroller.text)
                                  .whenComplete(() {
                                commentcontroller.clear();
                                notifyListeners();
                              });
                            },
                            icon: Icon(
                              Icons.send,
                            ),
                          ),
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
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.00),
                  child: Divider(
                    thickness: 4.00,
                  )),
              Container(
                width: 100,
                child: const Center(
                    child: Text(
                  'Likes',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .collection('likes')
                      .orderBy("time")
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot) {
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              if (DocumentSnapshot['useruid'] !=
                                  (finalUid == ''
                                      ? Provider.of<Authentication>(context,
                                              listen: false)
                                          .getuserUid
                                      : finalUid)) {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AltProfile(
                                          userUid: DocumentSnapshot['useruid'],
                                        ),
                                        type: PageTransitionType.bottomToTop));
                              }
                            },
                            child: CircleAvatar(
                                backgroundColor: constantcolors.transparent,
                                radius: 20.00,
                                backgroundImage: NetworkImage(
                                    DocumentSnapshot['userimage'])),
                          ),
                          title: Text(
                            DocumentSnapshot['username'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          subtitle: Text(
                            DocumentSnapshot['useremail'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
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
