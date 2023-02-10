import 'package:flutter/material.dart';

import 'package:app_zuccante/screens/circolari.dart';
import 'package:app_zuccante/screens/home_page.dart';
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

class _HomeScreen extends State<HomeScreen> {
  var _selectedroute = 0;

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
        body: ListView(children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Flexible(
                  child: Text(
                    'Home Page',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
              // margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                  ),
                ],
                color: Colors.white,
                // borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "News",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: const AssetImage('news.png'),
                    width: MediaQuery.of(context).size.width / 1.1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Guarda ora le news più recenti...",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
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
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                  ),
                ],
                color: Colors.white,
                //borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Circolari",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: const AssetImage('circolari.png'),
                    width: MediaQuery.of(context).size.width / 1.1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Leggi ora le circolari più ricenti...",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
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
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "La Scuola",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: const AssetImage("zuccante.png"),
                        width: MediaQuery.of(context).size.width / 1.1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Scopri la nostra scuola",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      "E tutti i percorsi a te dedicati",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
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
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Contatti",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: const AssetImage("contatti.png"),
                    width: MediaQuery.of(context).size.width / 1.1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "se hai bisongo di aiuto ",
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  "Contatta la scuola",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ]),
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
        backgroundColor: Color.fromRGBO(231, 230, 233, 1),
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
