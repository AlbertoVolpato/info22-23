import 'package:client/models/oaut_google.dart';
import 'package:client/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram Feed UI Redesign',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => SignInDemo(),

        //'/': (context) => Post(),
      },
    );
  }
}
