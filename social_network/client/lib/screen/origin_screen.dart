import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:client/screen/origin_screen.dart';
import 'package:client/screen/homepage.dart';
import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';
import 'package:client/screen/account.dart';
import 'package:client/screen/reels.dart';
import 'package:client/screen/home.dart';
import 'package:client/screen/search.dart';
import 'package:client/screen/shop.dart';

class OriginScreen extends StatefulWidget {
  const OriginScreen({super.key});
  @override
  State<OriginScreen> createState() => _OriginScreen();
}

class _OriginScreen extends State<OriginScreen> {
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
          "The Social Network",
          style: TextStyle(fontSize: 35, color: Colors.white, shadows: []),
        ),
      ),
      Container(
        width: 200,
        height: 30,
        margin: const EdgeInsets.all(10),
        child: TextButton(
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
      ),
      Container(
          width: 200,
          height: 30,
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SingUp()),
              );
            },
            child:
                const Text('Register', style: TextStyle(color: Colors.black)),
          )),
    ]);
  }
}
