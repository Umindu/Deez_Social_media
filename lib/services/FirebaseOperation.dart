import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:provider/provider.dart';

class FirebaseOperation with ChangeNotifier {
  late UploadTask imageUploadTask;

  late String initUserEmail;
  late String initUserName;
  late String initUserImage;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getuserAvatar.path}/${TimeOfDay.now()}');

    // imageUploadTask = imageReference.putFile(
    //     Provider.of<LandingUtils>(context, listen: false).getuserAvatar);
    imageUploadTask = imageReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getuserAvatar);

    await imageUploadTask.whenComplete(() {
      print('Image Uploaded !');
    });
    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          'The user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = url.toString()} ');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getuserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getuserUid)
        .get()
        .then((doc) {
      print('Fetching user data');
      initUserName = doc.data()!['username'];
      initUserEmail = doc.data()!['useremail'];
      initUserImage = doc.data()!['userimage'];
      print(initUserName);
      print(initUserEmail);
      print(initUserImage);
      notifyListeners();
    });
  }
}
