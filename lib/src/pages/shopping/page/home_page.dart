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
import 'package:bootbay/src/pages/merchant/page/merchant_portal_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_cart_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../merchant/page/merchant_list_page.dart';

class HomeBottomNavPage extends StatefulWidget {
  HomeBottomNavPage({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeBottomNavPage> {
  final List<Widget> _children = [MerchantListPage(), ShoppingCartPage(), ShoppingWishListPage(), PortalPage()];

  @override
  void initState() {
    onTabTapped(0);
    super.initState();
  }

  void onTabTapped(int index) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<BottomNavChangeNotifier>(
        context,
        listen: false,
      ).onChanged(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<BottomNavChangeNotifier>(builder: (BuildContext context, BottomNavChangeNotifier vm, Widget child) {
        if (vm != null) {
          return _children[vm.selectedIndex];
        }
        return _children[0];
      }),
      bottomNavigationBar:
          Consumer<BottomNavChangeNotifier>(builder: (BuildContext context, BottomNavChangeNotifier vm, Widget child) {
        return BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: onTabTapped,
          // new
          selectedItemColor: secondaryBlack,
          unselectedItemColor: primaryBlackColor,
          currentIndex: vm.selectedIndex,
          // be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Res.shop_ic),
              ),
              label: 'Buy',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Res.cart_ic),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Res.wish_inactive_ic),
              ),
              label: 'Wish',
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(Res.account_ic),
                ),
                label: 'Profile')
          ],
        );
      }),
    );
  }
}

class BottomNavChangeNotifier extends ChangeNotifier {
  int selectedIndex = 0;

  onChanged(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
