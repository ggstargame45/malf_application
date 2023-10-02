import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../providers/chat_image_provider.dart';

Widget _buildTimeStamp(DateTime sendAt) {
  return Row(
    children: [
      Text(
        DateFormat('hh:mm a').format(sendAt),
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      ),
    ],
  );
}

Widget _buildMessageBubble(
    BuildContext context, bool isSentByCurrentUser, Message message,
    {List<XFile>? pickedImages}) {
  return Consumer<ChatImageProvider>(builder: (_, provider, __) {
    pickedImages = provider.images;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isSentByCurrentUser) _buildTimeStamp(message.sendAt),
        ChatBubble(
          clipper: ChatBubbleClipper5(
              type: isSentByCurrentUser
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble),
          alignment:
              isSentByCurrentUser ? Alignment.topRight : Alignment.topLeft,
          margin: const EdgeInsets.only(right: 4, left: 4),
          backGroundColor: isSentByCurrentUser ? Colors.blue : Colors.white,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: pickedImages!.isEmpty == true
                ? Text(
                    message.message,
                    style: TextStyle(
                        color:
                            isSentByCurrentUser ? Colors.white : Colors.black),
                  )
                : ListView.builder(
                    itemCount: pickedImages!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(pickedImages![index].path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
        ),
        if (!isSentByCurrentUser) _buildTimeStamp(message.sendAt),
      ],
    );
  });
}

class ChatBubbleMessage extends StatefulWidget {
  final String userName;
  final Message message;
  final String? beforeUser;
  final DateTime? beforeTime;
  final List<XFile>? pickedImages;
  const ChatBubbleMessage(
      {super.key,
      required this.userName,
      required this.message,
      this.beforeUser,
      this.beforeTime,
      this.pickedImages});

  @override
  State<ChatBubbleMessage> createState() => _ChatBubbleMessageState();
}

class _ChatBubbleMessageState extends State<ChatBubbleMessage> {
  @override
  Widget build(BuildContext context) {
    bool isSentByCurrentUser = widget.userName == widget.message.sender;

    return Padding(
      padding: widget.userName == widget.beforeUser
          ? const EdgeInsets.only(top: 2)
          : const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: isSentByCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSentByCurrentUser &&
              widget.message.sender != widget.beforeUser)
            const CircleAvatar(
              backgroundColor: Colors.blue,
              maxRadius: 16,
            ),
          if (!isSentByCurrentUser &&
              widget.message.sender == widget.beforeUser)
            const SizedBox(
              width: 32,
            ),
          const SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.message.sender != widget.beforeUser &&
                  !isSentByCurrentUser)
                Text(
                  widget.message.sender,
                ),
              _buildMessageBubble(context, isSentByCurrentUser, widget.message,
                  pickedImages: widget.pickedImages),
              const SizedBox(height: 3),
            ],
          ),
        ],
      ),
    );
  }
}
