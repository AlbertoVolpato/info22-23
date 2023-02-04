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
  List<NewsList> ObjDataLists = <NewsList>[];

  @override
  void initState() {
    super.initState();
    getMediumRSSFeedData();
  }

  Future<List<NewsList>> getMediumRSSFeedData() async {
    List<NewsList> TemporaryList = <NewsList>[];

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
        var title = data
            .getElementsByClassName("views-row")[i]
            .getElementsByClassName("views-field")[0]
            .getElementsByTagName("a")[0]
            .innerHtml;
        var obj_data = data
            .getElementsByClassName("views-row")[i]
            .getElementsByClassName("views-field")[1]
            .getElementsByClassName("field-content")[0]
            .innerHtml;
        var content = data
            .getElementsByClassName("views-row")[i]
            .getElementsByClassName("views-field")[2]
            .getElementsByClassName("field-content")[0]
            .innerHtml
            .replaceAll("<h1>", "")
            .replaceAll("</h1>", "")
            .replaceAll("<h2>", "")
            .replaceAll("</h2>", "")
            .replaceAll("<h3>", "")
            .replaceAll("</h3>", "")
            .replaceAll("<p>", "")
            .replaceAll("</p>", "")
            .replaceAll('<p class="rtejustify">', "")
            .replaceAll('&nbsp;',
                "                                                                 ");
        TemporaryList.add(NewsList(title, obj_data, content));
        // TemporaryList.add(views_field.getElementsByTagName("a")[0].innerHtml);
      }
    } catch (e) {
      print(e);
    }
    return TemporaryList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsList>>(
        future: getMediumRSSFeedData(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
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
                              Flexible(
                                  child: Text(
                                snapshot.data![index].title,
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
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 20,
                              ),
                              Flexible(
                                  child: new Text(
                                snapshot.data![index].text,
                                style: TextStyle(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
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
                                snapshot.data![index].data,
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
                ],
              );
            },
          );
        });
  }
}
