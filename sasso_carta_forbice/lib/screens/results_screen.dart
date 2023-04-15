import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scisor_game/screens/main_screen.dart';
import 'package:rock_paper_scisor_game/utilis/game.dart';
import 'package:rock_paper_scisor_game/widgets/button.dart';
import 'package:shake/shake.dart';

class GameScreen extends StatefulWidget {
  GameScreen(this.gameChoice, {Key? key}) : super(key: key);
  GameChoice gameChoice;
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  /* Generating random choice */
  String? randomChoice() {
    Random random = new Random();
    int robotChoiceIndex = random.nextInt(3);
    return Game.choices[robotChoiceIndex];
  }

  bool shacked = false;
  String? robotChoice = null;
  String? robotChoicePath = null;
  @override
  Widget build(BuildContext context) {
    String? player_choice;
    switch (widget.gameChoice.type) {
      case "Rock":
        player_choice = "assets/rock_btn.png";
        break;
      case "Paper":
        player_choice = "assets/paper_btn.png";
        break;
      case "Scisors":
        player_choice = "assets/scisor_btn.png";
        break;
      default:
    }

    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      if (shacked == false) {
        shacked = true;
        setState(() {
          robotChoice = randomChoice()!;
          switch (robotChoice) {
            case "Rock":
              robotChoicePath = "assets/rock_btn.png";
              break;
            case "Paper":
              robotChoicePath = "assets/paper_btn.png";
              break;
            case "Scisors":
              robotChoicePath = "assets/scisor_btn.png";
              break;
            default:
          }
          if (GameChoice.gameRules[widget.gameChoice.type]![robotChoice!] ==
              "You Win") {
            Game.gameScore++;
            print("Vinto");
          }
        });
      }
    });

    double btnWidth = MediaQuery.of(context).size.width / 2 - 40;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.red, width: 5.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SCORE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Game.gameScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /* Setting the Game play pad */
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "${widget.gameChoice.type}",
                      child: gameBtn(() {}, player_choice!, btnWidth - 20),
                    ),
                    Text(
                      "VS",
                      style: TextStyle(color: Colors.black, fontSize: 26.0),
                    ),
                    GameChoice.gameRules[widget.gameChoice.type]![
                                robotChoice] !=
                            null
                        ? AnimatedOpacity(
                            opacity: 1,
                            duration: Duration(seconds: 3),
                            child:
                                gameBtn(() {}, robotChoicePath!, btnWidth - 20),
                          )
                        : Text("Waiting For Shakin")
                  ],
                ),
              ),
            ),
            GameChoice.gameRules[widget.gameChoice.type]![robotChoice] != null
                ? GameChoice.gameRules[widget.gameChoice.type]![robotChoice] ==
                        "You Lose"
                    ? Text(
                        "${GameChoice.gameRules[widget.gameChoice.type]![robotChoice]}",
                        style: TextStyle(color: Colors.red, fontSize: 36.0),
                      )
                    : Text(
                        "${GameChoice.gameRules[widget.gameChoice.type]![robotChoice]}",
                        style: TextStyle(color: Colors.blue, fontSize: 36.0),
                      )
                : Text(""),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                padding: EdgeInsets.all(24.0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                },
                shape: StadiumBorder(),
                fillColor: Colors.blue,
                child: Text(
                  "Play Again",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
