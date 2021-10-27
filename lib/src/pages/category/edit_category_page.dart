import 'dart:io';

import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/helpers/image_helper.dart';
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

class EditCategoryPage extends StatefulWidget {
  final Category category;
  final Merchant merchant;

  EditCategoryPage({this.category, this.merchant});

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  MediaContentViewModel _mediaContentViewModel;
  CategoryViewModel _categoryViewModel;
  ImageProviderViewModel _categoryMediaViewModel;

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
      _categoryMediaViewModel = Provider.of<ImageProviderViewModel>(
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
          title: widget.category?.name?.toUpperCase() ?? widget.merchant.name,
          headerIcon: getImageUri(widget.category?.id ?? widget.merchant.id),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildActions(),
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

  Future<void> _showInputDialog(String parentId, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // repository must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Consumer<MediaContentViewModel>(
                builder: (BuildContext context, MediaContentViewModel value, Widget child) {
              if (value.status == Loader.busy) {
                return WidgetLoader();
              }
              return createAlertBody(parentId, title);
            }),
          ),
          actions: <Widget>[
            _buildApproveButton(parentId),
          ],
        );
      },
    );
  }

  TextButton _buildApproveButton(String parentId) {
    return TextButton(
      child: Text('Approve'),
      onPressed: () async {
        Category category;
        if (parentId != null) {
          category =
              Category(parentId: parentId, name: categoryController.text.toString(), merchantId: widget.merchant.id);
        } else {
          category = widget.category;
          category.name = categoryController.text.toString();
        }
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

  Widget createAlertBody(String parentId, String title) {
    return ListBody(
      children: <Widget>[
        GestureDetector(
          onTap: () => _categoryMediaViewModel.openGalleryForImage(),
          child: Container(
            height: 300,
            color: Colors.black26,
            child: Consumer<ImageProviderViewModel>(
                builder: (BuildContext context, ImageProviderViewModel value, Widget child) {
              return value.fileInput == null ? _buildAttach() : _buildFileImage(value);
            }),
          ),
        ),
        buildEditText(value: widget.category.name),
      ],
    );
  }

  Widget _buildFileImage(ImageProviderViewModel value) {
    return Image.file(
      File(
        value.fileInput.path,
      ),
      fit: BoxFit.contain,
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.category.hasChildren
              ? SizedBox()
              : ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouting.addProduct,
                        arguments: {"category": widget.category, "merchant": widget.merchant});
                  },
                  child: Text('Add Item'),
                ),
          _padHorizontal(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouting.addCategory, arguments: widget.merchant);
            },
            child: Text('New Class'),
          ),
          _padHorizontal(),
          ElevatedButton(
            onPressed: () {
              _showInputDialog(widget.category.id, "Add Sub Class");
            },
            child: Text('Sub Class'),
          ),
          _padHorizontal(),
          ElevatedButton(
            onPressed: () {
              _showInputDialog(null, "Edit Class");
            },
            child: Text("Edit Class"),
          ),
          _padHorizontal(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouting.editCategoryProductPage, arguments: widget.category);
            },
            child: Text("Manage Items"),
          )
        ],
      ),
    );
  }

  Padding _padHorizontal() {
    return Padding(padding: EdgeInsets.only(right: 8));
  }
}
