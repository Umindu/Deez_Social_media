import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:m_finder/screens/Profile/Profile.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late String userUid;
  String get getuserUid => userUid;

  //Email & Password......................................................................................

  Future ligIntoAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if (finalUid == '') {
      userUid = user!.uid;
      print(' User Uid = $userUid');
    } else {
      userUid = finalUid;
    }

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('uid', userUid);

    notifyListeners();
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    userUid = user!.uid;
    print(' User Uid = $userUid');

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('uid', userUid);
    notifyListeners();
  }

  //Email signout..................................................................................................
  Future logOutViaEmail() {
    return firebaseAuth.signOut();
  }
}
