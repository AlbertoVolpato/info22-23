import 'package:flutter/material.dart';

class Telecomunicazioni extends StatefulWidget {
  const Telecomunicazioni({Key? key}) : super(key: key);
  @override
  State<Telecomunicazioni> createState() => _Telecomunicazioni();
}

class _Telecomunicazioni extends State<Telecomunicazioni> {
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
                    "Telecomunicazioni",
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
                    "Perché scegliere Telecomunicazioni ?"
                    "mi piacerebbe sapere come funzionano la rete telefonica cablata, il VoIP, il mobile, il broadcasting audio e video digitali, le trasmissione via satellite, il GPS, l'Internet Of Things (IOT)"
                    "mi piacerebbe sapere le proprietà, gli ambiti e le modalità di impiego dei mezzi di comunicazione moderni, come ad esempio le fibre ottiche, i protocolli di rete cablati e wireless, le modulazioni analogiche e digitali"
                    "desidero avere nozioni fondamentali di programmazione"
                    "mi piacerebbe installare e fare la manutenzione delle nuove reti per l'Internet Of Things (IOT)"
                    "mi interessa la propagazione delle onde radio, anche ad alta frequenza, svolgere esperienze di laboratorio con apparati di telecomunicazione, apprendere i processi di ricetrasmissione in real time di elementi multimediali e di dati"
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
                image: AssetImage("telecomunicazioni.png"),
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
