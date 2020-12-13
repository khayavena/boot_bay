import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/price_view.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/wigets/cart/cart_quantity_button_widget.dart';
import 'package:bootbay/src/wigets/cart/wish_button_widget.dart';
import 'package:bootbay/src/wigets/shared/color_selector_widget.dart';
import 'package:bootbay/src/wigets/shared/size_selector_widget.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Product _product;
  bool isLiked = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              primaryWhite,
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _productImage(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _product.image == null
              ? TitleText(
                  text: "AIP",
                  fontSize: 160,
                  color: LightColor.lightGrey,
                )
              : Container(
                  child: Center(
                  child: AspectRatio(
                      aspectRatio: 1 / 2,
                      child: Image(
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(_product.image),
                      )),
                ))
        ],
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .9,
      initialChildSize: .40,
      minChildSize: .40,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(1),
                topRight: Radius.circular(1),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration:
                        BoxDecoration(color: LightColor.iconColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _product.name,
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 15,
                                  fontFamily: 'SFProText',
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: WishButtonWidget(
                                product: _product,
                              ),
                            )
                          ],
                        ),
                      ),
                      PriceView(currency: "ZAR", amount: _product.price),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                          Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                          Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                          Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                          Icon(Icons.star_border, size: 17),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                _availableSize(),
                SizedBox(
                  height: 12,
                ),
                _availableColor(),
                SizedBox(
                  height: 12,
                ),
                _description(),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Select Quantity',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CartQuantityButtonWidget(product: _product)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 4),
          child: Text(
            'Select Size',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizeSelectorWidget(size: "US 6"),
            SizeSelectorWidget(
              size: "US 7",
            ),
            SizeSelectorWidget(size: "US 8"),
            SizeSelectorWidget(size: "US 9"),
          ],
        )
      ],
    );
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 4),
          child: Text(
            'Select Colour',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ColorSelectorWidget(color: LightColor.yellowColor),
              ColorSelectorWidget(color: LightColor.lightBlue),
              ColorSelectorWidget(color: LightColor.black),
              ColorSelectorWidget(color: LightColor.skyBlue),
            ],
          ),
        )
      ],
    );
  }

  Widget _description() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _product.name,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 12,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: '\n${_product.description}',
            style: TextStyle(
              color: Color(0xff999999),
              fontSize: 12,
              fontFamily: 'SFProText',
            ),
          ),
        ],
      ),
    );
  }
}
