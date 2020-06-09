import 'package:flutter/material.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/wigets/title_text.dart';

class CategoryCard extends StatefulWidget {
  // final String imagePath;
  // final String text;
  // final bool isSelected;
  final Category model;
  final ClickCategory clickCategory;

  CategoryCard({Key key, this.model, this.clickCategory}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  Widget build(BuildContext context) {
    return widget.model.id == null
        ? Container(
            width: 5,
          )
        : GestureDetector(
            onTap: () {
              if (widget.clickCategory != null) {
                widget.clickCategory.onClick(widget.model);
                setState(() {
                  widget.model.isSelected = !widget.model.isSelected;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: AppTheme.hPadding,
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: widget.model.isSelected
                    ? LightColor.background
                    : Colors.transparent,
                border: Border.all(
                    color: widget.model.isSelected
                        ? LightColor.orange
                        : LightColor.grey,
                    width: widget.model.isSelected ? 2 : 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: widget.model.isSelected
                          ? Color(0xfffbf2ef)
                          : Colors.white,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(5, 5)),
                ],
              ),
              child: Row(
                children: <Widget>[
                  widget.model.image != null
                      ? Image.asset(widget.model.image)
                      : SizedBox(),
                  widget.model.name == null
                      ? Container()
                      : Container(
                          child: TitleText(
                            text: widget.model.name,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        )
                ],
              ),
            ),
          );
  }
}

abstract class ClickCategory {
  void onClick(Category category);
}
