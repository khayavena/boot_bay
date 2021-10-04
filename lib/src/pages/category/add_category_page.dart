import 'dart:io';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/button_styles.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/category/widget/category_list_widget.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../res.dart';
import '../mediacontent/media_view_model.dart';

class AddCategoryPage extends StatefulWidget {
  final Merchant merchant;

  AddCategoryPage({this.merchant});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  MediaContentViewModel _mediaContentViewModel;
  CategoryViewModel _categoryViewModel;
  MediaViewModel _categoryMediaViewModel;

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

      _categoryMediaViewModel = Provider.of<MediaViewModel>(
        context,
        listen: false,
      );
      _showInputDialog("Add Category");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor().appBackground,
      body: buildCollapsingWidget(
          bodyWidget: _buildBody(),
          title: widget.merchant.name,
          headerIcon: getImageUri(widget.merchant.id),
          backButton:
              IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {})),
    );
  }

  Widget buildEditText({String value = ''}) {
    final inputField = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: categoryController,
    );
    categoryController.text = value;
    return Container(
      child: inputField,
    );
  }

  Widget _buildAttach() {
    return Container(
        child: Icon(
          Icons.add_a_photo,
          color: CustomColor().darkBlue,
          size: 56,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: const Color(0x7b999999), offset: Offset(1, 2), blurRadius: 4, spreadRadius: 0)
        ], color: Colors.white));
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: blueButtonStyle,
                onPressed: () {
                  _showInputDialog("Add Category");
                },
                child: Text('Add Item'),
              ),
            ],
          ),
          Expanded(
            child: CategoryListWidget(
              merchant: widget.merchant,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showInputDialog(String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Consumer<MediaContentViewModel>(
                builder: (BuildContext context, MediaContentViewModel value, Widget child) {
              if (value.status == Loader.busy) {
                return WidgetLoader();
              }
              return createAlertBody(title);
            }),
          ),
          actions: <Widget>[
            _buildApproveButton(),
          ],
        );
      },
    );
  }

  TextButton _buildApproveButton() {
    return TextButton(
      child: Text('Approve'),
      onPressed: () async {
        var category = Category(name: categoryController.text.toString(), merchantId: widget.merchant.id);
        var categoryResponse = await _categoryViewModel.saveCategory(category);
        if (_categoryMediaViewModel.fileInput != null && _categoryMediaViewModel.fileInput.path.isNotEmpty) {
          var catImageResponse = await _mediaContentViewModel.saveCategoryFile(
              _categoryMediaViewModel.fileInput.path, categoryResponse.id);
        }
        _categoryMediaViewModel.clear();
        _mediaContentViewModel.clear();
        Navigator.of(context).pop();
      },
    );
  }

  Widget createAlertBody(String title) {
    return ListBody(
      children: <Widget>[
        GestureDetector(
          onTap: () => _categoryMediaViewModel.openGalleryForImage(),
          child: Container(
            height: 300,
            color: Colors.black26,
            child: Consumer<MediaViewModel>(
                builder: (BuildContext context, MediaViewModel value, Widget child) {
              return value.fileInput == null ? _buildAttach() : _buildFileImage(value);
            }),
          ),
        ),
        buildEditText(value: ''),
      ],
    );
  }

  Widget _buildFileImage(MediaViewModel value) {
    return Image.file(
      File(
        value.fileInput.path,
      ),
      fit: BoxFit.contain,
    );
  }
}
