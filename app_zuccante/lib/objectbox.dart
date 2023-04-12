import 'package:app_zuccante/models/save_circolari.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  late final Store store;
  late final Box<SaveCircolare> circolariBox;

  ObjectBox._create(this.store) {
    circolariBox = Box<SaveCircolare>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store =
        await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }

  SaveCircolare? getCircolare(int id) => circolariBox.get(id);

  Stream<List<SaveCircolare>> getAllCircolari() =>
      circolariBox.query().watch().map((query) => query.find());

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
      id: id,
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

  bool deleteCircolare(int id) => circolariBox.remove(id);
}
