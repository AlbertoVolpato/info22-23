import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class NewsSingle extends StatefulWidget {
  final String url;
  const NewsSingle({Key? key, required this.url}) : super(key: key);
  @override
  State<NewsSingle> createState() => _NewsSingle();
}

class _NewsSingle extends State<NewsSingle> {
  String day = "";
  String title = "";
  String subtitleh1 = "";
  String subtitleh3 = "";
  String content = "";
  String img = "";

  void initState() {
    super.initState();
    getNewsData();
  }

  Future getNewsData() async {
    String _day = "";
    String _day1 = "";
    String _day3 = "";
    String _title = "";
    String _subtitleh1 = "";
    String? _subtitleh3 = "";
    String _content = "";
    String _img = "";

    try {
      //iniziamo a fare il get degli elementi
      String url = "https://www.itiszuccante.edu.it${widget.url}";
      print(url);
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      var data = parse(response.body);
      _title = data
          .getElementsByClassName("content-inner")[0]
          .getElementsByClassName("breadcrumb")[0]
          .innerHtml;

      _subtitleh1 = data
          .getElementsByClassName("field-item")[1]
          .getElementsByTagName("h1")[0]
          .innerHtml;
      try {
        _subtitleh3 = data
            .getElementsByClassName("field-item")[1]
            .getElementsByTagName("h3")[0]
            .innerHtml;
      } catch (e) {
        _subtitleh3 = "";
      }
      _day = data
          .getElementsByClassName("node-submitted")[0]
          .innerHtml
          .replaceAll("<", "")
          .replaceAll(">", "")
          .replaceAll("span", "")
          .replaceAll('class="username"', "")
          .replaceAll('redazione/', "redazione");

      try {
        _img = data
            .getElementsByClassName("field-item")[1]
            .getElementsByTagName("p")[1]
            .innerHtml;
      } catch (e) {
        _img = data
            .getElementsByClassName("field-item")[1]
            .getElementsByTagName("p")[3]
            .innerHtml;
      }
      var parsedimg = _img.split('"');

      _content = data
          .getElementsByClassName("field-item")[1]
          .getElementsByTagName("p")[0]
          .innerHtml;

      setState(() {
        title = _title;
        subtitleh1 = _subtitleh1;
        subtitleh3 = _subtitleh3!;
        day = _day;
        content = _content;
        img = parsedimg[3];
      });
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
                    title,
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
                    subtitleh3,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Flexible(
                  child: Text(
                    subtitleh1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Flexible(
                  child: Text(
                    content,
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
                image: NetworkImage('https://www.itiszuccante.edu.it' + img),
                width: MediaQuery.of(context).size.width / 1.1,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    day,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
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
