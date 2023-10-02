import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/features/chat/widget/add_image.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NewMessage extends StatefulWidget {
  final String userName;
  final IO.Socket socket;
  final String? postId;
  const NewMessage(
      {super.key,
      required this.postId,
      required this.userName,
      required this.socket});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  late IO.Socket _socket;
  bool isImgMessage = false;
  final TextEditingController _messageInputController = TextEditingController();
  _sendMessage() {
    _socket.emit('chat', {
      'room': "1",
      'message': _messageInputController.text.trim(),
      'sender': widget.userName
    });
    // Provider.of<MessageProvider>(context, listen: false).addNewMessage(
    //   Message(
    //     room: 'Room4',
    //     message: _messageInputController.text.trim(),
    //     sender: widget.userName,
    //     sendAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
    //   ),
    // );
    Logger().d(_messageInputController.text);
    _messageInputController.clear();
  }

  List<XFile?> pickedImage = [];

  // void _pickImage() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImageFile = await imagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);
  //   setState(() {
  //     if (pickedImageFile != null) {
  //       pickedImage = File(pickedImageFile.path);
  //     }
  //   });
  // }
  void pickImage(XFile? image) {
    pickedImage.insert(0, image);
  }

  void showImagePicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddImageState(
            pickImage,
            postId: "1",
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _socket = widget.socket;
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
  }

  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageInputController,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      showImagePicker(context);
                    },
                    icon: const Icon(Icons.photo, size: 30)),
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                filled: true,
                fillColor: const Color.fromARGB(97, 158, 158, 158),
                hintText: "메세지를 입력하세요",
                hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            maxLines: null,
          )),
          IconButton(
            onPressed: () {
              if (_messageInputController.text.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            icon: const Icon(Icons.send),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
