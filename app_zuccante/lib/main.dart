import 'package:app_zuccante/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:app_zuccante/controller/screen_controller.dart';
import 'models/save_circolari.dart';
import 'package:objectbox/objectbox.dart';

late SaveCircolare storeCircolari;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  storeCircolari = await SaveCircolare.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(),
    );
  }
}
