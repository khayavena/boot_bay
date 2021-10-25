import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../res.dart';

class MerchantPortalPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MerchantPortalPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserViewModel _userViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _userViewModel = Provider.of<UserViewModel>(
        context,
        listen: false,
      );
      _userViewModel.isLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryWhite,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(
            "BOOT-BAY PORTAL",
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 15,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w700,
            ),
          ),
          leading:
              IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {}),
          centerTitle: true,
        ),
        body: _buildOptions());
  }

  Widget _buildOptions() {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / .6, mainAxisSpacing: 8, crossAxisSpacing: 8),
        padding: EdgeInsets.only(left: 8, right: 8, top: 16),
        scrollDirection: Axis.vertical,
        children: [
          GestureDetector(
              onTap: () async {
                if (_userViewModel.isLoggedIn()) {
                  Navigator.of(context)
                      .pushNamed(AppRouting.merchantsManagementList, arguments: _userViewModel.getUser.id);
                } else {
                  //alert
                }
              },
              child: buildActionItem("Manage", Icons.business)),
          GestureDetector(
              onTap: () async {
                if (_userViewModel.isLoggedIn()) {
                  Navigator.of(context)
                      .pushNamed(AppRouting.merchantsRegistration, arguments: _userViewModel.getUser.id);
                } else {
                  //alert
                }
              },
              child: buildActionItem("New Merchant", Icons.add_business)),
          GestureDetector(
              onTap: () async {
                if (!_userViewModel.isLoggedIn()) {
                  Navigator.of(context).pushNamed(AppRouting.loginPage);
                }
              },
              child: buildActionItem("Invest", Icons.business_center)),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.loginPage);
              },
              child: buildActionItem("Shopping", Icons.shopping_basket))
        ]);
  }

  Widget buildActionItem(String label, IconData iconData) {
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
            Text(label,
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
}
