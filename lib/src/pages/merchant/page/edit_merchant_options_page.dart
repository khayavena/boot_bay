import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EditMerchantManagementOptionsWidget extends StatefulWidget {
  final Merchant merchant;

  EditMerchantManagementOptionsWidget({required this.merchant});

  @override
  _EditMerchantManagementOptionsWidgetState createState() {
    return _EditMerchantManagementOptionsWidgetState();
  }
}

class _EditMerchantManagementOptionsWidgetState
    extends State<EditMerchantManagementOptionsWidget> {
  Widget _buildOptions() {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / .6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        padding: EdgeInsets.only(left: 8, right: 8, top: 16),
        scrollDirection: Axis.vertical,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    AppRouting.merchantsManagementEdit,
                    arguments: widget.merchant);
              },
              child: getItem("Edit Merchant", Icons.add_business_outlined)),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.merchantCategoryList,
                    arguments: widget.merchant);
              },
              child: getItem("Categories", Icons.category_outlined)),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Revenue", Icons.money)),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Add Staff", Icons.wc_outlined)),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Orders", Icons.delivery_dining))
        ]);
  }

  Widget getItem(String s, IconData iconData) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData),
            SizedBox(
              height: 8,
            ),
            Text(s,
                style: TextStyle(
                  color: CustomColor().originalBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
      height: 60,
      decoration: tileDecorator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor().appBackground,
        appBar: CustomAppBar.build("Merchant Options", context),
        body: _buildOptions());
  }
}
