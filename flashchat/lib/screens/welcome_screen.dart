import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../components/roundedbutton.dart';
import '../firebase_options.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String id = "welcome_screen";
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: "logo",
                          child: SizedBox(
                            height: 60.0,
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Flash Chat',
                              textStyle: const TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    RoundedButton(
                      title: 'Log in',
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                    RoundedButton(
                      title: 'Register',
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                    ),
                  ],
                ),
              );
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
