import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:flutter/material.dart';

class ColorSelectorWidget extends StatelessWidget {
  final Color color;

  ColorSelectorWidget({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      width: 70,
      height: 32,
      child: Container(color: this.color, height: 22, margin: EdgeInsets.all(4)),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectorBackgroundColor,
          width: 1,
        ),
      ),
    );
  }
}
