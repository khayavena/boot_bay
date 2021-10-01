import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:flutter/material.dart';

class CategoryCardLoader extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: AppTheme.hPadding,
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        color: Colors.white70,
        border: Border.all(color: LightColor.grey, width: .1),
      ),
    );
  }
}
