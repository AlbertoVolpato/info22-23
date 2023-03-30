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
  List<String> titoloAllegati;
  List<String> linkAllegati;

  SaveCircolare({
    required this.id,
    required this.title,
    required this.protocollo,
    required this.categoria,
    required this.link,
    required this.pubblicazione,
    required this.scadenza,
    required this.titoloAllegati,
    required this.linkAllegati,
  });
}
