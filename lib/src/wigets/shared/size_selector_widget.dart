import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:flutter/material.dart';

class SizeSelectorWidget extends StatelessWidget {
  final String size;

  SizeSelectorWidget({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      width: 70,
      height: 32,
      child: Container(
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'SFProText',
              ),
            ),
          ),
          height: 22,
          margin: EdgeInsets.all(4)),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectorBackgroundColor,
          width: 1,
        ),
      ),
    );
  }
}
