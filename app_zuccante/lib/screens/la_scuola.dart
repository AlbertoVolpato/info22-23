import 'package:app_zuccante/screens/la_scuola/automazione.dart';
import 'package:app_zuccante/screens/la_scuola/elettronica.dart';
import 'package:app_zuccante/screens/la_scuola/informatica.dart';
import 'package:app_zuccante/screens/la_scuola/telecomunicazione.dart';
import 'package:flutter/material.dart';

class LaScuola extends StatefulWidget {
  const LaScuola({super.key});

  @override
  State<LaScuola> createState() => _LaScuola();
}

class _LaScuola extends State<LaScuola> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Percorsi Didattici',
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
            MaterialPageRoute(builder: (context) => const Informatica()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                ),
              ],
              color: Color.fromARGB(255, 228, 230, 236),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Informatica",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage('informatica.jpeg'),
                width: MediaQuery.of(context).size.width / 1.1,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Percorso di studi di informatica...",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
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
            MaterialPageRoute(builder: (context) => const Elettronica()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                ),
              ],
              color: Color.fromARGB(255, 228, 230, 236),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Elettronica",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage("elettronica.jpeg"),
                width: MediaQuery.of(context).size.width / 1.1,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Percorso di studi di Elettronica...",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
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
            MaterialPageRoute(builder: (context) => const Telecomunicazioni()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                ),
              ],
              color: Color.fromARGB(255, 228, 230, 236),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Telecomunicazioni",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage("telecomunicazioni.png"),
                width: MediaQuery.of(context).size.width / 1.1,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Percorso di studi ",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Telecomunicazioni... ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
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
            MaterialPageRoute(builder: (context) => const Automazione()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                ),
              ],
              color: Color.fromARGB(255, 228, 230, 236),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Automazione",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage("automazione.webp"),
                width: MediaQuery.of(context).size.width / 1.1,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Percorso di studi di Automazione...",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
          ]),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ]));
  }
}
