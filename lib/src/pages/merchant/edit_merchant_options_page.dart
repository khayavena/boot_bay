import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EditMerchantManagementOptionsWidget extends StatefulWidget {
  final Merchant merchant;

  EditMerchantManagementOptionsWidget({@required this.merchant});

  @override
  _EditMerchantManagementOptionsWidgetState createState() {
    return _EditMerchantManagementOptionsWidgetState();
  }
}

class _EditMerchantManagementOptionsWidgetState extends State<EditMerchantManagementOptionsWidget> {
  Widget _buildOptions() {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / .6, mainAxisSpacing: 8, crossAxisSpacing: 8),
        padding: EdgeInsets.only(left: 8, right: 8, top: 16),
        scrollDirection: Axis.vertical,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.merchantsManagementEdit, arguments: widget.merchant);
              },
              child: getItem("Edit Merchant")),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.merchantItemCategoryList, arguments: widget.merchant);
              },
              child: getItem("Categories")),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Revenue")),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Add Staff")),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Orders"))
        ]);
  }

  Widget getItem(String s) {
    return Container(
      child: Center(
        child: Text(s,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w700,
            )),
      ),
      height: 60,
      decoration: smallButtonDecoratorGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar.build("Merchant Edit Options", context), body: _buildOptions());
  }
}
