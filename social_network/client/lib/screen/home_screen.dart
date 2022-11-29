import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
