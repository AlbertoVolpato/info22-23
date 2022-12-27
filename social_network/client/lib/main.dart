import 'package:client/models/local_user.dart';
import 'package:client/models/oaut_google.dart';
import 'package:client/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box user;

Future<void> main() async {
  await Hive.initFlutter();
  user = await Hive.openBox('user');
  Hive.registerAdapter(UserAdapter());
  print(user.get());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram Feed UI Redesign',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => HomeScreen(),
        '/': (context) => LoginPage(),
        '/register': (context) => SignInDemo(),

        //'/': (context) => Post(),
      },
    );
  }
}
