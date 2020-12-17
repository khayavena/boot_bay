import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaContentWidget extends StatefulWidget {
  final String id;

  MediaContentWidget({@required this.id});

  @override
  _MediaContentWidgetState createState() => _MediaContentWidgetState();
}

class _MediaContentWidgetState extends State<MediaContentWidget> {
  PickedFile image; //connect camera

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Connect'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          child: image == null ? Text('No Image Showing') : Image.file(File(image.path)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_a_photo),
        onPressed: openImage,
      ),
    );
  }

  void openImage() async {
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }
}
