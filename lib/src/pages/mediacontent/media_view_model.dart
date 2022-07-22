import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderViewModel extends ChangeNotifier {
  late XFile _fileInput;

  XFile get fileInput => _fileInput;

  void openGalleryForImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _fileInput = pickedImage;
      notifyListeners();
    }
  }

  void clear() {}

  Widget proverFileImageView(
      {String imageUrl = 'https://i.imgur.com/sUFH1Aq.png'}) {
    if (fileInput.path.isNotEmpty)
      return Image(
        image: CachedNetworkImageProvider(imageUrl),
      );
    return Image.file(
      File(
        fileInput.path,
      ),
      fit: BoxFit.contain,
    );
  }

  String get path => _fileInput.path;

  bool get isValidImage => path.isNotEmpty;
}
