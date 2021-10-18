import 'package:bootbay/res.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
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
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(
        context,
        listen: false,
      ).isLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryWhite,
          title: Text('Login page'),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Container(
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
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLoginAction(Res.google_ic),
                  _buildLoginAction(Res.facebook_ic),
                  _buildLoginAction(Res.twitter_ic),
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

  Widget _buildLoginAction(String icon) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover)),
      padding: EdgeInsets.only(top: 50.0),
    );
  }
}
