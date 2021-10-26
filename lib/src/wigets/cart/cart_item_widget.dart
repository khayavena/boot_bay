import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/image_helper.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/wigets/cart/cart_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartItemWidget extends StatelessWidget {
  final Product model;

  const CartItemWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCartRow();
  }

  Widget _buildCartRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(left: 8, right: 4),
                height: 204,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(getImageUri(model.id)),
                  ),
                ))),
        Flexible(flex: 1, child: Container(margin: EdgeInsets.only(left: 4, right: 8), child: _leftColumn()))
      ],
    );
  }

  Widget _leftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${model.name.toUpperCase()}\nBOOT PAY",
            style: TextStyle(
              color: primaryBlackColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 12,
        ),
        _categoriesTypes("Size:", "UK 7"),
        SizedBox(
          height: 3,
        ),
        _categoriesTypes("Color:", "Dark Blue"),
        SizedBox(
          height: 3,
        ),
        _categoriesTypes("Quantity:", model.orderQuantity.toString()),
        SizedBox(
          height: 20,
        ),
        Text(
          'ZAR - ${model.price}',
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CartButtonWidget(
          product: model,
          isCartList: true,
        )
      ],
    );
  }

  Widget _categoriesTypes(String name, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Text(
              name,
              style: TextStyle(
                color: Color(0xff999999),
                fontSize: 12,
              ),
            )),
        Expanded(
            flex: 1,
            child: Text(value,
                style: TextStyle(
                  color: primaryBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.8533333333333333,
                )))
      ],
    );
  }
}
