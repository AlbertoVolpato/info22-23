import 'package:flutter/material.dart';
import 'package:sasso_carta_forbice/components/game.dart';
import 'package:sasso_carta_forbice/components/selection_bar.dart';
import 'package:sasso_carta_forbice/components/board.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 1;
  int _userScore = 0;
  int _computerScore = 0;
  String _message = 'Fai una scelta!';
  late String computerChoice;

  void async;
  createGame(int index) {
    String userChoice = indexToChoice(index);
    Map gameResults = game(userChoice);
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      computerChoice = choiceToWord(gameResults['computerChoice']);
    });
    String message = 'Il computer ha scelto \n $computerChoice ';

    if (gameResults['result'] == 0) {
      message += 'Pareggio! 🙌';
      this.setState(() {
        this._index = index;
        this._message = message;
      });
    } else if (gameResults['result'] == 1) {
      message += 'Hai Vinto! 😎';
      this.setState(() {
        this._index = index;
        this._message = message;
        this._userScore++;
      });
    } else if (gameResults['result'] == -1) {
      message += 'Hai Perso 😭';
      this.setState(() {
        this._index = index;
        this._message = message;
        this._computerScore++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sasso ✊ Carta ✋ Forbice ✌️'),
        ),
        body: GameBoard(
          userScore: _userScore,
          computerScore: _computerScore,
          message: _message,
          win: false,
        ),
        bottomNavigationBar: SelectionBar(
          currentIndex: _index,
          onTap: createGame,
        ));
  }
}
