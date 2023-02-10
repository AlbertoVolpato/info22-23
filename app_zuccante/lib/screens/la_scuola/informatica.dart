import 'package:flutter/material.dart';

class Informatica extends StatefulWidget {
  const Informatica({Key? key}) : super(key: key);
  @override
  State<Informatica> createState() => _Informatica();
}

class _Informatica extends State<Informatica> {
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 3.0,
                ),
              ],
              color: Color.fromARGB(255, 228, 230, 236),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Informatica",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Flexible(
                  child: Text(
                    "Perché scegliere Informatica ?"
                    "sono una persona creativa, sono interessato a risolvere problemi e voglio stare al centro dell'innovazione tecnologica"
                    "sono interessato a realizzare applicazioni web e per smartphone, alle telecomunicazioni ed in particolare alle tecnologie delle reti e di internet."
                    "voglio acquisire competenze nell'ambito dei sistemi informatici e dell'elaborazione dell'informazione, delle tecnologie web, delle reti e degli apparecchi di comunicazione, per collaborare, nel rispetto del quadro normativo nazionale e internazionale, nella gestione di progetti inerenti la sicurezza e la privacy delle informazioni e di comunicazione per operare autonomamente e in team"
                    "voglio acquisire competenze nell'installare, configurare e gestire sistemi di elaborazione dati e reti, collaborare, con un approccio integrato, all'ideazione, allo sviluppo, alla gestione di dispositivi e strumenti informatici e sistemi di telecomunicazioni"
                    "voglio acquisire competenze che mi consentano di sviluppare applicazioni informatiche per reti locali o servizi a distanza, e per reti mobile",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              child: Image(
                image: AssetImage("informatica.jpeg"),
                width: MediaQuery.of(context).size.width / 1.1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
