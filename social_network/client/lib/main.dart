import 'package:flutter/material.dart';
import 'package:client/screen/home_login.dart';
import 'package:client/screen/home_screen.dart';
import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => HomeLogin(),
      '/login': (context) => Login(),
      '/register': (context) => Register(),
      '/home': (context) => HomePage(),
    });
  }
}
