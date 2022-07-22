import 'package:bootbay/src/model/category.dart';
import 'package:flutter/material.dart';

class CategoryDropDownWidget<T> extends StatefulWidget {
  final List<Category> categories;
  final Function(Category?) onCategoryChanged;

  CategoryDropDownWidget(
      {Key? key, required this.categories, required this.onCategoryChanged})
      : super(key: key);

  @override
  _CategoryDropDownWidgetState createState() =>
      new _CategoryDropDownWidgetState();
}

class _CategoryDropDownWidgetState extends State<CategoryDropDownWidget> {
  late Category? _selectedCategory;

  @override
  void initState() {
    _selectedCategory = widget.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: new DropdownButton<Category>(
        hint: new Text("Select Classification"),
        value: _selectedCategory,
        isDense: true,
        onChanged: (Category? newValue) {
          widget.onCategoryChanged(newValue);
          setState(() {
            _selectedCategory = newValue;
          });
        },
        items: widget.categories.map((Category category) {
          return new DropdownMenuItem<Category>(
            value: category,
            child: new Text(category.name,
                style: new TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }
}
