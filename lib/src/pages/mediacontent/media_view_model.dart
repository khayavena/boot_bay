import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderViewModel extends ChangeNotifier {
  XFile _fileInput;

  XFile get fileInput => _fileInput;

  void openGalleryForImage() async {
    XFile pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _fileInput = pickedImage;
      notifyListeners();
    }
  }

  void clear() {
    _fileInput = null;
  }

  Widget proverFileImageView({String imageUrl}) {
    if (fileInput == null)
      return Image(
        image: CachedNetworkImageProvider(imageUrl ?? 'https://i.imgur.com/sUFH1Aq.png'),
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
