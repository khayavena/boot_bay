import 'package:bootbay/res.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/pages/shopping/cart_list_view.dart';
import 'package:bootbay/src/pages/checkout/checkout_page.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/viewmodel/CartViewModel.dart';
import 'package:bootbay/src/viewmodel/WishListViewModel.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  double price;

  WishListViewModel wishListViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartViewModel>(context, listen: false).getCatItems();
      wishListViewModel = Provider.of<WishListViewModel>(context, listen: false);
    });
    super.initState();
  }

  Widget _price(CartViewModel productViewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleText(
            text: '${productViewModel.cartItems.length} Items',
            color: LightColor.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          TitleText(
            text: 'ZAR - ${productViewModel.roundAmount()}',
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context, CartViewModel productViewModel) {
    return FlatButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutCartPage(
                finalAmount: productViewModel.finalAmount(),
                itemIds: productViewModel.itemIds(),
                currency: productViewModel.currency(),
                merchantId: '5ee3bfbea1fbe46a462d6c4a',
              ),
              // Pass the arguments as part of the RouteSettings. The
              // DetailScreen reads the arguments from these settings.
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .8,
          height: 50,
          decoration: buttonDecorator,
          child: Text(
            'PAY ZAR ${productViewModel.roundAmount()}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w700,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryWhite,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(
            "CART",
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 15,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                'EDIT',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 12,
                  fontFamily: 'SFProText',
                ),
              ),
            )),
          ],
          leading:
              IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {}),
          centerTitle: true,
        ),
        body: Container(
          child: Consumer<CartViewModel>(
            builder: (BuildContext context, CartViewModel productViewModel, Widget child) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    CartListView(cartItems: productViewModel.cartItems),
                    Divider(
                      thickness: 1,
                      height: 70,
                    ),
                    _price(productViewModel),
                    SizedBox(height: 30),
                    _submitButton(context, productViewModel),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
