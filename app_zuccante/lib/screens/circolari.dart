import 'package:app_zuccante/models/save_circolari.dart';
import 'package:app_zuccante/main.dart';
import 'package:flutter/material.dart';
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
  final List<String> titoloAllegati;
  final List<String> linkAllegati;

  CircularList(
      this.title,
      this.protocol,
      this.categoria,
      this.pubblicato,
      this.validityuntil,
      this.documento,
      this.titoloAllegati,
      this.linkAllegati);
}

class _Circolari extends State<Circolari> {
  bool isCharging = false;
  List<CircularList> ObjDataLists = <CircularList>[];

  @override
  void initState() {
    super.initState();
    getMediumRSSFeedData();
  }

  Future getMediumRSSFeedData() async {
    List<CircularList> TemporaryList = <CircularList>[];
    var circular = SaveCircolare(
      id: 1,
      title: "ciao",
      protocollo: "",
      categoria: "",
      link: "",
      titoloAllegati: ["ad", "asda"],
      linkAllegati: ["dad", "dasd"],
      pubblicazione: DateTime.parse('1969-07-20 20:18:04Z'),
      scadenza: DateTime.parse('1969-07-20 20:18:04Z'),
    );

    try {
      setState(() {
        isCharging = true;
      });
      //iniziamo a fare il get degli elementi
      String url =
          "https://web.spaggiari.eu/sdg/app/default/comunicati.php?sede_codice=VEIT0007&referer=https://www.itiszuccante.edu.it";
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      var data = parse(response.body);
      // print(data);

      /// ora si converte da html ad oggetto Flutter
      ///for per prendere tutti i titoli
      for (var i = 0;
          i < data.getElementsByClassName("row-result ").length;
          i++) {
        List<String> allegatiDiv = [];
        List<String> allegatiLink = [];

        var element = data
            .getElementsByClassName("row-result ")[i]
            .getElementsByClassName("cell-border")[1]
            .getElementsByTagName("span");
        try {
          if (data
                  .getElementsByClassName("row-result ")[i]
                  .getElementsByClassName("link-to-file")[1]
                  .innerHtml !=
              null) {
            for (var j = 0;
                j <
                    data
                        .getElementsByClassName("row-result ")[i]
                        .getElementsByClassName("link-to-file")
                        .length;
                j++) {
              if (j + 1 !=
                  data
                      .getElementsByClassName("row-result ")[i]
                      .getElementsByClassName("link-to-file")
                      .length) {
                allegatiDiv.add(data
                    .getElementsByClassName("row-result ")[i]
                    .getElementsByClassName("link-to-file")[j]
                    .innerHtml);
                allegatiLink.add(data
                    .getElementsByClassName("row-result ")[i]
                    .getElementsByClassName("link-to-file")[j]
                    .outerHtml
                    .split('"')[5]);
              }
            }
          }
        } catch (error) {
          print("ciaos");
        }

        var title = "";
        var protocol = "";
        var categoria = "";
        var pubblicato = "";
        var validityuntil = "";
        var documento = "";
        List<String> titoloAllegati = [];
        List<String> linkAllegati = [];

        if (element.length == 4) {
          title = element[0].innerHtml;
          protocol = "";
          categoria = element[1].innerHtml;
          pubblicato = element[2].innerHtml;
          validityuntil = element[4].innerHtml;
        } else {
          title = element[0].innerHtml;
          protocol = element[1].innerHtml;
          categoria = element[4].innerHtml;
          pubblicato = element[2].innerHtml;
          validityuntil = element[5].innerHtml;
        }
        titoloAllegati = allegatiDiv;
        linkAllegati = allegatiLink;
        var doc_elements = data
            .getElementsByClassName("row-result ")[i]
            .getElementsByClassName("cell-border")[2]
            .innerHtml;

        var doc_element = doc_elements.split('"');
        documento = doc_element[5];

        // print(allegati);

        TemporaryList.add(CircularList(title, protocol, categoria, pubblicato,
            validityuntil, documento, titoloAllegati, linkAllegati));

        setState(() {
          ObjDataLists = TemporaryList;
          isCharging = false;
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
                  Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 30,
                              ),
                              Image.asset(
                                "circolari.png",
                                height: 40,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Flexible(
                                  child: Text(
                                ObjDataLists[index].title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(1.2, 1.2),
                                        blurRadius: 1.0,
                                        color: Colors.grey.shade400),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: false,
                              )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 30,
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
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
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
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
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
                                "Pubblicato il: ${ObjDataLists[index].pubblicato}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(1.5, 1.5),
                                        blurRadius: 1.0,
                                        color: Colors.grey.shade400),
                                  ],
                                ),
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
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
                                width: MediaQuery.of(context).size.width / 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    gotoCircolare(
                                        ObjDataLists[index].documento);
                                  },
                                  child: Image.asset(
                                    'paper-clip.png',
                                    height: 50,
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 16,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  ObjDataLists[index].titoloAllegati.length,
                              itemBuilder:
                                  (BuildContext context, int secondindex) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18),
                                  child: MaterialButton(
                                      color: Colors.green,
                                      onPressed: () {
                                        gotoCircolare(ObjDataLists[index]
                                            .linkAllegati[secondindex]);
                                      },
                                      child: Text(
                                        ObjDataLists[index]
                                            .titoloAllegati[secondindex],
                                      )),
                                );
                              }),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
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
        body: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      'CIRCOLARI',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
