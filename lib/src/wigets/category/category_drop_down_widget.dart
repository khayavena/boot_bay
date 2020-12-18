import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CategoryDropDownWidget extends StatefulWidget {
  final Merchant merchant;

  CategoryDropDownWidget({@required this.merchant});

  @override
  _CategoryDropDownWidgetState createState() {
    return _CategoryDropDownWidgetState();
  }
}

class _CategoryDropDownWidgetState extends State<CategoryDropDownWidget> {
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.merchant != null) {
        Provider.of<CategoryViewModel>(context, listen: false).getCategoriesById(widget.merchant.id);
      } else {
        Provider.of<CategoryViewModel>(context, listen: false).getAllCategories();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build("Edit Categories", context),
      body: Container(
        child: Column(
          children: [addCategoryEditCard(), getDropdown()],
        ),
      ),
    );
  }

  Widget getDropdown() {
    return Container(
      child: Consumer<CategoryViewModel>(builder: (BuildContext context, CategoryViewModel value, Widget child) {
        switch (value.loader) {
          case Loader.idl:
          case Loader.complete:
            return dropWidget(value);
          case Loader.busy:
            return ColorLoader4();
          case Loader.error:
            Center(
              child: Text("Add your own cat"),
            );
        }
        return SizedBox();
      }),
    );
  }

  Widget addCategoryEditCard() {
    return Card(
      child: ListTile(
        title: buildEditText(),
        trailing: GestureDetector(
            onTap: () {
              String category = categoryController.text;
            },
            child: Icon(Icons.save)),
      ),
    );
  }

  Widget buildEditText() {
    final email = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: categoryController,
      decoration: InputDecoration(
        hintText: 'Add Category',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    return Container(
      child: email,
    );
  }

  Widget dropWidget(CategoryViewModel value) {
    return Container(
      child: DropdownButton<Category>(
        hint: Text('Select Category'),
        value: value.getCategory,
        onChanged: (Category newValue) {
          value.saveCategory(newValue);
        },
        items: value.getCategories.map<DropdownMenuItem<Category>>((Category category) {
          return DropdownMenuItem<Category>(
            value: category,
            child: Text(category.name ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
