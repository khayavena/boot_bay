import 'package:flutter/material.dart';

final blueButtonStyle = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        textStyle: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 12,
        )));

inputDecorator({
  final String hint,
}) =>
    InputDecoration(
      enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
      hintStyle: TextStyle(
        fontFamily: 'Gotham',
        color: Colors.black,
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
      labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.black),
      hintText: hint,
    );
