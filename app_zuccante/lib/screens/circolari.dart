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

  CircularList(this.title, this.protocol, this.categoria, this.pubblicato,
      this.validityuntil, this.documento);
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
                                width: MediaQuery.of(context).size.width / 20,
                              ),
                              Flexible(
                                  child: Text(
                                ObjDataLists[index].title,
                                style: TextStyle(
                                    //color: Color.fromARGB(255, 203, 14, 0),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
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
                                    color: Color.fromRGBO(0, 35, 71, 1.0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
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
                                    color: Color.fromRGBO(0, 35, 71, 1.0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
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
        backgroundColor: Colors.white,
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
