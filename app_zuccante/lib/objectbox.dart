import 'package:app_zuccante/models/save_circolari.dart';
import 'package:app_zuccante/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<SaveCircolare> circolariBox;

  ObjectBox._create(this.store) {
    circolariBox = Box<SaveCircolare>(store);

    if (circolariBox.isEmpty()) {
      _putDataDemo();
    }
  }
  void _putDataDemo() {
    SaveCircolare cirolare = SaveCircolare(
        id: 2,
        title: "c",
        protocollo: "",
        categoria: "categoria",
        link: "link",
        pubblicazione: DateTime(10),
        scadenza: DateTime(10),
        titoloAllegati: ["titoloAllegati"],
        linkAllegati: ["linkAllegati"]);
    circolariBox.put(cirolare);
  }

  List<SaveCircolare> getAllCircolari() {
    var allCircolari = circolariBox.getAll();
    return allCircolari;
  }

  void addCircolare(
      int id,
      String title,
      String protocollo,
      String categoria,
      String link,
      DateTime pubblicazione,
      DateTime scadenza,
      List<String> titoloAllegati,
      List<String> linkAllegati) {
    SaveCircolare cirolare = SaveCircolare(
      id: 2,
      title: title,
      protocollo: protocollo,
      categoria: categoria,
      link: link,
      pubblicazione: pubblicazione,
      scadenza: scadenza,
      titoloAllegati: titoloAllegati,
      linkAllegati: linkAllegati,
    );
    circolariBox.put(cirolare);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
