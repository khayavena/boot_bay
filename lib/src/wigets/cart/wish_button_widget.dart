import 'package:bootbay/res.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/wish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class WishButtonWidget extends StatefulWidget {
  final Product product;

  WishButtonWidget({Key? key, required this.product}) : super(key: key);

  @override
  _WishButtonWidgetState createState() => _WishButtonWidgetState();
}

class _WishButtonWidgetState extends State<WishButtonWidget> {
  var icon = Res.wish_inactive_ic;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<WishListViewModel>(context, listen: false)
          .checkExist(widget.product);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCartWidget();
  }

  Widget _buildCartWidget() {
    return Consumer<WishListViewModel>(
        key: Key(widget.product.id ?? ''),
        builder: (BuildContext context, WishListViewModel wishViewModel,
            Widget? child) {
          if (widget.product.id == wishViewModel.currentId) {
            if (wishViewModel.isItemExist) {
              icon = Res.wish_active_ic;
            } else {
              icon = Res.wish_inactive_ic;
            }
          }

          return Container(
              child: IconButton(
                  icon: ImageIcon(AssetImage(icon)),
                  color: primaryRedColor,
                  onPressed: () {
                    wishViewModel.wishListAction(widget.product);
                  }));
        });
  }
}
