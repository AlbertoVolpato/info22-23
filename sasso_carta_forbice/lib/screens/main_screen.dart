import 'package:flutter/material.dart';
import 'package:sasso_carta_forbice/screens/results_screen.dart';
import 'package:sasso_carta_forbice/utilis/game.dart';
import 'package:sasso_carta_forbice/widgets/button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width / 2 - 40;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0,
            ),
            Container(
              height: 80,
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      width: 200,
                      top: 0,
                      left: MediaQuery.of(context).size.width / 2 -
                          (btnWidth / 2) -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Rock",
                        child: gameBtn(() {
                          print("you choosed rock");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Rock")),
                            ),
                          );
                        }, "assets/rock.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      width: 200,
                      top: btnWidth,
                      left: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          50, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Scisors",
                        child: gameBtn(() {
                          print("you choosed scisors");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Scisors")),
                            ),
                          );
                        }, "assets/scissors.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      width: 200,
                      top: btnWidth,
                      right: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          60, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Paper",
                        child: gameBtn(() {
                          print("you choosed paper");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Paper")),
                            ),
                          );
                        }, "assets/paper.png", btnWidth),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blue,
                padding: EdgeInsets.all(24.0),
                onPressed: () {
                  setState(() {
                    Game.gameScore = 0;
                  });
                },
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.blue, width: 5)),
                child: Text(
                  "Reset Game",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
