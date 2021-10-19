import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/category/widget/category_entry_item_widget.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../res.dart';

class MerchantCategoryListPage extends StatefulWidget {
  final Merchant merchant;

  MerchantCategoryListPage({@required this.merchant});

  @override
  _MerchantCategoryListPageState createState() {
    return _MerchantCategoryListPageState();
  }
}

class _MerchantCategoryListPageState extends State<MerchantCategoryListPage> {
  final TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.merchant != null) {
        Provider.of<CategoryViewModel>(context, listen: false).getCategoriesById(widget.merchant.id);
      } else {
        Provider.of<CategoryViewModel>(context, listen: false).getAllCategories();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor().appBackground,
      body: buildCollapsingWidget(
          bodyWidget: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150, height: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouting.addProduct, arguments: {"merchant": widget.merchant});
                          },
                          child: Text('Add Item'),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150, height: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouting.addCategory, arguments: widget.merchant);
                          },
                          child: Text('Add Classification'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildBody(),
                )
              ],
            ),
          ),
          actions: [
            IconButton(icon: ImageIcon(AssetImage(Res.search_ic)), color: primaryBlackColor, onPressed: () {}),
            IconButton(
                icon: ImageIcon(AssetImage(Res.cart_ic)),
                color: primaryBlackColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouting.cartList);
                })
          ],
          title: widget.merchant?.name ?? '',
          headerIcon: getImageUri(widget.merchant.id),
          backButton:
              IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {})),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Consumer<CategoryViewModel>(builder: (BuildContext context, CategoryViewModel value, Widget child) {
        switch (value.loader) {
          case Loader.idl:
          case Loader.complete:
            return _buildCategories(value);
          case Loader.busy:
            return WidgetLoader();
          case Loader.error:
            Center(
              child: Text("Something went wrong"),
            );
        }
        return SizedBox();
      }),
    );
  }

  Widget _buildCategories(CategoryViewModel value) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      separatorBuilder: (context, index) => getAppDivider(),
      itemCount: value.getCategories.length,
      itemBuilder: (context, index) => CategoryEntryItemWidget(value.getCategories[index], widget.merchant),
    );
  }
}
