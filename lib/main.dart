import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/AltProfile/AltProfileHelper.dart';
import 'package:m_finder/screens/Feed/Feed_helpers.dart';
import 'package:m_finder/screens/Homepage/HomepageHepers.dart';
import 'package:m_finder/screens/LandingPage/landingHelpers.dart';
import 'package:m_finder/screens/LandingPage/landingServices.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/screens/Profile/ProfileHelpers.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:m_finder/utils/PostOptions.dart';
import 'package:m_finder/utils/UploadPost.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Constantcolors constantcolors = Constantcolors();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AltProfileHelper()),
          ChangeNotifierProvider(create: (_) => PostFunctions()),
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => UploadPost()),
          ChangeNotifierProvider(create: (_) => ProfileHelper()),
          ChangeNotifierProvider(create: (_) => HomepageHelpers()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOperation()),
          ChangeNotifierProvider(create: (_) => LandingService()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => landingHelpers()),
        ],
        child: MaterialApp(
          home: const Splashscreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            canvasColor: Colors.transparent,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: constantcolors.blueColor),
          ),
        ));
  }
}
