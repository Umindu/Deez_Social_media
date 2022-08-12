import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Feed/Feed_helpers.dart';
import 'package:m_finder/utils/UploadPost.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  Feed({Key? key}) : super(key: key);

  Constantcolors constantcolors = Constantcolors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: constantcolors.blueColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<UploadPost>(context, listen: false)
                    .selectPostImageType(context);
              },
              icon: Icon(
                Icons.camera_enhance_rounded,
                color: constantcolors.blackColor,
              ))
        ],
        title: RichText(
            text: TextSpan(
                text: 'Medicine',
                style: TextStyle(
                  color: constantcolors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.00,
                ),
                children: <TextSpan>[
              TextSpan(
                text: 'Finder',
                style: TextStyle(
                  color: constantcolors.darkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.00,
                ),
              )
            ])),
      ),
      body: Provider.of<FeedHelpers>(context, listen: false).feedBody(context),
    );
  }
}
