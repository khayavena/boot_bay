import 'dart:io';

import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/viewmodel/MediaContentViewModel.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../res.dart';

class AddNewCategoryPage extends StatefulWidget {
  final Merchant merchant;

  AddNewCategoryPage({this.merchant});

  @override
  _AddNewCategoryPageState createState() => _AddNewCategoryPageState();
}

class _AddNewCategoryPageState extends State<AddNewCategoryPage> {
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
      backgroundColor: CustomColor().appBackground,
      body: buildCollapsingWidget(
          bodyWidget: _buildBody(),
          actions: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GestureDetector(
                  child: Icon(
                    Icons.done,
                    color: CustomColor().green,
                  ),
                  onTap: () async {
                    Category cat = Category(merchantId: widget.merchant.id, name: categoryController.text);

                    await _categoryViewModel.saveCategory(cat).then((value) {
                      _mediaContentViewModel.saveFile(_image.path, value.id);
                    });
                  }),
            )
          ],
          title: widget.merchant.name,
          headerIcon: getImageUri(widget.merchant.id),
          backButton:
              IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {})),
    );
  }

  Widget buildEditText({String value = ''}) {
    final email = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: categoryController,
      decoration: InputDecoration(
        helperMaxLines: 1,
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
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = pickedImage;
      setState(() {});
    }
  }

  Widget _buildAttach() {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(top: 16),
          width: 100,
          height: 100,
          child: Icon(
            Icons.add_a_photo,
            color: CustomColor().darkBlue,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: const Color(0x7b999999), offset: Offset(1, 2), blurRadius: 4, spreadRadius: 0)
              ],
              color: Colors.white)),
      onTap: () {
        _openImage();
      },
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16, top: 24),
            child: buildEditText(value: ''),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, left: 16, top: 24),
            width: double.maxFinite,
            color: CustomColor().appBackground,
            height: 300,
            child: _image == null
                ? Padding(padding: EdgeInsets.all(100), child: _buildAttach())
                : Image.file(File(_image.path)),
          ),
          _image != null ? _buildAttach() : SizedBox()
        ],
      ),
    );
  }
}
