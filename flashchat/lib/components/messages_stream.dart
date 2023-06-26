import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../services/auth/cloud_firestore.dart';
import '../services/auth/user.dart';
import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  MessageStream({
    super.key,
    required this.user,
  });

  final User user;

  final FireBaseCloudStorage _fireBaseCloudStorage = FireBaseCloudStorage();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireBaseCloudStorage
          .getMessages()
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          );
        } else {
          List<MessageBubble> messageBubbles = [];
          for (var element in snapshot.data!.docs) {
            final message = element.get("text");
            final messageSenderEmail = element.get("mail");
            final userName = element.get("username");
            final date = element.get("date").toString();

            final currentUserEmail = user.email;

            final messageBubble = MessageBubble(
              senderName: userName,
              text: message,
              userIsSender: currentUserEmail == messageSenderEmail,
              date: date,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        }
      },
    );
  }
}
