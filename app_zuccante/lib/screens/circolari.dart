import 'package:flutter/material.dart';
import 'package:app_zuccante/services/news.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Circolari extends StatefulWidget {
  const Circolari({super.key});

  @override
  State<Circolari> createState() => _Circolari();
}

class CircularList {
  final String title;
  final String protocol;
  final String categoria;
  final String pubblicato;
  final String validityuntil;
  final String documento;

  CircularList(this.title, this.protocol, this.categoria, this.pubblicato,
      this.validityuntil, this.documento);
}

class _Circolari extends State<Circolari> {
  List<CircularList> ObjDataLists = <CircularList>[];

  @override
  void initState() {
    super.initState();
    getMediumRSSFeedData();
  }

  Future getMediumRSSFeedData() async {
    List<CircularList> TemporaryList = <CircularList>[];

    try {
      //iniziamo a fare il get degli elementi
      String url =
          "https://web.spaggiari.eu/sdg/app/default/comunicati.php?sede_codice=VEIT0007&referer=https://www.itiszuccante.edu.it";
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      var data = parse(response.body);

      /// ora si converte da html ad oggetto Flutter
      ///for per prendere tutti i titoli
      for (var i = 0;
          i < data.getElementsByClassName("row-result ").length;
          i++) {
        var element = data
            .getElementsByClassName("row-result ")[i]
            .getElementsByClassName("cell-border")[1]
            .getElementsByTagName("span");
        var title = "";
        var protocol = "";
        var categoria = "";
        var pubblicato = "";
        var validityuntil = "";
        var documento = "";

        if (element.length == 4) {
          title = element[0].innerHtml;
          protocol = "";
          categoria = element[1].innerHtml;
          pubblicato = element[2].innerHtml;
          validityuntil = element[3].innerHtml;
        } else {
          title = element[0].innerHtml;
          protocol = element[1].innerHtml;
          categoria = element[3].innerHtml;
          pubblicato = element[2].innerHtml;
          validityuntil = element[4].innerHtml;
        }
        var doc_elements = data
            .getElementsByClassName("row-result ")[i]
            .getElementsByClassName("cell-border")[2]
            .innerHtml;
        var doc_element = doc_elements.split('"');
        documento = doc_element[5];

        TemporaryList.add(CircularList(
            title, protocol, categoria, pubblicato, validityuntil, documento));

        setState(() {
          ObjDataLists = TemporaryList;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future gotoCircolare(id) async {
    final url =
        'https://web.spaggiari.eu/sdg/app/default/view_documento.php?a=akVIEW_FROM_ID&id_documento=$id&sede_codice=VEIT0007';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget _circular() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: ObjDataLists.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
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
                          ObjDataLists[index].title,
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
                          "Protocollo: ${ObjDataLists[index].protocol}",
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        Flexible(
                            child: new Text(
                          "Categoria: ${ObjDataLists[index].categoria}",
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
                          "Pubblicato il: ${ObjDataLists[index].pubblicato}",
                          style: TextStyle(fontSize: 20),
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        Flexible(
                            child: new Text(
                          "Valido fino: ${ObjDataLists[index].validityuntil}",
                          style: TextStyle(fontSize: 20),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        InkWell(
                            onTap: () {
                              gotoCircolare(ObjDataLists[index].documento);
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 30,
                                child: Center(
                                    child: Text(
                                  "Documento",
                                  style: TextStyle(fontSize: 20),
                                )))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  'CIRCOLARI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _circular()
      ],
    ));
  }
}
