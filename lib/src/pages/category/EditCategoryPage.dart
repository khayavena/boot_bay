import 'dart:io';

import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/viewmodel/MediaContentViewModel.dart';
import 'package:bootbay/src/wigets/category/category_list_only_widget.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../res.dart';

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
  PickedFile _image2;

  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();

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
          title: widget.category?.name?.toUpperCase() ?? widget.merchant.name,
          headerIcon: baseUrl + '/media/content/${widget.category?.id ?? widget.merchant.id}',
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

  Widget buildSubEditText({String value = ''}) {
    final inputField = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: subCategoryController,
    );
    subCategoryController.text = value;
    return Container(
      child: inputField,
    );
  }

  void _openImage2() async {
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image2 = pickedImage;
      setState(() {});
    }
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) return Colors.blue;
                    return null; // Defer to the widget's default.
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) return Colors.white;
                    return null; // Defer to the widget's default.
                  }),
                ),
                onPressed: () {
                  _showEditDialog(widget.category.id, "Add Sub Item");
                },
                child: Text('Add sub item'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) return Colors.blue;
                    return null; // Defer to the widget's default.
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) return Colors.white;
                    return null; // Defer to the widget's default.
                  }),
                ),
                onPressed: () {
                  _showEditDialog(null, "Edit Item");
                },
                child: Text('Edit item'),
              )
            ],
          ),
          Expanded(
            child: CategoryListOnlyWidget(
              merchant: widget.merchant,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showEditDialog(String parentId, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _openImage2(),
                  child: _image2 == null
                      ? _buildAttach()
                      : Image.file(
                          File(
                            _image2.path,
                          ),
                          width: 50,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                ),
                buildEditText(value: widget.category.name),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () async {
                Category category;
                if (parentId != null) {
                  category =
                      Category(parentId: parentId, name: subCategoryController.text, merchantId: widget.merchant.id);
                } else {
                  widget.category.name = subCategoryController.text.toString();
                  category = widget.category;
                }
                await _categoryViewModel.saveCategory(category).then((value) {
                  if (_image2 != null && _image2.path.isNotEmpty) {
                    _mediaContentViewModel.saveCategoryFile(_image2.path, value.id);
                  }
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
