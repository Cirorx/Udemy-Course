import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flashchat/services/auth/user.dart' as flashchat;

import 'cloud_message.dart';

class FireBaseCloudStorage {
  FireBaseCloudStorage._sharedInstance();
  static final FireBaseCloudStorage _shared =
      FireBaseCloudStorage._sharedInstance();
  factory FireBaseCloudStorage() => _shared;

  final users = FirebaseFirestore.instance.collection("users");
  final messages = FirebaseFirestore.instance.collection("messages");

  late flashchat.User currentUser =
      flashchat.User.fromFirebase(FirebaseAuth.instance.currentUser!);

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

  Stream<List<Message>> getMessagesStream() {
    return messages.orderBy('date', descending: true).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => _getMessageFromDocument(doc)).toList());
  }

  Message _getMessageFromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final messageText = document.get('text');
    final messageUserEmail = document.get('mail');
    final messageUser = document.get('username');
    final messageTime = (document.get('date') as Timestamp).toDate();
    final date =
        '${messageTime.hour}:${messageTime.minute} - ${messageTime.day}/${messageTime.month}/${messageTime.year}';

    return Message(
      text: messageText,
      userIsSender: messageUserEmail == currentUser.email,
      senderName: messageUser,
      date: date,
    );
  }

  DateTime getDate() {
    DateTime now = DateTime.now();
    return now;
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
