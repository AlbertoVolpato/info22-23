import 'package:client/main.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/post_screen.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({super.key});

  @override
  State<ScreenController> createState() => _ScreenController();
}

class _ScreenController extends State<ScreenController> {
  loggedUserCheck() {
    if (user.get('user') != null) {
      return HomeScreen();
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return loggedUserCheck();
  }
}
