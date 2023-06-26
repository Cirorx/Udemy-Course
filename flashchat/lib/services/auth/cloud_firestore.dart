import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flashchat/services/auth/user.dart' as flashchat_user;

class FireBaseCloudStorage {
  FireBaseCloudStorage._sharedInstance();
  static final FireBaseCloudStorage _shared =
      FireBaseCloudStorage._sharedInstance();
  factory FireBaseCloudStorage() => _shared;

  final users = FirebaseFirestore.instance.collection("users");

  late flashchat_user.User currentUser =
      flashchat_user.User.fromFirebase(FirebaseAuth.instance.currentUser!);

  flashchat_user.User getCurrentUser() {
    return currentUser;
  }

  Future<void> setUser() async {
    firebase_user.User user = FirebaseAuth.instance.currentUser!;
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        users.where("email", isEqualTo: user.email).limit(1).get();

    await snapshot.then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          snapshot.docs[0];
      Map<String, dynamic>? userData = documentSnapshot.data();

      currentUser = flashchat_user.User.fromMap(userData);
    });
  }
}
