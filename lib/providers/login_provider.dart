import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Plantilla de Provider para mejoras futuras
class LoginProvider extends ChangeNotifier {
  String _usuario = '';
  bool _isLoggedIn = false;

  LoginProvider() {
    _inicializarDatos();
  }

  //Getters
  String get usuario => _usuario;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String usuario, String password) async {
    // Validación simple de credenciales (hardcoded)
    if (usuario == 'admin' && password == '123') {
      _usuario = usuario;
      _isLoggedIn = true;

      // Guardar la sesión en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('usuario', usuario);
      await prefs.setBool('isLoggedIn', true);
      notifyListeners();
    } else {
      throw Exception('Credenciales incorrectas');
    }
  }

  Future<void> logout() async {
    _usuario = '';
    _isLoggedIn = false;
    // Borrar la sesión de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuario');
    await prefs.remove('isLoggedIn');
    notifyListeners();
  }

  Future<void> _inicializarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _usuario = prefs.getString('usuario') ?? '';
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }
}
