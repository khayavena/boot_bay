import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:bootbay/src/model/User.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserViewModel _userViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Onboarding'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Boot Login',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name(s)',
                    ),
                  ),
                ),Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No',
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
                      child: Text('Sign Up'),
                      onPressed: () {
                        loginNow();
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  void loginNow() {
    User user = User(
        firstName: nameController.text,
        dateOfBirth: DateTime.now().toString(),
        lastName: nameController.text,
        contactNo: phoneController.text,
        password: passwordController.text);
    _userViewModel.signUp(user);
  }
}
