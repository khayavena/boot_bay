import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/button_styles.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
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
          return _buildInputView();
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
            ElevatedButton(
              onPressed: () {
                //forgot password screen
              },
              child: Text('Forgot Password'),
            ),
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
}
