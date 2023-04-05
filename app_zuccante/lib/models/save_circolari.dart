import 'dart:core';
import 'package:objectbox/objectbox.dart';

@Entity()
class SaveCircolare {
  @Id()
  int id = 0;
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

  void put(SaveCircolare cirolare) {}
}
