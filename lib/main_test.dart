import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/provide_main_app.dart';
import 'package:flutter/material.dart';

void main() async {

  provideMainApp(Flavor.TEST);
}
