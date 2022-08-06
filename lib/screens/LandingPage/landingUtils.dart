import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/LandingPage/landingServices.dart';
import 'package:provider/provider.dart';

class LandingUtils with ChangeNotifier {
  Constantcolors constantcolors = Constantcolors();

  final picker = ImagePicker();
  late File userAvatar;
  File get getuserAvatar => userAvatar;
  late String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null
        ? print('Select Image')
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<LandingService>(context, listen: false)
            .showUserAvatar(context)
        : print('Image upload error');
    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantcolors.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
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
                        color: constantcolors.blueColor,
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        }),
                    MaterialButton(
                        color: constantcolors.blueColor,
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              color: constantcolors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        })
                  ],
                )
              ],
            ),
          );
        });
  }
}
