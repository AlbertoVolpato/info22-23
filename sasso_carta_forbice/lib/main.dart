import 'package:flutter/material.dart';
import 'package:sasso_carta_forbice/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sasso ✊ Carta ✋ Forbice ✌️',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomePage(),
    );
  }
}
