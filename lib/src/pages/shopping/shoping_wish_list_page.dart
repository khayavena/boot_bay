import 'package:bootbay/res.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/pages/checkout/checkout_page.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/viewmodel/WishListViewModel.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:bootbay/src/wigets/wish/cart_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ShoppingWishListPage extends StatefulWidget {
  ShoppingWishListPage({Key key}) : super(key: key);

  @override
  _ShoppingWishListPageState createState() => _ShoppingWishListPageState();
}

class _ShoppingWishListPageState extends State<ShoppingWishListPage> {
  double price;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<WishListViewModel>(context, listen: false).getItems();
    });
    super.initState();
  }

  Widget _price(WishListViewModel wishListViewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleText(
            text: '${wishListViewModel.wishItems.length} Items',
            color: LightColor.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          TitleText(
            text: 'ZAR - ${wishListViewModel.finalAmount()}',
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context, WishListViewModel wishListViewViewModel) {
    return FlatButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutCartPage(
                finalAmount: wishListViewViewModel.finalAmount(),
                itemIds: wishListViewViewModel.itemIds(),
                currency: wishListViewViewModel.currency(),
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
            'PAY ZAR ${wishListViewViewModel.finalAmount()}',
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
            "WISH LIST",
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
          child: Consumer<WishListViewModel>(
            builder: (BuildContext context, WishListViewModel productViewModel, Widget child) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    WishListView(wishItems: productViewModel.wishItems),
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
