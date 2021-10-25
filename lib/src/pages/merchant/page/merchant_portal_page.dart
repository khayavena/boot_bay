import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
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
        backgroundColor: CustomColor().appBackground,
        body: buildDefaultCollapsingWidget(
            bodyWidget: _buildOptions(),
            title: 'Boot-bay Portal',
            backButton:
                IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {})));
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
                await _userViewModel?.isLoggedIn();
                if (_userViewModel.isLogged) {
                  Navigator.of(context)
                      .pushNamed(AppRouting.merchantsManagementList, arguments: _userViewModel.getUser.id);
                } else {
                  //alert
                }
              },
              child: getItem("Manage", Icons.business)),
          GestureDetector(
              onTap: () async {
                await _userViewModel.isLoggedIn();
                if (_userViewModel.isLogged) {
                  Navigator.of(context)
                      .pushNamed(AppRouting.merchantsRegistration, arguments: _userViewModel.getUser.id);
                } else {
                  //alert
                }
              },
              child: getItem("New Merchant", Icons.add_business)),
          GestureDetector(
              onTap: () async {
                Navigator.of(context).pushNamed(AppRouting.loginPage);
              },
              child: getItem("Invest", Icons.business_center)),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.loginPage);
              },
              child: getItem("Shopping", Icons.shopping_basket))
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
}
