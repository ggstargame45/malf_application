class Message {
  final String room;
  final String message;
  final String sender;
  final DateTime sendAt;

  Message({
    required this.room,
    required this.message,
    required this.sender,
    required this.sendAt,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      room: message['room'],
      message: message['message'],
      sender: message['sender'],
      sendAt: DateTime.fromMillisecondsSinceEpoch(message['sendAt']),
    );
  }
}
