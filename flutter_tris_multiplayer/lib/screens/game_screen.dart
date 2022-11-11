import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:mp_tictactoe/views/scoreboard.dart';
import 'package:mp_tictactoe/views/tictactoe_board.dart';
import 'package:mp_tictactoe/views/waiting_lobby.dart';
import 'package:provider/provider.dart';
import 'package:mp_tictactoe/utils/colors.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      //Header
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
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Scoreboard(),
                  const TicTacToeBoard(),
                  Text(
                    'turno di ${roomDataProvider.roomData['turn']['nickname']}',
                    style: const TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )
                ],
              ),
            ),
      //Footer
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: buttonColor,
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
