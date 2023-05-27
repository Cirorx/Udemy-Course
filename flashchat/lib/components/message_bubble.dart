import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender, text;
  final bool userIsSender;
  const MessageBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.userIsSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            userIsSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topRight: userIsSender
                  ? const Radius.circular(0)
                  : const Radius.circular(30),
              topLeft: userIsSender
                  ? const Radius.circular(30)
                  : const Radius.circular(0),
              bottomLeft: const Radius.circular(30),
              bottomRight: const Radius.circular(30),
            ),
            elevation: 7,
            color: userIsSender ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
