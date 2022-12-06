import 'package:client/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:client/screen/origin_screen.dart';
import 'package:client/screen/homepage.dart';
import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          //'/': (context) => OriginScreen(),
          '/': (context) => HomePage(),
          '/login': (context) => Login(),
          '/register': (context) => SingUp(),
          '/home': (context) => Home(),
        },
        theme: ThemeData(primarySwatch: Colors.grey));
  }
}
