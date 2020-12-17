import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/User.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('OnBoarding'),
        ),
        body: Consumer<UserViewModel>(
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
        ));
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
    return Container(
        child: Row(
      children: <Widget>[
        FlatButton(
          textColor: Colors.blue,
          child: Text(
            'Shopping',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            //signup screen
          },
        ),
        FlatButton(
          textColor: Colors.blue,
          child: Text(
            'Add Merchant',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouting.merchantsRegistration, arguments: value.getUser.id);
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
