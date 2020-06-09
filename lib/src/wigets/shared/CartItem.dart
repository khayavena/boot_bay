import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/price_view.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:flutter/material.dart';

import '../title_text.dart';

class CartItem extends StatelessWidget {
  final Product model;

  const CartItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _item();
  }

  Widget _item() {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(model.image
                                      .replaceAll('localhost', '10.0.2.2')),
                                ),
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListTile(
                  title: TitleText(
                    text: model.name,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: PriceView(currency: "ZAR", amount: model.price),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(2)),
                    child: TitleText(
                      text: 'x${'1'}',
                      fontSize: 12,
                    ),
                  )))
        ],
      ),
    );
  }
}
