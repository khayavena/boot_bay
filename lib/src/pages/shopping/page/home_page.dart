// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:bootbay/res.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/pages/user/auth_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_wish_list_page.dart';
import 'package:flutter/material.dart';

import '../../merchant/page/merchant_list_page.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  int _currentIndex = 0;
  final List<Widget> _children = [MerchantListPage(), ShoppingWishListPage(), AuthPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: onTabTapped,
        // new
        selectedItemColor: secondaryBlack,
        unselectedItemColor: primaryBlackColor,
        currentIndex: _currentIndex,
        // be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(Res.shop_ic),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(Res.wish_inactive_ic),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Res.account_ic),
              ),
              label: '')
        ],
      ),
    );
  }
}
