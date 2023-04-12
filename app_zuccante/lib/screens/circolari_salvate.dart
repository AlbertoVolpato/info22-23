import 'package:app_zuccante/main.dart';
import 'package:app_zuccante/models/save_circolari.dart';
import 'package:flutter/material.dart';

class CircolariSalvate extends StatefulWidget {
  const CircolariSalvate({super.key});

  @override
  State<CircolariSalvate> createState() => _CircolariSalvate();
}

class _CircolariSalvate extends State<CircolariSalvate> {
  late Stream<List<SaveCircolare>> allCircolari;
  late var circolarilenght;
  bool isCharging = false;

  @override
  void initState() {
    super.initState();
    allCircolari = objectbox.getAllCircolari();
    print(allCircolari);
    circolarilenght = allCircolari.length;
  }

  @override
  Widget build(Object context) {
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
                      'CIRCOLARI SALVATE',
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
          ],
        ));
  }

  Widget allSalvate() {
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
            itemCount: circolarilenght,
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
                                "titolo",
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
                                "Protocollo: }",
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
                                "Categoria: }",
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
                                "Pubblicato il: }",
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
                                "Valido fino: ",
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
                                  onTap: () {},
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
                              itemCount: 0,
                              itemBuilder:
                                  (BuildContext context, int secondindex) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18),
                                  child: MaterialButton(
                                      color: Colors.green,
                                      onPressed: () {},
                                      child: Text("titoloAllegato")),
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
  }
}
