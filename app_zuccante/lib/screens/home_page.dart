import 'package:app_zuccante/controller/screen_controller.dart';
import 'package:app_zuccante/screens/circolari.dart';
import 'package:app_zuccante/screens/contatti.dart';
import 'package:app_zuccante/screens/la_scuola.dart';
import 'package:app_zuccante/screens/news_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsPage()),
            );
          },
          child: Container(
            //margin: const EdgeInsets.only(left: 10.0, right: 10.0),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Circolari()),
            );
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaScuola()),
            );
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "La Scuola",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contatti()),
            );
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
  }
}
