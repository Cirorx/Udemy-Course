import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat/firebase_options.dart';
import 'package:flashchat/services/auth/auth_exceptions.dart';
import 'package:flashchat/services/auth/provider.dart';
import 'package:flashchat/services/auth/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

import 'cloud_firestore.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  final FireBaseCloudStorage cloudStorage = FireBaseCloudStorage();

  @override
  Future<User> createUser({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        // Create the user object
        final User user = User(
          id: firebaseUser.uid,
          username: userName,
          email: email,
        );

        // Add the user data to the "Users" collection in Firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .set(user.toMap());

        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else if (error.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else {
        //error isn't managed
        throw GenericAuthException();
      }
    }
  }

  @override
  User? get currentUser {
    return User.fromFirebase(FirebaseAuth.instance.currentUser!);
  }

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (error.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    }
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          throw InvalidEmailAuthException();
        case "user-not-found":
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
