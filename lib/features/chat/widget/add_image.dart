import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AddImageState extends StatefulWidget {
  AddImageState(this.addImageFunc, {required this.postId, super.key});
  String postId;
  final Function(XFile? pickedImage) addImageFunc;

  @override
  State<AddImageState> createState() => _AddImageStateState();
}

class _AddImageStateState extends State<AddImageState> {
  List<XFile?> pickedImages = [];
  final Dio _dio = Dio();

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

  Future<bool> sendImages(List<XFile?> imageList, String postId) async {
    // MultiPartRequest로 request 정의
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://malftravel.com/chat/$postId/image"));

    // request에 사진 업로드
    for (int i = 0; i < imageList.length; i++) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageList[i]!.path));
    }

    // request 헤더 설정
    request.headers['Authorization'] =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX3VuaXFfaWQiOiJ0ZXN0XzEiLCJpYXQiOjE2OTI2Mjg2MTcsImV4cCI6MTcyNDE2NDYxN30.-X3GnzUEMfmpIRXznFtdJdDr5x5aWa-D_kU_w9mU6hk';
    request.headers['Content-Type'] = 'multipart/form-data;';

    // request.send()를 통해 post
    var response = await request.send();

    if (response.statusCode == 200) {
      Logger().d('요청이 성공적으로 처리되었습니다.');
      return true;
    } else {
      Logger().e('요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
      return false;
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
                      try {
                        sendImages(pickedImages, widget.postId);
                      } catch (e) {
                        Logger().e(e);
                      }
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
