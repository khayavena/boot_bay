import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/helpers/ResSize.dart';
import 'package:flutter/cupertino.dart';

Text smallText(Color color, String text) => Text(text,
    style: TextStyle(
      fontFamily: 'AvenirNext',
      color: color,
      fontSize: smallFontSize,
      fontWeight: mediumFont,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    ),);

String fontStyle() => fontStyle();
