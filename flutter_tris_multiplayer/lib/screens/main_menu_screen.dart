import 'package:flutter/material.dart';
import 'package:mp_tictactoe/responsive/responsive.dart';
import 'package:mp_tictactoe/screens/create_room_screen.dart';
import 'package:mp_tictactoe/screens/join_room_screen.dart';
import 'package:mp_tictactoe/widgets/custom_button.dart';
import 'package:mp_tictactoe/screens/game_screen_1v1.dart';
import 'package:mp_tictactoe/screens/game_screen_1vIa.dart';
import 'package:mp_tictactoe/utils/colors.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';

  const MainMenuScreen({Key? key}) : super(key: key);

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void singlePlayerRoom(BuildContext context) {
    Navigator.pushNamed(context, GameScreen1vsIA.routeName);
  }

  void onevsIARoom(BuildContext context) {
    Navigator.pushNamed(context, GameScreenTwoPlayer.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TicTacToe',
          style: const TextStyle(fontSize: 50),
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
        elevation: 20,
        toolbarHeight: 70,
      ),
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => onevsIARoom(context),
              text: 'Single Player',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => singlePlayerRoom(context),
              text: 'Multiplayer Locale',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => createRoom(context),
              text: 'Crea una Stanza',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => joinRoom(context),
              text: 'Unisciti ad una Stanza',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: (Center(
            child: Text(
          "© Copyright 2022 Alberto Volpato",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ))),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
