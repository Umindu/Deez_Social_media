import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/LandingPage/landingServices.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:provider/provider.dart';

class UploadPost with ChangeNotifier {
  TextEditingController captioncontroller = TextEditingController();

  Constantcolors constantcolors = Constantcolors();

  late File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  late String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  late UploadTask imagePostUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadpostImageVal = await picker.getImage(source: source);
    uploadpostImageVal == null
        ? print('Select Image')
        : uploadPostImage = File(uploadpostImageVal.path);
    print('Image upload error');

    uploadPostImage != null
        ? showPostimage(context)
        : print('Image upload error');
    notifyListeners();
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('post/${uploadPostImage.path}/${TimeOfDay.now()}');

    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print('Post Image Uploaded to Storage');
    });
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantcolors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.00),
                    child: Divider(
                      thickness: 4.00,
                      color: constantcolors.whiteColor,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantcolors.blackColor,
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            color: constantcolors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.00,
                          ),
                        ),
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: constantcolors.blackColor,
                        child: Text(
                          'Camera',
                          style: TextStyle(
                            color: constantcolors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.00,
                          ),
                        ),
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.camera);
                        })
                  ],
                )
              ],
            ),
          );
        });
  }

  showPostimage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantcolors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.00),
                    child: Divider(
                      thickness: 4.00,
                      color: constantcolors.whiteColor,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    width: 400.0,
                    child: Image.file(
                      uploadPostImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          child: Text(
                            'Reselect',
                            style: TextStyle(
                                color: constantcolors.whiteColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: constantcolors.whiteColor),
                          ),
                          onPressed: () {
                            selectPostImageType(context);
                          }),
                      MaterialButton(
                          color: constantcolors.whiteColor,
                          child: Text(
                            'Confirm Image',
                            style: TextStyle(
                              color: constantcolors.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            uploadPostImageToFirebase().whenComplete(() {
                              editPostSheet(context);
                              print('Image Uploaded');
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

  editPostSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            // ignore: sort_child_properties_last
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
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.image_aspect_ratio,
                                color: constantcolors.blackColor,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.fit_screen,
                                color: constantcolors.blackColor,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: constantcolors.blackColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120.00,
                          width: 330.0,
                          child: TextField(
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            //..........................................maxLengthEnforced: true,
                            maxLength: 100,
                            controller: captioncontroller,
                            style: TextStyle(
                                color: constantcolors.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: 'Add A Caption...',
                              hintStyle: TextStyle(
                                  color: constantcolors.blackColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  color: constantcolors.blueColor,
                  child: Text(
                    'Share',
                    style: TextStyle(
                        color: constantcolors.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    Provider.of<FirebaseOperation>(context, listen: false)
                        .uploadPostData(captioncontroller.text, {
                      'postimage': getUploadPostImageUrl,
                      'caption': captioncontroller.text,
                      'username':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .initUserName,
                      'userimage':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .initUserImage,
                      'useruid':
                          Provider.of<Authentication>(context, listen: false)
                              .getuserUid,
                      'time': Timestamp.now(),
                      'useremail':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .initUserEmail,
                    }).whenComplete(() async {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(Provider.of<Authentication>(context,
                                  listen: false)
                              .userUid)
                          .collection('posts')
                          .add({
                        'postimage': getUploadPostImageUrl,
                        'caption': captioncontroller.text,
                        'username': Provider.of<FirebaseOperation>(context,
                                listen: false)
                            .initUserName,
                        'userimage': Provider.of<FirebaseOperation>(context,
                                listen: false)
                            .initUserImage,
                        'useruid':
                            Provider.of<Authentication>(context, listen: false)
                                .getuserUid,
                        'time': Timestamp.now(),
                        'useremail': Provider.of<FirebaseOperation>(context,
                                listen: false)
                            .initUserEmail,
                      });
                    }).whenComplete(() async {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantcolors.whiteColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
