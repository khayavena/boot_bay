import 'dart:io';

import 'package:bootbay/src/viewmodel/MediaContentViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaContentWidget extends StatefulWidget {
  final String id;

  MediaContentWidget({@required this.id});

  @override
  _MediaContentWidgetState createState() => _MediaContentWidgetState();
}

class _MediaContentWidgetState extends State<MediaContentWidget> {
  PickedFile image;

  MediaContentViewModel _mediaContentViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mediaContentViewModel = Provider.of<MediaContentViewModel>(
        context,
        listen: false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
        backgroundColor: Colors.green,
        actions: [
          RaisedButton(
              child: Text('Send'),
              onPressed: () {
                _mediaContentViewModel.saveFile(image.path, widget.id);
              })
        ],
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
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }
}
