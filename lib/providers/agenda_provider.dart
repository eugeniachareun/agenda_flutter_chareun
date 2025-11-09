import 'package:agenda_flutter_chareun/database/contactos_db_helper.dart';
import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:flutter/material.dart';

class AgendaProvider extends ChangeNotifier {
  late Contacto? contacto;
  List<Contacto> _contactos = [];
  List<Contacto> get contactos => _contactos;

  AgendaProvider();

  void limpiar() {
    contacto = null;
    _contactos = <Contacto>[];
    notifyListeners();
  }

  ///------------------
  /// CRUD CON SQLITE
  /// Se trabaja con la lista en memoria y con la tabla de SQLite
  ///------------------
  void cargarContactos() async {
    _contactos = await ContactosDBHelper.getContactos();
    notifyListeners();
  }

  void addContacto(Contacto contacto) async {
    await ContactosDBHelper.insertContacto(contacto);
    _contactos.add(contacto);
    notifyListeners();
  }

  void actualizarContacto(Contacto contacto) async {
    await ContactosDBHelper.updateContacto(contacto);
    _contactos = await ContactosDBHelper.getContactos();
    notifyListeners();
  }

  void eliminarContacto(int id) async {
    await ContactosDBHelper.deleteContacto(id);
    _contactos = await ContactosDBHelper.getContactos();
    notifyListeners();
  }
}
