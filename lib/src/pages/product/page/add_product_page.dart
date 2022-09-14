import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/helpers/widget_styles.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:bootbay/src/wigets/currency_input_field.dart';
import 'package:bootbay/src/wigets/shared/custom_drop_down.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../helpers/ResText.dart';
import '../widget/product_success_widget.dart';

final name = TextEditingController();
final description = TextEditingController();
final price = TextEditingController();

DateTime now = DateTime.now();

class AddProductPage extends StatefulWidget {
  final Merchant merchant;
  final Category? category;

  AddProductPage({Key? key, required this.merchant, required this.category})
      : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late ProductViewModel _productViewModel;
  late double finalAmount;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryViewModel>(
        context,
        listen: false,
      ).getCategoriesById(widget.merchant.id ?? '');
      _productViewModel = Provider.of<ProductViewModel>(
        context,
        listen: false,
      );
    });
    super.initState();
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
          widget.merchant.name.toUpperCase(),
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
      body: Consumer<ProductViewModel>(builder: (BuildContext context,
          ProductViewModel productViewModel, Widget? child) {
        return _buildBody(productViewModel);
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
            if (categoryViewModel.getCategories.isNotEmpty) {
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
    clear();
    super.dispose();
  }

  Widget _buildBody(ProductViewModel vm) {
    switch (vm.loader) {
      case Loader.error:
        return Center(child: Text("Failed to add"));
      case Loader.busy:
        return WidgetLoader();
      case Loader.complete:
        return ProductSuccessWidget(vm: vm);
      case Loader.idl:
        return _buildFormWidget(vm: vm);
    }
  }

  Widget _buildFormWidget({required ProductViewModel vm}) {
    return ListView(
      children: [
        _buildDropDown(),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
            controller: name,
            style: TextStyle(color: Colors.black, fontFamily: fontStyle()),
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
                  TextStyle(fontFamily: fontStyle(), color: Colors.black),
              hintText: 'Item Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
            maxLines: 100 ~/ 15,
            controller: description,
            style: TextStyle(color: Colors.black, fontFamily: fontStyle()),
            decoration: inputDecorator(hint: 'Description'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: CurrencyInputField(
            onChanged: _onAmountChange,
            symbol: "R-",
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () async {
              await vm.saveRemoteProduct(
                  widget.merchant.id ?? '',
                  name.text.toString(),
                  description.text.toString(),
                  finalAmount);
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
}

void clear() {
  name.clear();
  description.clear();
  price.clear();
}
