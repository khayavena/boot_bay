import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/price_view.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Product product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String image = product.image;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(2)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image(
                      height: 100,
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    )
                  ],
                ),
                SizedBox(height: 10),
                TitleText(
                  text: product.name,
                  fontSize: product.isSelected ? 16 : 14,
                ),
                Text(
                  "Boot Pay",
                ),
                Container(
                    child: Center(
                        child:
                            PriceView(currency: "ZAR", amount: product.price))),
                SizedBox(
                  height: 5,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                      side: BorderSide(color: Colors.orange)),
                  child: Text('add to cat'),
                  color: LightColor.orange,
                )
              ],
            ),
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                    icon: Icon(
                      product.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: product.isLiked
                          ? LightColor.red
                          : LightColor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        product.isLiked = !product.isLiked;
                      });
                    }))
          ],
        ),
      ),
    );
  }
}
