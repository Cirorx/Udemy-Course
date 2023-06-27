class Message {
  final String senderName;
  final String text;
  final String date;
  final bool userIsSender;

  Message(
      {required this.senderName,
      required this.text,
      required this.date,
      required this.userIsSender});
}
