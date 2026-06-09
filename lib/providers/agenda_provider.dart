import 'package:agenda_flutter_chareun/client/agenda_api.dart';
import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:flutter/material.dart';

class AgendaProvider extends ChangeNotifier {
  late Contacto? contacto;
  List<Contacto> _contactos = [];
  List<Contacto> get contactos => _contactos;

  final AgendaApi _api;
  String? error;

  AgendaProvider({AgendaApi? api}) : _api = api ?? AgendaApi();

  void limpiar() {
    contacto = null;
    _contactos = <Contacto>[];
    notifyListeners();
  }

  void cargarContactos() async {
     try {
      final contactsFromApi = await _api.getAll();

      _contactos
        ..clear()
        ..addAll(contactsFromApi);
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void addContacto(Contacto contacto) async {
    try {
      await _api.create(contacto);
      final todos = await _api.getAll();

      _contactos
        ..clear()
        ..addAll(todos);

    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void actualizarContacto(Contacto contacto) async {
    try {
      await _api.update(contacto);
      final todos = await _api.getAll();

      _contactos
        ..clear()
        ..addAll(todos);
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void eliminarContacto(int id) async {
    try {
      await _api.delete(id);
      final todos = await _api.getAll();

      _contactos
        ..clear()
        ..addAll(todos);
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
