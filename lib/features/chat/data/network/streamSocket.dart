import 'dart:async';

import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  try {
    IO.Socket socket = IO.io('http://3.36.185.179:8000/test/chatTest',
        OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      Logger().d('connect');
      socket.emit('chat', 'test');
    });
    socket.emit('chat', 'test');
    //When an event recieved from server, data is added to the stream
    socket.on('news', (data) => {Logger().d(data)});
    socket.onDisconnect((_) => Logger().d('disconnect'));
  } catch (e) {
    Logger().e(e);
  }
}
