import 'package:flutter/material.dart';
import 'package:flutter_tris_multiplayer/utils/colors.dart';
import 'package:flutter_tris_multiplayer/resources/algoritmoIA.dart';

class GameScreen1vsIA extends StatefulWidget {
  static String routeName = '/1vsIA';
  const GameScreen1vsIA({Key? key}) : super(key: key);

  @override
  State<GameScreen1vsIA> createState() => _GameScreen1vsIA();
}

class _GameScreen1vsIA extends State<GameScreen1vsIA> {
  static const String PLAYER_X = "X";
  static const String PLAYER_O = "O";
  late int PLAYER_X_POINT = 0;
  late int PLAYER_O_POINT = 0;
  late String currentPlayer = PLAYER_X;
  late bool gameEnd;
  late List<String> caselle; // array di caselle
  late bool gamemode;

  @override
  void initState() {
    inizializzaGioco();
    super.initState();
  }

//INIZIALIZZA IL GIOCO
  void inizializzaGioco() {
    gameEnd = false;
    caselle = ["", "", "", "", "", "", "", "", ""]; // 3 x 3 caselle
    //if (currentPlayer == PLAYER_O) {
    //  caselle[intelligenzaArtificiale()] = currentPlayer;
    //}
  }

//CREAZIONE AREA DI GIOCO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _scoreboard(),
          _gameArea(),
          _schermataSuperiore(),
        ],
      )),

      //Footer
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

//WIDGET SUPERIORE
  Widget _schermataSuperiore() {
    return Text(
      "turno di $currentPlayer",
      style: const TextStyle(
          fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
    );
  }

//Scoreboard
  Widget _scoreboard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'player x',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                PLAYER_X_POINT.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'player o',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                PLAYER_O_POINT.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//AREA TRIS
  Widget _gameArea() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

//AZIONI SULLE CASELLE
  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (gameEnd || caselle[index].isNotEmpty) {
          return;
        }
        setState(() {
          caselle[index] = currentPlayer;
          cambiaTurno();
          verificaVincitore();
          verificaPareggio();
          caselle[intelligenzaArtificiale()] = currentPlayer;
          cambiaTurno();
          verificaVincitore();
          verificaPareggio();
        });
      },
      child: Container(
        color: caselle[index].isEmpty
            ? Colors.black26
            : caselle[index] == PLAYER_X
                ? pl1Color
                : pl2Color,
        margin: const EdgeInsets.all(8),
        child: (Center(
            child: Text(
          caselle[index],
          style: const TextStyle(fontSize: 50),
        ))),
      ),
    );
  }

//CAMBIA IL TURNO DI GIOCO
  cambiaTurno() {
    if (currentPlayer == PLAYER_X) {
      currentPlayer = PLAYER_O;
    } else {
      currentPlayer = PLAYER_X;
    }
  }

  intelligenzaArtificiale() {
    if (currentPlayer == PLAYER_O) {
      return IAalgo.findBestMove(caselle);
    }
  }

//VERIFICA CHI HA VINTO
  verificaVincitore() {
    List<List<int>> winningList = [
      //vincita in orizzontale
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      //vincita in verticale
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      //vincita in diagonale
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var winningPos in winningList) {
      String PlayerPosition0 = caselle[winningPos[0]];
      String PlayerPosition1 = caselle[winningPos[1]];
      String PlayerPosition2 = caselle[winningPos[2]];

      if (PlayerPosition0.isNotEmpty) {
        if (PlayerPosition0 == PlayerPosition1 &&
            PlayerPosition0 == PlayerPosition2) {
          //showGameOverMessage("Il Giocatore $PlayerPosition0 Ha Vinto");
          showAlertDialog("Il Giocatore $PlayerPosition0 Ha Vinto");
          //if(PlayerPosition0 == "")
          if (PlayerPosition0 == "X") {
            PLAYER_X_POINT = PLAYER_X_POINT + 1;
          } else {
            PLAYER_O_POINT = PLAYER_O_POINT + 1;
          }
          gameEnd = true;
          inizializzaGioco();
          return;
        }
      }
    }
  }

  verificaPareggio() {
    if (gameEnd) {
      return;
    }
    bool pareggio = true;
    for (var playerCaselle in caselle) {
      if (playerCaselle.isEmpty) {
        pareggio = false;
      }
    }
    if (pareggio) {
      showAlertDialog("Pareggio!");
      gameEnd = true;
      inizializzaGioco();
    }
  }

//MOSTRA ALERT QUANDO GIOCATORE VINCE
  showAlertDialog(String text) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Ok'),
          child: const Text('Ok'),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //MODALITA' 1 vs IA
  //ia() {}
}
