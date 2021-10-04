import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryMediaViewModel extends ChangeNotifier {
  PickedFile _fileInput;

  PickedFile get fileInput => _fileInput;

  void openGalleryForImage() async {
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _fileInput = pickedImage;
      notifyListeners();
    }
  }

  void clear() {
    _fileInput = null;
  }
}
