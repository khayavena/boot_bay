import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/helpers/ResSize.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/wigets/cart/cart_button_widget.dart';
import 'package:bootbay/src/wigets/cart/wish_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isEdit;

  ProductCard({Key key, this.product, this.isEdit = false}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Product product;
  bool toggle;

  @override
  void initState() {
    product = widget.product;
    toggle = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouting.productDetail, arguments: product);
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            _buildColumn(),
            _buildSaleWidget(),
            Align(alignment: Alignment.bottomRight, child: CartButtonWidget(key: Key(product.id), product: product)),
            Align(
              alignment: Alignment.topRight,
              child: WishButtonWidget(
                product: product,
              ),
            ),
            widget.isEdit
                ? Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRouting.editProductPage, arguments: product);
                      },
                      child: Text('Edit'),
                    ),
                  )
                : SizedBox()
          ],
        ),
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
          image: CachedNetworkImageProvider(getImageUri(product.id)),
        ),
        SizedBox(
          height: 8,
        ),
        Text('${product.name.toUpperCase()}\nBOOT PAY',
            style: TextStyle(
              color: primaryBlackColor,
              fontSize: 12,
              fontWeight: largeFont,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.6400000000000001,
            )),
        SizedBox(
          height: 16,
        ),
        Text("ZAR - ${product.price}",
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.8000000000000003,
            ))
      ],
    );
  }

  Widget _buildSaleWidget() {
    return Container(
      alignment: Alignment.topLeft,
      child: Center(
        child: Text(
          'SALE',
          style: TextStyle(
            color: Colors.white,
            fontSize: midFontSize,
            fontWeight: largeFont,
          ),
        ),
      ),
      width: 45,
      height: 28,
      margin: EdgeInsets.only(
        top: 15,
      ),
      decoration: BoxDecoration(
        color: primaryRedColor,
      ),
    );
  }
}
