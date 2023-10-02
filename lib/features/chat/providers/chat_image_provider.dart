import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ChatImageProvider extends ChangeNotifier {
  final List<XFile> _images = [];

  List<XFile> get images => _images;

  addNewImage(List<XFile?> images) {
    images = images;
    notifyListeners();
  }
}
