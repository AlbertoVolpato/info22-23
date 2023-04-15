import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  final int userScore;
  final int computerScore;
  final String message;
  final bool win;

  const GameBoard(
      {super.key,
      required this.userScore,
      required this.computerScore,
      this.message = '',
      required this.win});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            '$userScore:$computerScore',
            style: TextStyle(fontSize: 50, color: Colors.pink),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
