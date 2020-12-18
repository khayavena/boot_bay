import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/helpers/ResSize.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MerchantManagementCardWidget extends StatefulWidget {
  final Merchant merchant;

  const MerchantManagementCardWidget({Key key, @required this.merchant}) : super(key: key);

  @override
  _MerchantManagementCardWidgetState createState() {
    return _MerchantManagementCardWidgetState();
  }
}

class _MerchantManagementCardWidgetState extends State<MerchantManagementCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).pushNamed(AppRouting.merchantManagementEditOptions, arguments: widget.merchant);
        },
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    return Container(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              widget.merchant.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: largeFontSize,
                fontWeight: largeFont,
              ),
            )),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: CachedNetworkImageProvider(widget.merchant.logoUrl),
          fit: BoxFit.cover,
        )));
  }
}
