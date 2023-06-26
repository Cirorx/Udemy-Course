import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flashchat/services/auth/user.dart' as flashchat;

class FireBaseCloudStorage {
  FireBaseCloudStorage._sharedInstance();
  static final FireBaseCloudStorage _shared =
      FireBaseCloudStorage._sharedInstance();
  factory FireBaseCloudStorage() => _shared;

  static final _firestore = FirebaseFirestore.instance;

  final users = _firestore.collection("users");
  final messages = _firestore.collection("messages");

  late flashchat.User currentUser =
      flashchat.User.fromFirebase(FirebaseAuth.instance.currentUser!);

  getFirestore() {
    return _firestore;
  }

  getMessages() {
    return messages;
  }

  void addMessage(String text) {
    messages.add({
      "mail": currentUser.email,
      "text": text,
      "username": currentUser.username,
      "date": getDate(),
    });
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.hour}:${now.minute} - ${now.day}/${now.month}/${now.year}";

    return formattedDate;
  }

  flashchat.User getCurrentUser() {
    return currentUser;
  }

  Future<void> setUser() async {
    //Get the current user data
    firebase.User user = FirebaseAuth.instance.currentUser!;
    //Compare the users with email
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        users.where("email", isEqualTo: user.email).limit(1).get();

    //await user data and set currentUser
    await snapshot.then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          snapshot.docs[0];
      Map<String, dynamic>? userData = documentSnapshot.data();

      currentUser = flashchat.User.fromMap(userData);
    });
  }
}
