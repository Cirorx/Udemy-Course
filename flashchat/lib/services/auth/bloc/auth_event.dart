import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  //Type event that will be expected from bloc
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;
  const AuthEventRegister(
      {required this.email, required this.password, required this.username});
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventShouldLogin extends AuthEvent {
  const AuthEventShouldLogin();
}
