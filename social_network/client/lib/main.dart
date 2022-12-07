import 'package:flutter/material.dart';
import 'package:client/screens/feed_screen.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/diocan_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          //'/': (context) => FeedScreen(),
          '/': (context) => MyStatefulWidget(),

          '/profile': (context) => ProfileScreen(),
        },
        theme: ThemeData(primarySwatch: Colors.grey));
  }
}
