import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
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
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.white),
        onPressed: null,
        child: const Text('Register', style: TextStyle(color: Colors.black)),
      ),
    ]);
  }
}
