import 'package:flutter/material.dart';

class Automazione extends StatefulWidget {
  const Automazione({Key? key}) : super(key: key);
  @override
  State<Automazione> createState() => _Automazione();
}

class _Automazione extends State<Automazione> {
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
          margin: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 25, bottom: 25),
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
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Automazione",
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
                    "Perché scegliere l'articolazione Automazione ?" +
                        "sono interessato a ricerca e sviluppo, voglio avere l'opportunità di misurarmi anche con il lavoro autonomo e di laboratorio" +
                        "mi affascinano la robotica, l'automazione industriale, mi piace ideare progetti e realizzarli con le mie mani" +
                        "voglio acquisire competenze nella progettazione, nella gestione dei sistemi di automazione finalizzati al controllo della robotica, della domotica e al controllo dei processi industriali" +
                        "voglio acquisire le competenze nella analisi e nella programmazione di dispositivi logici programmabili (PLC) in ambito industriale, nei fondamenti della robotica, dell'elettronica analogica e digitale, dei sistemi trifase" +
                        "voglio acquisire competenze nella progettazione e nel collaudo di azionamenti per il controllo dei motori elettrici di potenza" +
                        "voglio conseguire la giusta preparazione nello studio dei fondamenti teorici, anche in vista di un possibile proseguimento degli studi (università, corsi post-diploma)",
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
                image: AssetImage("automazione.webp"),
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
