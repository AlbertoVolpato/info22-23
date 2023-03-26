import 'package:flutter/material.dart';

import 'package:app_zuccante/screens/circolari.dart';
import 'package:app_zuccante/screens/la_scuola.dart';
import 'package:app_zuccante/screens/news_page.dart';
import 'package:app_zuccante/screens/offerta_formativa.dart';
import 'package:app_zuccante/screens/segreteria.dart';
import 'package:app_zuccante/screens/contatti.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class CardImage {
  final String title;
  final Image image;

  CardImage({
    required this.title,
    required this.image,
  });
}

class _HomeScreen extends State<HomeScreen> {
  var _selectedroute = 0;
  int _index = 0;
  List<CardImage> SchoolCards = [
    CardImage(
        title: "Sede Triennio",
        image: Image.asset(
          "zuccante_triennio.png",
          height: 180,
          width: 500,
        )),
    CardImage(
        title: "Sede Biennio",
        image: Image.asset(
          "zuccante_biennio.png",
          height: 180,
          width: 500,
        )),
  ];
  void route(int index) {
    setState(() {
      _selectedroute = index;
    });
  }

  router() {
    if (_selectedroute == 0) {
      return Scaffold(
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(0, 35, 71, 1.0),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 230, // card height
              child: PageView.builder(
                itemCount: SchoolCards.length,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, i) {
                  return Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          ClipRRect(
                            child: SchoolCards[i].image,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Center(
                            child: Text(
                              "${SchoolCards[i].title}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                route(1);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 7,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(
                          0,
                          5,
                        ),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(5, 0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: const AssetImage('news.png'),
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "News",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                route(2);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 7,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(
                          0,
                          5,
                        ),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(5, 0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: const AssetImage('circolari.png'),
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Circolare",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                route(3);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 7,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(
                          0,
                          5,
                        ),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(5, 0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: const AssetImage('school.png'),
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "La Scuola",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                route(6);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 7,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(
                          0,
                          5,
                        ),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(5, 0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: const AssetImage('offerta_formativa.png'),
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Offerta Formativa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                route(6);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 7,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(
                          0,
                          5,
                        ),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(5, 0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: const AssetImage('contatti.png'),
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Contatti",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    } else if (_selectedroute == 1) {
      return NewsPage();
    } else if (_selectedroute == 2) {
      return Circolari();
    } else if (_selectedroute == 3) {
      return LaScuola();
    } else if (_selectedroute == 4) {
      return OffertaFormativa();
    } else if (_selectedroute == 5) {
      return Segreteria();
    } else if (_selectedroute == 6) {
      return Contatti();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 35, 71, 1.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // child: Image.asset('logo.png'),
                child: Text("C. Zuccante"),
                padding: const EdgeInsets.only(right: 45.0),
              )
            ],
          ),
        ),
        body: router(),
        drawer: Drawer(
            backgroundColor: const Color.fromRGBO(0, 35, 71, 1.0),
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 12)),
                ListTile(
                  title:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(0);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:
                      const Text('News', style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.newspaper,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(1);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Circolari',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(2);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('La Scuola',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(3);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Offerta Formativa',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.auto_stories,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(4);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Segreteria',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.contact_phone,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(5);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Contatti',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  onTap: () {
                    route(6);
                    Navigator.pop(context);
                  },
                ),
              ],
            )));
  }
}
