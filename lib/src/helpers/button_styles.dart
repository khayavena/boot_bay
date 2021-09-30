import 'package:flutter/material.dart';

final blueButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return Colors.blue;
    return null; // Defer to the widget's default.
  }),
  foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return Colors.white;
    return null; // Defer to the widget's default.
  }),
);
