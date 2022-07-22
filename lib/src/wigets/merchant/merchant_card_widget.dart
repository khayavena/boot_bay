import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/helpers/image_helper.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MerchantCardWidget extends StatefulWidget {
  final Merchant merchant;

  const MerchantCardWidget({Key? key, required this.merchant})
      : super(key: key);

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
          Navigator.of(context).pushNamed(AppRouting.merchantLanding,
              arguments: widget.merchant);
        },
        child: _buildColumn(),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          width: 166,
          height: 204,
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(getImageUri(widget.merchant.id)),
        ),
        SizedBox(
          height: 8,
        ),
        Text('${widget.merchant.name.toUpperCase()}',
            style: TextStyle(
              color: primaryBlackColor,
              fontSize: 12,
              fontWeight: largeFont,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.6400000000000001,
            )),
        SizedBox(
          height: 8,
        ),
        Text(
          "${widget.merchant.location}",
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.8000000000000003,
          ),
        )
      ],
    );
  }
}
