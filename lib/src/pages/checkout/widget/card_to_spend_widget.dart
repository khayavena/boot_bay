import 'package:bootbay/src/helpers/string_formaters.dart';
import 'package:flutter/material.dart';

class CardToSpend extends StatelessWidget {
  final double leftToSpend;
  final String currency;

  const CardToSpend({Key key, this.leftToSpend, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        side: BorderSide(color:  Color(0xff2783a9)),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),

      ),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                child: Text(valueWithCurrency(leftToSpend, currency, true),
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.8000000000000003,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
