import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/main.dart';
import 'package:m_finder/screens/Feed/Feed_helpers.dart';
import 'package:m_finder/utils/UploadPost.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  Feed({Key? key}) : super(key: key);

  Constantcolors constantcolors = Constantcolors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(6.0)),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<UploadPost>(context, listen: false)
                    .selectPostImageType(context);
              },
              icon: Icon(
                Icons.camera_enhance_rounded,
              )),
        ],
        title: RichText(
            text: TextSpan(
                text: 'Medicine',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.00,
                ),
                children: <TextSpan>[
              TextSpan(
                text: 'Finder',
                style: TextStyle(
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
//  child: TextField(
//                                   minLines: 1,
//                                   maxLines: 5,
//                                   textCapitalization: TextCapitalization.words,
//                                   controller: commentcontroller,
//                                   style: const TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold),
//                                   decoration: const InputDecoration(
//                                     hintText: 'Add Comment...',
//                                     hintStyle: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),