import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:client/screen/home_login.dart';
import 'package:client/screen/home_screen.dart';
import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({super.key});
  @override
  State<HomeLogin> createState() => _HomeLogin();
}

class _HomeLogin extends State<HomeLogin> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_loginRegister()],
      )),
    );
  }

  Widget _loginRegister() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Material(
        child: ListTile(
          title: const Text('SocialNetwork'),
          textColor: Colors.white,
        ),
      ),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        },
        child: const Text('Login', style: TextStyle(color: Colors.black)),
      ),
      const SizedBox(height: 30),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Register()),
          );
        },
        child: const Text('Register', style: TextStyle(color: Colors.black)),
      ),
      const SizedBox(height: 30),
    ]);
  }
}
