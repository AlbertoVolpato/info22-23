import 'package:flutter/material.dart';

class Contatti extends StatefulWidget {
  const Contatti({super.key});

  @override
  State<Contatti> createState() => _Contatti();
}

class _Contatti extends State<Contatti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  'CONTATTI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 15,
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
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Icon(Icons.phone),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Flexible(
                child: Text(
                  'telefono: 041-5341046',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 15,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Icon(Icons.mail),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Flexible(
                child: Text(
                  'E-mail: vetf04000t@istruzione.it',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 13,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Icon(Icons.mark_email_read),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Flexible(
                child: Text(
                  'Posta certificata: vetf04000t@pec.istruzione.it',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 10,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Icon(Icons.document_scanner),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Flexible(
                child: Text(
                  'Richiesta certificati: leggere le indicazioni disponibili qui e completare il modulo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 4,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Icon(Icons.contact_phone),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Flexible(
                child: Text(
                  "Segreteria Didattica: ricevimento del pubblico in presenza sospeso, telefonicamente dal lunedì al sabato dalle 12:00 alle 13:00 preferibile inviare una email all'indirizzo didattica@itiszuccante.edu.it",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
