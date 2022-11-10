import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X = "X";
  static const String PLAYER_O = "O";
  late String currentPlayer;
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
    currentPlayer = PLAYER_X;
    gameEnd = false;
    caselle = ["", "", "", "", "", "", "", "", ""]; // 3 x 3 caselle
  }

//CREAZIONE AREA DI GIOCO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 78, 79),
      //Header
      appBar: AppBar(
        title: Text(
          'TicTacToe',
          style: const TextStyle(fontSize: 50),
        ),
        backgroundColor: Color.fromARGB(255, 44, 54, 57),
        centerTitle: true,
        elevation: 20,
        toolbarHeight: 70,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _schermataSuperiore(),
          _gameArea(),
        ],
      )),

      //Footer
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 44, 54, 57),
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
    return Container(
      color: currentPlayer == PLAYER_X
          ? Color.fromARGB(255, 162, 123, 92)
          : Color.fromARGB(255, 220, 215, 201),
      margin: EdgeInsets.only(left: 190, top: 10, right: 190, bottom: 10),
      child: (Center(
          child: Text(
        "turno di $currentPlayer",
        style: const TextStyle(
            fontSize: 40, color: Color.fromARGB(255, 35, 35, 35)),
      ))),
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
        });
      },
      child: Container(
        color: caselle[index].isEmpty
            ? Colors.black26
            : caselle[index] == PLAYER_X
                ? Color.fromARGB(255, 162, 123, 92)
                : Color.fromARGB(255, 220, 215, 201),
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
      title: const Text('Game Over'),
      content: Text(text),
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
  ia() {}
}
