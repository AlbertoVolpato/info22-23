import 'package:flutter/material.dart';
import 'package:app_zuccante/services/news.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPage();
}

 class NewsList {
  final String title;
  final String data;
  final String text;

   NewsList(
     this.title,
     this.data,
     this.text,
   );
}

class _NewsPage extends State<NewsPage> {
  List DataList = [];

  @override
  void initState() {
    super.initState();
    getMediumRSSFeedData();
  }

  

  Future getMediumRSSFeedData() async {
    var TemporaryList = [];
        List<NewsList> list = <NewsList>[];

   
    try {
      //iniziamo a fare il get degli elementi
      String url = "https://www.itiszuccante.edu.it/categoria/news";
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      var data = parse(response.body);

      /// ora si converte da html ad oggetto Flutter
      ///for per prendere tutti i titoli
      for (var i = 0;
          i < data.getElementsByClassName("views-row").length;
          i++) {
        var views_row = data.getElementsByClassName("views-row")[i];
        var views_field = views_row.getElementsByClassName("views-field")[0];
        TemporaryList.add(views_field.getElementsByTagName("a")[0].innerHtml);
      }
      setState(() {
        DataList = TemporaryList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: DataList.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          SizedBox(height: 15,),
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
                      Flexible(
                        child: Text(
                           DataList[index],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        )
                        
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
                        DataList[index],
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
        ],
      );
    }
  );
  }
}
