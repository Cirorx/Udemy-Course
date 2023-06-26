import 'package:flashchat/components/roundedbutton.dart';
import 'package:flashchat/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email, password;
  final AuthService service = AuthService.firebase();

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

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
            Flexible(
              child: Hero(
                tag: "logo",
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
              controller: email,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter your email"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
              controller: password,
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
                EasyLoading.show(status: 'Loggin in...');
                await service.logIn(
                  email: email.text,
                  password: password.text,
                );
                Navigator.pushNamed(context, ChatScreen.id);
                await EasyLoading.dismiss();
              },
            ),
          ],
        ),
      ),
    );
  }
}
