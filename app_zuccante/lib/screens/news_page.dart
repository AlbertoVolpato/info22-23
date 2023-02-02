import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
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
                'News',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Festa di carnevale",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "dal 17/02/2023 si terrà la festa di carenvale, preparetevi sarà pieno di figa...",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
      const SizedBox(
        height: 15,
      ),
    ]));
  }
}
