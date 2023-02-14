import 'package:app_zuccante/screens/news_single.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPage();
}

class NewsList {
  final String title;
  final String data;
  final String text;
  final String link;

  NewsList(this.title, this.data, this.text, this.link);
}

class _NewsPage extends State<NewsPage> {
  bool isCharging = false;
  List<NewsList> ObjDataLists = <NewsList>[];

  @override
  void initState() {
    super.initState();
    getMediumRSSFeedData();
  }

  Future gotoNews(id) async {
    final url = 'https://www.itiszuccante.edu.it/$id';
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
  }

  Future getMediumRSSFeedData() async {
    List<NewsList> TemporaryList = <NewsList>[];

    try {
      //iniziamo a fare il get degli elementi
      setState(() {
        isCharging = true;
      });
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
            .replaceAll("<strong>", "")
            .replaceAll("</strong>", "")
            .replaceAll("<br>", "")
            .replaceAll("</br>", "")
            .replaceAll('<p class="rtejustify">', "")
            .replaceAll('&nbsp;', "");

        var link = data
            .getElementsByClassName("views-row")[i]
            .getElementsByClassName("views-field")[0]
            .getElementsByClassName("field-content")[0]
            .innerHtml;
        var links = link.split('"');
        var news_link = links[1];

        TemporaryList.add(NewsList(title, obj_data, content, news_link));
        setState(() {
          ObjDataLists = TemporaryList;
          isCharging = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget _news() {
    return isCharging == true
        ? Container(
            child: CircularProgressIndicator(),
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 3,
              left: MediaQuery.of(context).size.width / 3,
            ),
            height: MediaQuery.of(context).size.height / 7,
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: ObjDataLists.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      gotoNews(ObjDataLists[index].link);
                    },
                    child: Container(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 25,
                                ),
                                Image.asset(
                                  "news.png",
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: Text(
                                  ObjDataLists[index].title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    shadows: <Shadow>[
                                      Shadow(
                                          offset: Offset(1.2, 1.2),
                                          blurRadius: 1.0,
                                          color: Colors.grey.shade400),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "news.png",
                                  height: 30,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 25,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                Flexible(
                                    child: new Text(
                                  ObjDataLists[index].text,
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
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                Flexible(
                                    child: new Text(
                                  ObjDataLists[index].data,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    shadows: <Shadow>[
                                      Shadow(
                                          offset: Offset(1.2, 1.2),
                                          blurRadius: 1.0,
                                          color: Colors.grey.shade400),
                                    ],
                                  ),
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
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                ],
              );
            },
          );
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(0, 35, 71, 1.0),
        ),
        body: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.newspaper),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      'NEWS',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.newspaper),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _news()
          ],
        ));
  }
}
