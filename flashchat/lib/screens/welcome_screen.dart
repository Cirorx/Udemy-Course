import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flashchat/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/roundedbutton.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
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
                    totalRepeatCount: 10,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        speed: const Duration(milliseconds: 100),
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
                  context.read<AuthBloc>().add(
                        const AuthEventShouldLogin(),
                      );
                },
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventShouldRegister(),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
