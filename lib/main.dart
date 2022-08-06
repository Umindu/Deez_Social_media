import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Homepage/HomepageHepers.dart';
import 'package:m_finder/screens/LandingPage/landingHelpers.dart';
import 'package:m_finder/screens/LandingPage/landingServices.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/screens/Splashscreen/splashScreen.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
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
