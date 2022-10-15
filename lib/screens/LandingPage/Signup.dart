import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_finder/constants/Constantcolors.dart';
import 'package:m_finder/screens/Homepage/Homepage.dart';
import 'package:m_finder/screens/LandingPage/Login.dart';
import 'package:m_finder/screens/LandingPage/landingUtils.dart';
import 'package:m_finder/services/Authentication.dart';
import 'package:m_finder/services/FirebaseOperation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Constantcolors constantcolors = Constantcolors();
late String getusername;
late String getuseremail;

class SingUpPage extends StatefulWidget {
  SingUpPage({Key? key}) : super(key: key);

  get username => getusername;
  get useremail => getuseremail;
  @override
  State<SingUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SingUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 325,
                height: 470,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please Register to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                          controller: userNameController,
                          decoration: InputDecoration(
                              suffix: Icon(
                                FontAwesomeIcons.user,
                                size: 20,
                              ),
                              labelText: 'Your Name',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              suffix: Icon(
                                FontAwesomeIcons.envelope,
                                size: 20,
                              ),
                              labelText: 'Email Address',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              suffix: Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 20,
                              ),
                              labelText: 'Password',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))))),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        getusername = userNameController.text;
                        getuseremail = emailController.text;

                        if (emailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .createAccount(
                                  emailController.text, passwordController.text)
                              .whenComplete(() {
                            Provider.of<LandingUtils>(context, listen: false)
                                .selectAvatarOptionsSheet(context);
                          });
                        } else {}
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  constantcolors.darkpurple,
                                  constantcolors.purple
                                ])),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to Login ? ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
