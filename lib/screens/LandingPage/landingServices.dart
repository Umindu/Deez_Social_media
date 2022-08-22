import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingService with ChangeNotifier {
  TextEditingController useremailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  Constantcolors constantcolors = Constantcolors();

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantcolors.blueGreyColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.00),
                  child: Divider(
                    thickness: 4.00,
                    color: constantcolors.whiteColor,
                  )),
              CircleAvatar(
                radius: 80.0,
                backgroundColor: constantcolors.transparent,
                backgroundImage: FileImage(
                    Provider.of<LandingUtils>(context, listen: false)
                        .userAvatar),
              ),
              Container(
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
                          Provider.of<LandingUtils>(context, listen: false)
                              .pickUserAvatar(context, ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: constantcolors.blackColor,
                        child: Text(
                          'Confirm Image',
                          style: TextStyle(
                            color: constantcolors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .uploadUserAvatar(context)
                              .whenComplete(() {
                            signInsheet(context);
                          });
                        })
                  ],
                ),
              )
            ]),
          );
        });
  }

  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantcolors.blueGreyColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150.00),
                      child: Divider(
                        thickness: 4.00,
                        color: constantcolors.whiteColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.00),
                    child: TextField(
                        controller: useremailController,
                        decoration: InputDecoration(
                            hintText: 'Enter Email..',
                            hintStyle: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.00,
                            )),
                        style: TextStyle(
                          color: constantcolors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.00,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.00),
                    child: TextField(
                        controller: userpasswordController,
                        decoration: InputDecoration(
                            hintText: 'Enter Password..',
                            hintStyle: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.00,
                            )),
                        style: TextStyle(
                          color: constantcolors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.00,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FloatingActionButton(
                        backgroundColor: constantcolors.blueColor,
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: constantcolors.whiteColor,
                        ),
                        onPressed: () {
                          if (useremailController.text.isNotEmpty) {
                            Provider.of<Authentication>(context, listen: false)
                                .ligIntoAccount(useremailController.text,
                                    userpasswordController.text)
                                .whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: Homepage(),
                                      type: PageTransitionType.bottomToTop));
                            });
                          } else {
                            warningText(context, 'Fill all the data!');
                          }
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  signInsheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: constantcolors.blueColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(
                            12.0,
                          ))),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 150.00),
                          child: Divider(
                            thickness: 4.00,
                            color: constantcolors.whiteColor,
                          )),
                      CircleAvatar(
                        backgroundImage: FileImage(
                            Provider.of<LandingUtils>(context, listen: false)
                                .getuserAvatar),
                        backgroundColor: constantcolors.redColor,
                        radius: 60.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.00),
                        child: TextField(
                            controller: userNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter name..',
                                hintStyle: TextStyle(
                                  color: constantcolors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.00,
                                )),
                            style: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.00,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.00),
                        child: TextField(
                            controller: useremailController,
                            decoration: InputDecoration(
                                hintText: 'Enter Email..',
                                hintStyle: TextStyle(
                                  color: constantcolors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.00,
                                )),
                            style: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.00,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.00),
                        child: TextField(
                            controller: userpasswordController,
                            decoration: InputDecoration(
                                hintText: 'Enter Password..',
                                hintStyle: TextStyle(
                                  color: constantcolors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.00,
                                )),
                            style: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.00,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FloatingActionButton(
                            backgroundColor: constantcolors.redColor,
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: constantcolors.whiteColor,
                            ),
                            onPressed: () {
                              if (useremailController.text.isNotEmpty) {
                                Provider.of<Authentication>(context,
                                        listen: false)
                                    .createAccount(useremailController.text,
                                        userpasswordController.text)
                                    .whenComplete(() {
                                  print('Creating collection');
                                  Provider.of<FirebaseOperation>(context,
                                          listen: false)
                                      .createUserCollection(context, {
                                    'userid': Provider.of<Authentication>(
                                            context,
                                            listen: false)
                                        .getuserUid,
                                    'useremail': useremailController.text,
                                    'username': userNameController.text,
                                    'userimage': Provider.of<LandingUtils>(
                                            context,
                                            listen: false)
                                        .getUserAvatarUrl,
                                  });
                                }).whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: Homepage(),
                                          type:
                                              PageTransitionType.bottomToTop));
                                });
                              } else {
                                warningText(context, 'Fill all the data!');
                              }
                            }),
                      )
                    ],
                  )));
        });
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: constantcolors.darkColor,
                borderRadius: BorderRadius.circular(15.00)),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
              warning,
              style: TextStyle(
                color: constantcolors.whiteColor,
                fontSize: 10.00,
                fontWeight: FontWeight.bold,
              ),
            )),
          );
        });
  }
}
