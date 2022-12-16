import 'package:flutter/material.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/models/post_get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram Feed UI Redesign',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        //'/': (context) => Post(),
      },
    );
  }
}
