import 'package:flutter/foundation.dart';

import '../models/message_model.dart';

class HomeProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
