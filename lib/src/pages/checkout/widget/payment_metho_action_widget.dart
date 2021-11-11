import 'package:flutter/material.dart';

class SelectPayMethodRow extends StatelessWidget {
  final String title;

  const SelectPayMethodRow({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(4),
        leading: Icon(
          Icons.account_balance_wallet_rounded,
          color: Color(0xff2783a9),
          size: 54.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff2783a9),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.8000000000000003,
          ),
        ),
        subtitle: Text(
          title,
          style: TextStyle(
            color: Color(0xff2783a9),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.8000000000000003,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          color: Colors.blue,
          size: 24.0,
        ),
      ),
    );
  }
}
