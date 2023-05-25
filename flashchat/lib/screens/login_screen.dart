import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/roundedbutton.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter your email"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password"),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: "Log in",
              onPressed: () async {
                //Implement login functionality.

                try {
                  //Implement registration functionality.
                  await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                } catch (e) {
                  print(e.toString());
                }
                Navigator.pushNamed(context, ChatScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
