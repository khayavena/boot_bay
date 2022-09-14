import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final Category model;
  final ClickCategory clickCategory;

  CategoryCard({Key? key, required this.model, required this.clickCategory})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.clickCategory.onClick(widget.model);
        setState(() {
          widget.model.isSelected = !widget.model.isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: Container(
          child: Text(
            widget.model.name.toUpperCase(),
            style: TextStyle(
              color: widget.model.isSelected
                  ? primaryBlackColor
                  : Color(0xff999999),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

abstract class ClickCategory {
  void onClick(Category category);
}
