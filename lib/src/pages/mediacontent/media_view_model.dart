import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaViewModel extends ChangeNotifier {
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

  Widget proverFileImageView() {
    if (fileInput == null)
      return Image(
        image: CachedNetworkImageProvider('https://i.imgur.com/sUFH1Aq.png'),
      );
    return Image.file(
      File(
        fileInput.path,
      ),
      fit: BoxFit.contain,
    );
  }

  String get path => _fileInput?.path ?? '';

  bool get isValidImage => fileInput != null;
}
