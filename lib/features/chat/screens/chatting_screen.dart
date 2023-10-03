import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/message_model.dart';
import '../providers/message_provider.dart';
import '../widget/messages.dart';
import '../widget/new_messge.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({required this.postId, super.key});
  String userName = "Alice";
  String? postId;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late IO.Socket _socket;

  _connectSocket() {
    try {
      _socket = IO.io(
        'http://13.125.43.68:8000/chat',
        IO.OptionBuilder()
            .setPath("/chatTest")
            .setTransports(['websocket']).build(),
      );
      _socket.onConnect((data) => Logger().d('Connection established'));
      _socket.onConnectError((data) => Logger().d('Connect Error: $data'));
      _socket
          .onDisconnect((data) => Logger().d('Socket.IO server disconnected'));
      _socket.emit("join", widget.postId);
      _socket.on(
          'join',
          (data) => {
                Logger().d(data),
              });
      _socket.on(
          'image',
          (data) => {
                Logger().d(data),
                Provider.of<MessageProvider>(context, listen: false)
                    .addNewMessage(
                  Message.fromJson(data),
                )
              });
      _socket.on(
          'chat',
          (data) => {
                Logger().d(data),
                Provider.of<MessageProvider>(context, listen: false)
                    .addNewMessage(
                  Message.fromJson(data),
                )
              });
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Center(
              child: Text(
            "경복궁 같이가요!",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          actions: const [
            Icon(Icons.menu_rounded, color: Colors.black),
            SizedBox(
              width: 16,
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        child: Messages(
                      postId: widget.postId!,
                      userName: widget.userName,
                    )),
                    NewMessage(
                      userName: widget.userName,
                      socket: _socket,
                      postId: widget.postId,
                    ),
                  ],
                ),
              ),
            ),
            KeyboardVisibilityBuilder(builder: (context, iskeyboardVisible) {
              return Visibility(
                visible: !iskeyboardVisible,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        const SizedBox(
                          width: 300,
                          height: 80,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("sophie"),
                                  ],
                                ),
                                Text("경복궁 같이 가요!",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [Text("성동구 왕십리")],
                                )
                              ]),
                        )
                      ]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
