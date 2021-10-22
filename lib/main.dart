import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/di/provide_main_app.dart';
import 'package:bootbay/src/helpers/widget_styles.dart';
import 'package:flutter/material.dart';

void main() async {
  provideMainApp(Flavor.DEV);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(elevatedButtonTheme: blueButtonStyle),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouting.generateRoute);
  }
}
