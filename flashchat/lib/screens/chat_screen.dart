import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/cloud/messages_stream.dart';
import '../constants.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../services/auth/bloc/auth_state.dart';
import '../services/auth/service.dart';
import '../services/auth/user.dart';
import '../services/cloud/cloud_firestore.dart';
import '../utilities/dialogues/logout_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('⚡️Chat'),
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            PopupMenuButton<MenuAction>(
              color: Colors.lightBlueAccent[900],
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log out'),
                  ),
                ];
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MessageStream(),
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
                          _fireBaseCloudStorage
                              .addMessage(messageController.text);
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
        ),
      ),
    );
  }
}
