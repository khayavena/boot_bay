import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/model/merchant.dart';
import 'package:flutter/material.dart';

class MerchantCardWidget extends StatefulWidget {
  final Merchant merchant;

  const MerchantCardWidget({Key key, @required this.merchant}) : super(key: key);

  @override
  _MerchantCardWidgetState createState() {
    return _MerchantCardWidgetState();
  }
}

class _MerchantCardWidgetState extends State<MerchantCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).pushNamed(AppRouting.merchantLanding, arguments: widget.merchant);
        },
        child: Container(
          width: 300,
          height: 100,
          child: Center(child: Text(widget.merchant.name)),
        ),
      ),
    );
  }
}
