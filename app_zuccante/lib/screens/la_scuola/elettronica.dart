import 'package:flutter/material.dart';

class Elettronica extends StatefulWidget {
  const Elettronica({Key? key}) : super(key: key);
  @override
  State<Elettronica> createState() => _Elettronica();
}

class _Elettronica extends State<Elettronica> {
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
                    "Elettronica",
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
                    "A partire dall’anno scolastico 2023-2024, nell’ambito dell’autonomia scolastica, l’Istituto Tecnico CARLO ZUCCANTE attiverà all'interno del corso di Elettronica un approfondimento sui temi dell'elettronica applicata all'ambito biomedico. Maggiori informazioni possono essere trovate nella presentazione del corso."
                    "Studentesse? Certamente!"
                    "Il PNRR 2022 prevede una linea di finanziamento su nuove competenze e nuovi linguaggi, con l’obiettivo di garantire pari opportunità e uguaglianza di genere in termini didattici e di orientamento, rispetto alle materie STEM (acronimo di Scienze, Tecnologia, Ingegneria e Matematica)."
                    "Lo studio pubblicato da Psychological Science nel 2018 “The Gender-Equality Paradox in Science, Technology, Engineering, and Mathematics Education” (ovvero STEM), ad opera di Gijsbert Stoet della Leeds Beckett University e David Geary dell'Università del Missouri, realizzato utilizzando un database internazionale sui risultati ottenuti degli adolescenti in materie STEM, dimostra che le ragazze hanno risultati simili o migliori rispetto ai ragazzi nelle scienze in due paesi su tre tra quelli esaminati ma poi, in quasi tutti i paesi, il numero delle ragazze che potrebbero intraprendere e concludere con successo un percorso universitario in ambito STEM è inferiore al numero delle studentesse effettivamente iscritte."
                    "L’ambito biomedico, al quale il corso di elettronica guarda con interesse, si comporta in controtendenza: le ragazze immatricolate al corso di Ingegneria Biomedica all’Università di Padova nell’anno accademico 2019-2020 sono state più dei colleghi maschi (155 contro 150) e negli anni successivi la proporzione è rimasta stabile attorno al 50%.",
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
                image: AssetImage("elettronica.jpeg"),
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
