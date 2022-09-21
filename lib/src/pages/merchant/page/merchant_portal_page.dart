import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/pages/user/viewmodel/UserViewModel.dart';
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

  late UserViewModel _userViewModel;

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
          backgroundColor: CustomColor().pureWhite,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(
            "BOOT-BAY PORTAL",
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 12,
              fontFamily: 'SFProText',
            ),
          ),
          leading: IconButton(
              icon: ImageIcon(AssetImage(Res.leading_icon)),
              color: primaryBlackColor,
              onPressed: () {}),
          centerTitle: true,
        ),
        body: _buildOptions());
  }

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
              onTap: () async {
                if (_userViewModel.isLoggedIn()) {
                  final user = await _userViewModel.getCurrentUser();
                  Navigator.of(context).pushNamed(
                      AppRouting.merchantsManagementListPage,
                      arguments: user.id);
                }
              },
              child: buildActionItem("Manage", Icons.business)),
          GestureDetector(
              onTap: () async {
                if (_userViewModel.isLoggedIn()) {
                  Navigator.of(context)
                      .pushNamed(AppRouting.merchantsRegistrationPage);
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
              child: buildActionItem("Login", Icons.login),),
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
            Icon(
              iconData,
              color: Color(0xff2783a9),
            ),
            SizedBox(
              height: 8,
            ),
            Text(label,
                style: TextStyle(
                  color: Color(0xff2783a9),
                  fontSize: 15,
                  fontFamily: 'SFProText',
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
