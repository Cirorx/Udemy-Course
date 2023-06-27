import 'package:flashchat/components/roundedbutton.dart';
import 'package:flashchat/services/auth/auth_exceptions.dart';
import 'package:flashchat/services/auth/bloc/auth_state.dart';
import 'package:flashchat/services/auth/service.dart';
import 'package:flashchat/utilities/dialogues/missingFields_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/password_textfield.dart';
import '../constants.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../utilities/dialogues/error_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              "Cannot find a user with the entered credentials",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Authentication error");
          }
        }
      },
      child: Scaffold(
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
              PasswordTextField(
                controller: password,
                hintText: "Enter your password",
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: "Log in",
                onPressed: () async {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    showMissingFieldsDialog(
                      context,
                      "Please fill in all the fields.",
                    );
                  } else {
                    context.read<AuthBloc>().add(
                          AuthEventLogIn(
                            email.text,
                            password.text,
                          ),
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
