import 'package:bootbay/res.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/helpers/widget_styles.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LoginDialogPage extends StatefulWidget {
  @override
  _LoginDialogPageState createState() {
    return _LoginDialogPageState();
  }
}

class _LoginDialogPageState extends State<LoginDialogPage> {
  UserViewModel _vm;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _vm = Provider.of<UserViewModel>(
        context,
        listen: false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Align(alignment: Alignment.center, child: _buildBody()),
      ],
    ));
  }

  Widget _buildBody() {
    return Container(
      height: 500,
      child: Consumer<UserViewModel>(
        builder: (BuildContext context, UserViewModel value, Widget child) {
          switch (value.loader) {
            case Loader.error:
              return Center(child: Text(value?.dataErrorMessage ?? 'Something is wrong'));
              break;
            case Loader.busy:
              return Center(child: ColorLoader5());
              break;
            case Loader.complete:
              value?.resetLoader();
              Navigator.pop(context);
              break;
            case Loader.idl:
              // TODO: Handle this case.
              break;
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Welcome to Boot-Pay',
                    style: TextStyle(
                      color: secondaryBlueColor,
                      fontSize: 24,
                      fontWeight: mediumFont,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.6400000000000001,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Login with',
                    style: TextStyle(
                      color: secondaryBlueColor,
                      fontSize: 16,
                      fontWeight: largeFont,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.6400000000000001,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLoginAction(Res.google_ic, LoginOption.google),
                  _buildLoginAction(Res.facebook_ic, LoginOption.fb),
                  _buildLoginAction(Res.twitter_ic, LoginOption.twitter),
                ],
              ),
              Expanded(child: _buildInputView()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputView() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {},
                decoration: inputDecorator(hint: 'Email address'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                onChanged: (value) {},
                obscureText: true,
                decoration: inputDecorator(hint: 'Password'),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () {
                  //forgot password screen
                },
                child: Text('Sign Up'),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {},
                )),
          ],
        ));
  }

  Widget _buildLoginAction(final String icon, final LoginOption loginOption) {
    return GestureDetector(
      onTap: () {
        _vm.logIn(loginOption);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: 50.0),
      ),
    );
  }
}
