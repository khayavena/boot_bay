import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/helpers/image_helper.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_view_model.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:bootbay/src/wigets/currency_input_field.dart';
import 'package:bootbay/src/wigets/shared/custom_drop_down.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../helpers/ResText.dart';

final name = TextEditingController();
final description = TextEditingController();

DateTime now = DateTime.now();

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late MediaViewModel _mediaContentViewModel;
  late CategoryViewModel _categoryViewModel;
  late ImageProviderViewModel _mediaViewModel;
  late ProductViewModel _productViewModel;
  late double finalAmount;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mediaContentViewModel = Provider.of<MediaViewModel>(
        context,
        listen: false,
      );
      _categoryViewModel = Provider.of<CategoryViewModel>(
        context,
        listen: false,
      );
      _mediaViewModel = Provider.of<ImageProviderViewModel>(
        context,
        listen: false,
      );
      _productViewModel = Provider.of<ProductViewModel>(
        context,
        listen: false,
      );

      _categoryViewModel.getCategoriesById(widget.product.merchantId ?? "");
    });
    initData();
    super.initState();
  }

  uploadImage() async {
    _mediaViewModel.openGalleryForImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor().pureWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: CustomColor().black),
        backgroundColor: CustomColor().pureWhite,
        elevation: 0,
        title: Text(
          "Edit product",
          style: TextStyle(fontFamily: fontStyle(), color: CustomColor().black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.cancel, color: CustomColor().black),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Consumer2<MediaViewModel, ProductViewModel>(builder:
          (BuildContext context, MediaViewModel value,
              ProductViewModel productViewModel, Widget? child) {
        if (value.status == Loader.busy ||
            productViewModel.loader == Loader.busy) {
          return WidgetLoader();
        }
        return _buildBody();
      }),
    );
  }

  Widget _buildDropDown() {
    return Consumer<CategoryViewModel>(
      builder: (BuildContext context, CategoryViewModel categoryViewModel,
          Widget? child) {
        switch (categoryViewModel.loader) {
          case Loader.error:
          case Loader.busy:
          case Loader.idl:
            return SizedBox();
          case Loader.complete:
            if (_categoryViewModel.getCategories.isNotEmpty) {
              return DynamicDropdownWidget(
                dropdownMenuItemList: _buildCategoryDropDownItems(
                    categoryViewModel.getCategories),
                onChanged: onSelectedCategory,
                value: categoryViewModel.getCategories[0],
                hint: 'Select Classification',
              );
            } else {
              return SizedBox();
            }
        }
      },
    );
  }

  List<DropdownMenuItem<Category>> _buildCategoryDropDownItems(
      List<Category> categories) {
    List<DropdownMenuItem<Category>> items = [];
    for (Category favouriteFoodModel in categories) {
      items.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(favouriteFoodModel.name),
      ));
    }
    return items;
  }

  void onSelectedCategory(final Object category) {
    _productViewModel.setSelectedCategory(category as Category);
  }

  void _onAmountChange(final double value) {
    this.finalAmount = value;
  }

  @override
  void dispose() {
    _mediaViewModel.clear();
    clear();
    super.dispose();
  }

  Widget _buildBody() {
    return ListView(
      children: [
        _buildDropDown(),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
            controller: name,
            style: TextStyle(color: Colors.black87, fontFamily: fontStyle()),
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54)),
              hintStyle: TextStyle(
                fontFamily: fontStyle(),
                color: Colors.black54,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
              labelStyle:
                  TextStyle(fontFamily: fontStyle(), color: Colors.black87),
              hintText: 'Item Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
            maxLines: 100 ~/ 15,
            controller: description,
            style: TextStyle(color: Colors.black87, fontFamily: fontStyle()),
            decoration: new InputDecoration(
              enabledBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54)),
              hintStyle: TextStyle(
                fontFamily: fontStyle(),
                color: Colors.black54,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
              labelStyle:
                  TextStyle(fontFamily: fontStyle(), color: Colors.black87),
              hintText: 'Description',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: CurrencyInputField(
            initVue: widget.product.price,
            onChanged: _onAmountChange,
            symbol: "R-",
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Add an image".toUpperCase(),
              style: TextStyle(
                  fontFamily: fontStyle(),
                  color: Color(0xff2783a9),
                  fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<ImageProviderViewModel>(builder:
              (BuildContext context, ImageProviderViewModel value,
                  Widget? child) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: value.proverFileImageView(
                  imageUrl: getImageUri(widget.product.id ?? '')),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: Text(
                "Upload".toUpperCase(),
                style: TextStyle(
                  fontFamily: fontStyle(),
                ),
              )),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () async {
              widget.product.name = name.text.toString();
              widget.product.description = description.text.toString();
              widget.product.price = finalAmount;
              await _productViewModel
                  .editRemoteProduct(widget.product)
                  .then((value) {
                if (_mediaViewModel.isValidImage) {
                  _mediaContentViewModel.saveImage(
                      _mediaViewModel.path, value.id ?? '', "product");
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Submit".toUpperCase(),
                      style: TextStyle(
                          fontFamily: fontStyle(), color: CustomColor().black)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void initData() {
    name.text = widget.product.name;
    description.text = widget.product.description;
  }
}

void clear() {
  name.clear();
  description.clear();
}
