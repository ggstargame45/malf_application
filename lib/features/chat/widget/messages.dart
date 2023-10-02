import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/message_provider.dart';
import 'chat_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.postId, required this.userName});
  final String userName;
  final String postId;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (_, provider, __) {
      Logger().d(provider.messages);
      return ListView.builder(
        reverse: true,
        itemCount: provider.messages.length,
        itemBuilder: (context, index) {
          final message = provider.messages[index];
          final beforeMessageUser = index == provider.messages.length - 1
              ? null
              : provider.messages[index + 1].sender;
          final beforeMessageTime = index == provider.messages.length - 1
              ? null
              : provider.messages[index + 1].sendAt;
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: ChatBubbleMessage(
                postId: widget.postId,
                userName: widget.userName,
                message: message,
                beforeTime: beforeMessageTime,
                beforeUser: beforeMessageUser),
          );
        },
      );
    });
  }
}
