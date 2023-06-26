import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../components/messages_stream.dart';
import '../constants.dart';
import '../services/auth/user.dart';
import '../services/auth/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = "chat_screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;

  final FireBaseCloudStorage _fireBaseCloudStorage = FireBaseCloudStorage();
  late User loggedInUser = _fireBaseCloudStorage.getCurrentUser();
  late String messageText;

  final messageController = TextEditingController();
  @override
  void initState() {
    initializeUser();
    super.initState();
  }

  Future<void> initializeUser() async {
    await _fireBaseCloudStorage.setUser();
    setState(() {
      loggedInUser = _fireBaseCloudStorage.getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                //service.logOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(firestore: _firestore, user: loggedInUser),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageController.clear();
                      // Get the current time
                      final currentTime = DateTime.now();

                      _firestore.collection("messages").add({
                        "mail": loggedInUser.email,
                        "text": messageText,
                        "username": loggedInUser.username,
                        "date": currentTime,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
