class Message {
  final int room;
  final String message;
  final String sender;
  final DateTime sentAt;

  Message({
    required this.room,
    required this.message,
    required this.sender,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      room: message['room'],
      message: message['message'],
      sender: message['sender'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(message['sentAt']),
    );
  }
}
