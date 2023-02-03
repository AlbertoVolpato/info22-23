import 'package:flutter/material.dart';
import 'package:app_zuccante/services/news.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  String? Response = null;
  List DataList = [];

  @override
  void initState() {
    super.initState();
    getMediumRSSFeedData();
  }

  Future getMediumRSSFeedData() async {
    var temporaryList = [];
    try {
      //iniziamo a fare il get degli elementi
      String url = "https://www.itiszuccante.edu.it/categoria/news";
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      var data = parse(response.body);
      setState(() {
        Response = response.body;
      });

      /// ora si converte da html ad oggetto Flutter
      DataList.add(data.getElementsByClassName("field-content")[0].innerHtml);
    } catch (e) {
      print(e);
    }
  }

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
      Text(DataList[0]),
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
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "Festa di carnevale",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Flexible(
                      child: new Text(
                    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          )),
      SizedBox(
        height: 15,
      ),
      const SizedBox(
        height: 15,
      ),
    ]));
  }
}
