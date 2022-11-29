import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
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
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
          filled: true, //<-- SEE HERE
          fillColor: Colors.white30,
        ),
      ),
      TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            filled: true, //<-- SEE HERE
            fillColor: Colors.white30,
          )),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.white),
        onPressed: null,
        child: const Text('Login', style: TextStyle(color: Colors.black)),
      ),
    ]);
  }
}
