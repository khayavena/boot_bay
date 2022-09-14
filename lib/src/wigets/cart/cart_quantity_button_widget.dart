import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CartQuantityButtonWidget extends StatefulWidget {
  final Product product;

  CartQuantityButtonWidget({Key? key, required this.product}) : super(key: key);

  @override
  _CartQuantityButtonWidgetState createState() =>
      _CartQuantityButtonWidgetState();
}

class _CartQuantityButtonWidgetState extends State<CartQuantityButtonWidget> {
  late CartViewModel _cartViewModel;

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
    return Container(
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffdfdfdf),
            width: 1,
          ),
        ),
        child: Consumer<CartViewModel>(
            key: Key(widget.product.id ?? ''),
            builder: (BuildContext context, CartViewModel cartViewModel,
                Widget? child) {
              return GestureDetector(
                // onTap: () {
                //   cartViewModel.cartAction(widget.product);
                // }
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      width: 25,
                      height: 25,
                      margin: EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: Color(0xffd8d8d8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      widget.product.orderQuantity.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'SFProText',
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 24),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xffd8d8d8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
