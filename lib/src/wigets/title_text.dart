import 'package:bootbay/src/helpers/ResText.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const TitleText(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.color = LightColor.titleTextColor,
      this.fontWeight = FontWeight.w600})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize)
    );
  }
}
