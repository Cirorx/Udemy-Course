import 'package:flashchat/services/auth/user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  User? get currentUser;
  Future<User> logIn({
    required String email,
    required String password,
  });
  Future<User> createUser({
    required String email,
    required String userName,
    required String password,
  });
  Future<void> sendPasswordReset({required String toEmail});

  Future<void> logOut();
}
