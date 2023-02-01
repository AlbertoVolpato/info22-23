import 'package:flutter/material.dart';

import 'package:app_zuccante/screens/circolari.dart';
import 'package:app_zuccante/screens/home_page.dart';
import 'package:app_zuccante/screens/la_scuola.dart';
import 'package:app_zuccante/screens/news_page.dart';
import 'package:app_zuccante/screens/offerta_formativa.dart';
import 'package:app_zuccante/screens/segreteria.dart';
import 'package:app_zuccante/screens/contatti.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      return HomePage();
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('logo.png'),
                height: 90,
                padding: const EdgeInsets.only(right: 45.0),
              )
            ],
          ),
        ),
        body: router(),
        drawer: Drawer(
            backgroundColor: Colors.black,
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: [
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
