import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:flutter/material.dart';

class AgendaProvider extends ChangeNotifier {
  List<Contacto> contactos = [];
  
  AgendaProvider();


  void addContacto(Contacto contacto) {
    contactos.add(contacto);
    notifyListeners();
  }
}
