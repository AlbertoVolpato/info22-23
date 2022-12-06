import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:client/screen/origin_screen.dart';
import 'package:client/screen/homepage.dart';
import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';
import 'package:client/screen/account.dart';
import 'package:client/screen/reels.dart';
import 'package:client/screen/home.dart';
import 'package:client/screen/search.dart';
import 'package:client/screen/shop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});
  @override
  State<SingUp> createState() => _SingUp();
}

class _SingUp extends State<SingUp> {
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
      Container(
        margin: const EdgeInsets.all(10),
        child: const Text(
          "Register",
          style: TextStyle(fontSize: 35, color: Colors.white, shadows: []),
        ),
      ),
      Container(
        width: 400,
        height: 40,
        margin: const EdgeInsets.all(10),
        child: const TextField(
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            filled: true, //<-- SEE HERE
            fillColor: Colors.white,
            iconColor: Colors.white,
          ),
        ),
      ),
      Container(
        width: 400,
        height: 40,
        margin: const EdgeInsets.all(10),
        child: const TextField(
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'email',
            filled: true, //<-- SEE HERE
            fillColor: Colors.white,
            iconColor: Colors.white,
          ),
        ),
      ),
      Container(
        width: 400,
        height: 40,
        margin: const EdgeInsets.all(15),
        child: const TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            filled: true, //<-- SEE HERE
            fillColor: Colors.white,
            iconColor: Colors.white,
          ),
        ),
      ),
      Container(
        width: 240,
        height: 30,
        margin: const EdgeInsets.all(15),
        child: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white),
          onPressed: null,
          child: const Text('Register', style: TextStyle(color: Colors.black)),
        ),
      ),
      Container(
        width: 400,
        height: 30,
        margin: const EdgeInsets.all(0),
        child: TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
          child: const Text("Just have an account? Login"),
        ),
      ),
    ]);
  }
}
