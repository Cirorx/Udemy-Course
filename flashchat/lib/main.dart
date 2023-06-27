import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flashchat/services/auth/bloc/auth_bloc.dart';
import 'package:flashchat/services/auth/bloc/auth_event.dart';
import 'package:flashchat/services/auth/bloc/auth_state.dart';
import 'package:flashchat/services/auth/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/easy_loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();

  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.lightBlueAccent),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color.fromARGB(255, 46, 140, 184),
        ),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const FlashChat(),
      ),
      routes: {
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ChatScreen.id: (context) => const ChatScreen()
      },
      builder: EasyLoading.init(),
    ),
  );
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateUninitialized) {
          EasyLoading.show(status: "Loading...");
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const ChatScreen();
        } else if (state is AuthStateLogginIn) {
          return const LoginScreen();
        } else if (state is AuthStateLoggedOut) {
          return const WelcomeScreen();
        } else if (state is AuthStateRegistering) {
          return const RegistrationScreen();
        } else {
          return Container();
        }
      },
    );
  }
}
