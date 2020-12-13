import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/helpers/ResSize.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/viewmodel/CartViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CartButtonWidget extends StatefulWidget {
  final Product product;
  final bool isDetail;
  static String _addToCart = 'Add to cart';
  static String _removeItem = 'Remove Item';

  CartButtonWidget({Key key, @required this.product, this.isDetail = false}) : super(key: key);

  @override
  _CartButtonWidgetState createState() => _CartButtonWidgetState();
}

class _CartButtonWidgetState extends State<CartButtonWidget> {
  CartViewModel _cartViewModel;
  var label = CartButtonWidget._addToCart;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _cartViewModel = Provider.of<CartViewModel>(context, listen: false);
      _cartViewModel.checkExist(widget.product);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCartWidget();
  }

  Widget _buildCartWidget() {
    return Consumer<CartViewModel>(
        key: Key(widget.product.id),
        builder: (BuildContext context, CartViewModel cartViewModel, Widget child) {
          if (widget.product.id == cartViewModel.currentId) {
            if (cartViewModel.isItemExist) {
              label = CartButtonWidget._removeItem;
            } else {
              label = CartButtonWidget._addToCart;
            }
          }

          return GestureDetector(
            onTap: () {
              cartViewModel.cartAction(widget.product);
            },
            child: widget.isDetail
                ? bigButton()
                : Container(
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: smallFontSize,
                          fontWeight: smallFont,
                        ),
                      ),
                    ),
                    width: 60,
                    height: 28,
                    decoration: smallButtonDecorator,
                  ),
          );
        });
  }

  Widget bigButton() {
    return Container(
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: largeFontSize,
            fontWeight: largeFont,
          ),
        ),
      ),
      height: 50,
      decoration: buttonDecorator,
    );
  }
}
