import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/WidgetDecorators.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/user.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../res.dart';

class AuthPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AuthPage> {
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
            bodyWidget: _buildBody(),
            title: 'Welcome to Digi-Titan',
            backButton:
                IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {})));
  }

  Future<void> loginNow() async {
    User user = User(
        firstName: emailController.text,
        dateOfBirth: DateTime.now().toString(),
        lastName: emailController.text,
        password: passwordController.text);
    await _userViewModel.signUp(user);
  }

  void signNow() async {
    AuthRequest user = AuthRequest(emailAddress: emailController.text, password: passwordController.text);
    await _userViewModel.signIn(user);
  }

  Widget _buildOptions(UserViewModel value) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / .6, mainAxisSpacing: 8, crossAxisSpacing: 8),
        padding: EdgeInsets.only(left: 8, right: 8, top: 16),
        scrollDirection: Axis.vertical,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.merchantsManagementList, arguments: value.getUser.id);
              },
              child: getItem("Manage", Icons.business)),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("New Merchant", Icons.add_business)),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
              },
              child: getItem("Invest", Icons.business_center)),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
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

  Widget _buildBody() {
    return Consumer<UserViewModel>(
      builder: (BuildContext context, UserViewModel value, Widget child) {
        switch (value.loader) {
          case Loader.idl:
            return Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      textColor: Colors.blue,
                      child: Text('Forgot Password'),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () {
                            signNow();
                          },
                        )),
                  ],
                ));
          case Loader.error:
            return Center(child: Text(value?.dataErrorMessage ?? 'Something is wrong'));
            break;
          case Loader.busy:
            return Center(child: ColorLoader5());
            break;
          case Loader.complete:
            _userViewModel?.resetLoader();
            return _buildOptions(value);
        }
        return Container();
      },
    );
  }
}
