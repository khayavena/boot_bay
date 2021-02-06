import 'dart:io';

import 'package:bootbay/src/helpers/theme.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/viewmodel/MediaContentViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditCategoryPage extends StatefulWidget {
  final Category category;

  EditCategoryPage({this.category});

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  MediaContentViewModel _mediaContentViewModel;
  CategoryViewModel _categoryViewModel;
  PickedFile _image;

  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mediaContentViewModel = Provider.of<MediaContentViewModel>(
        context,
        listen: false,
      );
      _categoryViewModel = Provider.of<CategoryViewModel>(
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
        title: Text(widget.category.name),
        backgroundColor: CustomTheme().appBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
                child: Icon(Icons.upload_file),
                onPressed: () async {
                  await _categoryViewModel
                      .saveCategory(widget.category)
                      .then((value) {
                    _mediaContentViewModel.saveFile(_image.path, value.id);
                  });
                }),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            buildEditText(value: widget.category?.name ?? ''),
            Container(
              height: 100,
              child: _image == null
                  ? Text('No Image Showing')
                  : Image.file(File(_image.path)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add_a_photo),
        onPressed: _openImage,
      ),
    );
  }

  Widget buildEditText({String value = ''}) {
    final email = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: categoryController,
      decoration: InputDecoration(
        hintText: 'Add Category',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
      ),
    );
    categoryController.text = value;
    return Container(
      child: email,
    );
  }

  void _openImage() async {
    PickedFile pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = pickedImage;
      setState(() {});
    }
  }
}
