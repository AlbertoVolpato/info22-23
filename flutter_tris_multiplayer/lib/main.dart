import 'package:flutter/material.dart';
import 'package:flutter_tris_multiplayer/provider/room_data_provider.dart';
import 'package:flutter_tris_multiplayer/screens/create_room_screen.dart';
import 'package:flutter_tris_multiplayer/screens/game_screen.dart';
import 'package:flutter_tris_multiplayer/screens/game_screen_1v1.dart';
import 'package:flutter_tris_multiplayer/screens/game_screen_1vIa.dart';
import 'package:flutter_tris_multiplayer/screens/join_room_screen.dart';
import 'package:flutter_tris_multiplayer/screens/main_menu_screen.dart';
import 'package:flutter_tris_multiplayer/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
          GameScreenTwoPlayer.routeName: (context) =>
              const GameScreenTwoPlayer(),
          GameScreen1vsIA.routeName: (conext) => const GameScreen1vsIA(),
        },
        //initialRoute: MainMenuScreen.routeName,
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
