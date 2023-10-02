import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malf_application/features/chat/providers/chat_image_provider.dart';
import 'package:provider/provider.dart';

class AddImageState extends StatefulWidget {
  const AddImageState(this.addImageFunc, {super.key});
  final Function(XFile? pickedImage) addImageFunc;

  @override
  State<AddImageState> createState() => _AddImageStateState();
}

class _AddImageStateState extends State<AddImageState> {
  List<XFile?> pickedImages = [];

  void _pickImageGallery() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);
    setState(() {
      if (pickedImageFile != null) {
        pickedImages.insert(0, pickedImageFile);
      }
    });
    for (XFile? pickedImage in pickedImages) {
      widget.addImageFunc(pickedImage);
    }
  }

  void _pickImageCamera() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxHeight: 150);
    setState(() {
      if (pickedImageFile != null) {
        pickedImages.insert(0, pickedImageFile);
      }
    });
    for (XFile? pickedImage in pickedImages) {
      widget.addImageFunc(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: 150,
        height: 500,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 150,
              width: 150,
              child: pickedImages.isEmpty != true
                  ? ListView.builder(
                      itemCount: pickedImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(pickedImages[index]!.path),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("이미지를 선택하세요.")),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton.icon(
              onPressed: () {
                _pickImageCamera();
              },
              icon: const Icon(Icons.camera),
              label: const Text('camera'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                _pickImageGallery();
              },
              icon: const Icon(Icons.image),
              label: const Text('gallery'),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      Provider.of<ChatImageProvider>(context, listen: false)
                          .addNewImage(pickedImages);

                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('select')),
                TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('close')),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
