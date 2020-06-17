import 'package:bootbay/src/pages/cart_list_view.dart';
import 'package:bootbay/src/pages/checkout_page.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/viewmodel/ProductViewModel.dart';
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

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).getCatItems();
    });
    super.initState();
  }

  Widget _price(ProductViewModel productViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${productViewModel.cartItems.length} Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: 'ZAR - ${productViewModel.finalAmount()}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _submitButton(
      BuildContext context, ProductViewModel productViewModel) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        color: LightColor.skyBlue,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .8,
          child: TitleText(
            text: 'PAY NOW',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: Consumer<ProductViewModel>(
        builder: (BuildContext context, ProductViewModel productViewModel,
            Widget child) {
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
    );
  }
}
