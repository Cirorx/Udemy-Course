import 'package:flutter/material.dart';
import '../components/messages_stream.dart';
import '../constants.dart';
import '../services/auth/service.dart';
import '../services/auth/user.dart';
import '../services/auth/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = "chat_screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthService service = AuthService.firebase();
  final FireBaseCloudStorage _fireBaseCloudStorage = FireBaseCloudStorage();

  late User loggedInUser = _fireBaseCloudStorage.getCurrentUser();
  late TextEditingController messageController;

  @override
  void initState() {
    initializeUser();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
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
              onPressed: () async {
                service.logOut();
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
            MessageStream(user: loggedInUser),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.black),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _fireBaseCloudStorage.addMessage(messageController.text);
                      messageController.clear();
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
