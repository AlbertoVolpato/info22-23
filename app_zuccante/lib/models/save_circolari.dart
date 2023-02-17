import 'package:app_zuccante/screens/circolari.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class SaveCircolare {
  int id;
  String title;
  String protocollo;
  String categoria;
  String link;
  DateTime pubblicazione;
  DateTime scadenza;

  SaveCircolare({
    required this.id,
    required this.title,
    required this.protocollo,
    required this.categoria,
    required this.link,
    required this.pubblicazione,
    required this.scadenza,
  });
}
