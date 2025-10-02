import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:flutter/material.dart';

class AgendaProvider extends ChangeNotifier {
  late Contacto? contacto;
  List<Contacto> contactos = [];
  
  AgendaProvider();


  void addContacto(Contacto contacto) {
    contactos.add(contacto);
    notifyListeners();
  }

  void limpiar() {
    contacto = null;
    contactos = <Contacto>[];
    notifyListeners();
  }
}
