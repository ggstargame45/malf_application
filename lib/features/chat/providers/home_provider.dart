import 'package:flutter/foundation.dart';

import '../models/message_model.dart';

class HomeProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
      room: 'Room1',
      message: 'Hello, how are you?',
      sender: 'Alice',
      sendAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Message(
      room: 'Room1',
      message: 'I am good, thanks!',
      sender: 'Bob',
      sendAt: DateTime.now().subtract(const Duration(minutes: 29)),
    ),
    Message(
      room: 'Room2',
      message: 'Did you finish the assignment?',
      sender: 'Bob',
      sendAt: DateTime.now().subtract(const Duration(minutes: 29)),
    ),
    Message(
      room: 'Room2',
      message: 'Not yet, will do it soon.',
      sender: 'David',
      sendAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 10)),
    ),
    Message(
      room: 'Room3',
      message: 'Happy birthday!',
      sender: 'Eve',
      sendAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Message(
      room: 'Room3',
      message: 'Thank you so much!',
      sender: 'Frank',
      sendAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    Message(
      room: 'Room4',
      message: 'Let\'s meet at 5pm.',
      sender: 'Grace',
      sendAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Message(
      room: 'Room4',
      message: 'Sounds good!',
      sender: 'Hannah',
      sendAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
    ),
  ];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
