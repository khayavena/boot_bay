import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final addAmountController = TextEditingController();

class CurrencyInputField extends StatelessWidget {
  final String symbol;

  final ValueChanged<double> onChanged;

  CurrencyInputField({
    Key key,
    @required this.onChanged,
    @required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(symbol: symbol, decimalDigits: 2);
    return TextFormField(
      onChanged: (String value) {
        if (value != null && value.contains('-')) {
          var val = value.split('-')[1].replaceAll(',', '');
          onChanged(double.parse(val));
        }
      },
      decoration: _buildDecorator(),
      inputFormatters: <TextInputFormatter>[_formatter],
      keyboardType: TextInputType.number,
      maxLength: 18,
    );
  }

  InputDecoration _buildDecorator() {
    return InputDecoration(
      enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
      hintStyle: TextStyle(
        fontFamily: 'Gotham',
        color: Colors.black54,
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
      labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.pink),
      hintText: "Price",
    );
  }
}
