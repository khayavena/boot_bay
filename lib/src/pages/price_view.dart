import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:flutter/material.dart';

class PriceView extends StatelessWidget {
  final String currency;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(
          text: currency + " - ",
          fontSize: 12,
          color: LightColor.red,
        ),
        TitleText(
          text: amount.toString(),
          fontSize: 12,
        ),
      ],
    );
  }

  const PriceView({
    @required this.currency,
    @required this.amount,
  });
}
