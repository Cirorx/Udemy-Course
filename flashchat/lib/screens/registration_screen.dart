import 'package:flashchat/components/roundedbutton.dart';

import 'package:flashchat/services/auth/bloc/auth_event.dart';
import 'package:flashchat/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/password_textfield.dart';
import '../constants.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';
import '../utilities/dialogues/error_dialog.dart';
import '../utilities/dialogues/missingFields_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = "registration_screen";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController _email, _userName, _password;
  final AuthService service = AuthService.firebase();

  @override
  void initState() {
    _userName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, "Email already in use");
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, "Invalid email");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Failed to register");
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey[400],
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
                autofocus: true,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                controller: _userName,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter your user name"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                autocorrect: false,
                controller: _email,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Enter your email"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              PasswordTextField(
                controller: _password,
                hintText: "Enter your password",
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: "Register",
                color: Colors.blueAccent,
                onPressed: () {
                  if (_email.text.isEmpty ||
                      _userName.text.isEmpty ||
                      _password.text.isEmpty) {
                    showMissingFieldsDialog(
                      context,
                      "Please fill in all the fields.",
                    );
                  } else {
                    context.read<AuthBloc>().add(
                          AuthEventRegister(
                            email: _email.text,
                            username: _userName.text,
                            password: _password.text,
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
