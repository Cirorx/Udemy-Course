import 'package:flashchat/services/auth/firebase_auth_provider.dart';
import 'package:flashchat/services/auth/provider.dart';
import 'package:flashchat/services/auth/user.dart';

class AuthService implements AuthProvider {
  //this class servs as a brigde between UI and LOGIC

  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<User> createUser(
          {required String email,
          required String userName,
          required String password}) =>
      provider.createUser(
        email: email,
        userName: userName,
        password: password,
      );

  @override
  User? get currentUser => provider.currentUser;

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> sendPasswordReset({required String toEmail}) =>
      provider.sendPasswordReset(toEmail: toEmail);
}
