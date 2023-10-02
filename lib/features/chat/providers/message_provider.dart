import 'package:flutter/foundation.dart';

import '../models/message_model.dart';

class MessageProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
        room: '1',
        message:
            "['1689420712322-431438052.jpeg','1689420712322-431438052.jpeg']",
        sender: 'Alice',
        sendAt: DateTime.now(),
        type: 1,
        senderUID: ""),
    Message(
        room: '1',
        message:
            "['1689420712322-431438052.jpeg','1689420712322-431438052.jpeg']",
        sender: 'jana',
        sendAt: DateTime.now(),
        type: 1,
        senderUID: "")
  ];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
