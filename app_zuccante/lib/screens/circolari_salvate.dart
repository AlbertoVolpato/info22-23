import 'package:app_zuccante/main.dart';
import 'package:app_zuccante/models/save_circolari.dart';
import 'package:flutter/material.dart';

class CircolariSalvate extends StatefulWidget {
  const CircolariSalvate({super.key});

  @override
  State<CircolariSalvate> createState() => _CircolariSalvate();
}

class _CircolariSalvate extends State<CircolariSalvate> {
  @override
  Widget build(Object context) {
    return MaterialButton(
        color: Colors.green,
        onPressed: () {
          SaveCircolare cirolare = SaveCircolare(
              id: 2,
              title: "c",
              protocollo: "",
              categoria: "categoria",
              link: "link",
              pubblicazione: DateTime(10),
              scadenza: DateTime(10),
              titoloAllegati: ["titoloAllegati"],
              linkAllegati: ["linkAllegati"]);
          objectbox.addCircolare(
              2,
              "title",
              "protocollo",
              "categoria",
              "link",
              DateTime.now(),
              DateTime.now(),
              ["titoloAllegati"],
              ["linkAllegati"]);
          print(objectbox.getAllCircolari());
        },
        child: Text("ciao"));
  }
}
