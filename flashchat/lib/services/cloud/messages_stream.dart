import 'package:flashchat/utilities/dialogues/error_dialog.dart';
import 'package:flutter/material.dart';
import 'cloud_firestore.dart';
import 'cloud_message.dart';
import '../../components/message_bubble.dart';

class MessageStream extends StatelessWidget {
  MessageStream({
    super.key,
  });

  final FireBaseCloudStorage _fireBaseCloudStorage = FireBaseCloudStorage();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: _fireBaseCloudStorage.getMessagesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          showErrorDialog(context, "An error has ocurred loading messages.");
          return Container();
        } else {
          final messages = snapshot.data ?? [];

          return Expanded(
            child: ListView.builder(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(
                  senderName: message.senderName,
                  text: message.text,
                  userIsSender: message.userIsSender,
                  date: message.date,
                );
              },
            ),
          );
        }
      },
    );
  }
}
