import 'package:flutter/material.dart';
import 'package:app_zuccante/services/news.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class NewsSingleList {
  final String title;
  final String data;
  final String text;
  final String link;

  NewsSingleList(this.title, this.data, this.text, this.link);
}
  late NewsSingleList ObjDataLists;

class NewsSingle extends StatelessWidget  {
  const NewsSingle({super.key, required this.url});
    final String url;


    Future getMediumRSSFeedData() async {
    late NewsSingleList ObjDataLists;

    try {
      //iniziamo a fare il get degli elementi
      String url = "https://www.itiszuccante.edu.it/" + this.url;
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      var data = parse(response.body);

     
    } catch (e) {
      print(e);
    }
  }

@override
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
      body:  Container(
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
                          Flexible(
                              child: Text(
                            ObjDataLists.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          Flexible(
                              child: new Text(
                            ObjDataLists.text,
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
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
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          Flexible(
                              child: new Text(
                            ObjDataLists.data,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
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
    );
  }

}
