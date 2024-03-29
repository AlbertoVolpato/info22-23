import 'package:flutter/material.dart';
import 'package:flutter_tris_prova/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tris Flutter',
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    );
  }
}
