import 'package:client/models/local_user.dart';
import 'package:client/models/oaut_google.dart';
import 'package:client/screens/login_page.dart';
import 'package:client/screens/profile_screen_one.dart';
import 'package:client/screens/screen_controller.dart';
import 'package:client/screens/complete_registration.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box user;

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  user = await Hive.openBox('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram Feed UI Redesign',
      debugShowCheckedModeBanner: false,
      routes: {
        // '/': (context) => ScreenController(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginPage(),
        '/': (context) => ScreenController(),
        //'/': (context) => ProfileScreen1(),
      },
    );
  }
}
