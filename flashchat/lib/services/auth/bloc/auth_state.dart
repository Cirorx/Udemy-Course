import 'package:flashchat/services/auth/user.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading});
}

class AuthStateLoggedIn extends AuthState {
  final User user;
  const AuthStateLoggedIn({required this.user});
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception});
}

class AuthStateLogginIn extends AuthState {
  final Exception? exception;
  const AuthStateLogginIn({required this.exception});
}
