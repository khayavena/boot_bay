import 'package:flutter/material.dart';

class PriceView extends StatelessWidget {
  final String currency;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currency -$amount',
      style: TextStyle(
        color: Color(0xff333333),
        fontSize: 20,
        fontFamily: 'SFProText',
      ),
    );
  }

  const PriceView({
    required this.currency,
    required this.amount,
  });
}
